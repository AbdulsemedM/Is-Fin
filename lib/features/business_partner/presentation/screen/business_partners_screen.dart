import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/business_partner/bloc/providers_bloc.dart';
import 'package:ifb_loan/features/business_partner/presentation/screen/add_bisiness_partner_screen.dart';
import 'package:ifb_loan/features/business_partner/presentation/widget/business_partners_card.dart';
import 'package:ifb_loan/features/loan_application/bloc/loan_app_bloc.dart';

class BusinessPartnersScreen extends StatefulWidget {
  const BusinessPartnersScreen({super.key});

  @override
  State<BusinessPartnersScreen> createState() => _BusinessPartnersScreenState();
}

class _BusinessPartnersScreenState extends State<BusinessPartnersScreen> {
  var loading = false;
  List<Map<String, String>> myProviders = [];
  @override
  void initState() {
    super.initState();
    context.read<ProvidersBloc>().add(ProviderFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddBisinessPartnerScreen(),
            ),
          );
          // print("here is the result");
          // print(result.runtimeType);
          // if (result != null) {
          //   print("here is the result");
          //   print(result.runtimeType);
          //   context.read<ProvidersBloc>().add(ProviderFetch());
          // }
        },
        child: const CircleAvatar(
          backgroundColor: AppColors.primaryDarkColor,
          radius: 30,
          child: Icon(
            size: 35,
            Icons.add_outlined,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Business Partners",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocListener<ProvidersBloc, ProvidersState>(
        listener: (context, state) {
          if (state is ProviderFetchLoading) {
            setState(() {
              loading = true;
            });
          } else if (state is ProviderFetchSuccess) {
            context
                .read<LoanAppBloc>()
                .add(UpdateProvidersEvent(state.providers));
            // print("sent from the business page");
            setState(() {
              loading = false;
              myProviders = state.providers;
            });
          } else if (state is ProviderFetchFailure) {
            setState(() {
              loading = false;
              displaySnack(context, state.errorMessage, Colors.red);
            });
          }
        },
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : myProviders.isEmpty
                ? Center(
                    child: Text(
                    textAlign: TextAlign.center,
                    "No Business Partners Found, Press the + button to add",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ))
                : SingleChildScrollView(
                    child: Column(
                      children: myProviders
                          .map(
                            (provider) => BusinessPartnersCard(
                              name: provider['fullName'] ?? "Unknown",
                              id: provider['phoneNumber'] ?? "N/A",
                              onAccept: () {
                                // Handle Accept Action
                                print("Accepted: ${provider['fullName']}");
                              },
                              onReject: () {
                                // Handle Reject Action
                                print("Rejected: ${provider['fullName']}");
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
      ),
    );
  }
}
