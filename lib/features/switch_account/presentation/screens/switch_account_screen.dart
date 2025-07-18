import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/features/switch_account/bloc/account_bloc.dart';
import 'package:ifb_loan/features/switch_account/models/account_model.dart';
import '../widgets/wallet_card_widget.dart';
import '../widgets/wallet_shimmer_widget.dart';
import 'add_ebirr_account_screen.dart';

class SwitchAccountScreen extends StatefulWidget {
  const SwitchAccountScreen({super.key});

  @override
  State<SwitchAccountScreen> createState() => _SwitchAccountScreenState();
}

class _SwitchAccountScreenState extends State<SwitchAccountScreen> {
  int _selectedWalletIndex = 0;
  bool _hasSelectedActiveAccount = false;
  List<AccountModel>? _accounts;

  @override
  void initState() {
    super.initState();
    // First fetch linked accounts
    context.read<AccountBloc>().add(FetchAccountsEvent());
  }

  void _handleWalletSelection(int index) {
    setState(() {
      _selectedWalletIndex = index;
    });
  }

  String _getImagePathForAccount(AccountModel account) {
    final type = account.accountType.toLowerCase();
    if (type.contains('ebirr')) {
      return 'assets/images/e-birr.png';
    }
    return 'assets/images/coop.png';
  }

  void _navigateToAddAccount() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddEbirrAccountScreen()),
    );

    // If account was added successfully, refresh the accounts list
    if (result == true) {
      setState(() {
        _accounts = null; // Reset accounts to show loading state
        _hasSelectedActiveAccount = false; // Reset selection
      });
      context.read<AccountBloc>().add(FetchAccountsEvent());
    }
  }

  // Find and select the active account
  void _selectActiveAccount(
      List<AccountModel> accounts, String activeAccountType) {
    if (!_hasSelectedActiveAccount) {
      int activeIndex = -1;
      final type = activeAccountType.toLowerCase();

      if (type.contains('cbo')) {
        activeIndex = 0;
      } else if (type.contains('ebirr')) {
        activeIndex = accounts.indexWhere(
            (account) => account.accountType.toLowerCase().contains('ebirr'));
      }

      if (activeIndex != -1) {
        setState(() {
          _selectedWalletIndex = activeIndex;
          _hasSelectedActiveAccount = true;
        });
      }
    }
  }

  Widget _buildAddAccountButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _navigateToAddAccount,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add_circle_outline,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add E-Birr Account',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Link your E-Birr account for easy access',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is FetchAccountsLoaded) {
              setState(() {
                _accounts = state.accounts;
              });
              // After accounts are loaded, fetch active account
              context.read<AccountBloc>().add(FetchActiveAccountEvent());
            } else if (state is FetchActiveAccountLoaded) {
              if (_accounts != null) {
                _selectActiveAccount(
                    _accounts!, state.activeAccount.accountType);
              }
            } else if (state is SwitchAccountLoaded) {
              Navigator.pop(context);
            } else if (state is SwitchAccountError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Switch Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Choose the account you want to make the deposit',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          if (_accounts != null && _accounts!.length == 1)
                            _buildAddAccountButton(),
                          Expanded(
                            child: _accounts == null
                                ? GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: 0.75,
                                    ),
                                    itemCount: 2,
                                    itemBuilder: (context, index) {
                                      return const WalletShimmerWidget();
                                    },
                                  )
                                : GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: 0.75,
                                    ),
                                    itemCount: _accounts!.length,
                                    itemBuilder: (context, index) {
                                      final account = _accounts![index];
                                      return WalletCardWidget(
                                        walletName: account.accountHolderName,
                                        walletType: account.accountType,
                                        accountNumber: account.accountNumber,
                                        assetImage:
                                            _getImagePathForAccount(account),
                                        isSelected:
                                            _selectedWalletIndex == index,
                                        onTap: () =>
                                            _handleWalletSelection(index),
                                      );
                                    },
                                  ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _accounts != null
                                  ? () {
                                      final selectedAccount =
                                          _accounts![_selectedWalletIndex];
                                      context.read<AccountBloc>().add(
                                            SwitchAccountEvent(
                                                selectedAccount.accountType),
                                          );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Switch Account',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
