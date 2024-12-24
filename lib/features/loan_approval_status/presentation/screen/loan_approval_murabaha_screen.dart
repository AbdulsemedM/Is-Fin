import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/loan_approval_status/bloc/loan_approval_status_bloc.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/pdf_dialog.dart';
import 'package:lottie/lottie.dart';

class LoanApprovalMurabahaScreen extends StatefulWidget {
  final String murabahaAgreementDocument;
  final String id;
  const LoanApprovalMurabahaScreen({
    super.key,
    required this.murabahaAgreementDocument,
    required this.id,
  });

  @override
  State<LoanApprovalMurabahaScreen> createState() =>
      _LoanApprovalMurabahaScreenState();
}

class _LoanApprovalMurabahaScreenState extends State<LoanApprovalMurabahaScreen>
    with SingleTickerProviderStateMixin {
  String originalPrice = '0';
  String markUp = '0';
  String repaymentPlan = '0';
  String supplierName = '0';
  bool isLoading = false;
  Color _backgroundColor = Colors.blue[50]!;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    context
        .read<LoanApprovalStatusBloc>()
        .add(FetchMurabahaAgreement(id: widget.id));
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _startBackgroundAnimation();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startBackgroundAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _backgroundColor = Colors.orange[100]!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        title: Text(
          'Murabaha Agreement',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocListener<LoanApprovalStatusBloc, LoanApprovalStatusState>(
        listener: (context, state) {
          if (state is FetchMurabahaAgreementSuccess) {
            setState(() {
              isLoading = false;
              originalPrice = state.murabahaAgreement.originalPrice;
              markUp = state.murabahaAgreement.markUp;
              repaymentPlan = state.murabahaAgreement.repaymentPlan;
              supplierName = state.murabahaAgreement.supplierName;
            });
          } else if (state is FetchMurabahaAgreementFailure) {
            displaySnack(context, state.errorMessage, Colors.red);
            Navigator.pop(context);
          } else if (state is FetchMurabahaAgreementLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is AcceptMurabahaOfferLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is AcceptMurabahaOfferSuccess) {
            setState(() {
              isLoading = false;
            });
            displaySnack(context, state.message, Colors.black);
            context
                .read<LoanApprovalStatusBloc>()
                .add(FetchLoanApprovalStatusList());
            Navigator.pop(context);
          } else if (state is AcceptMurabahaOfferFailure) {
            setState(() {
              isLoading = false;
            });
            displaySnack(context, state.errorMessage, Colors.red);
          }
        },
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                color: _backgroundColor,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : FadeTransition(
                            opacity: _fadeAnimation,
                            child: ScaleTransition(
                              scale: _scaleAnimation,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    'assets/animation/congrats.json',
                                    height: 200,
                                    repeat: true,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildCongratulationsCard(),
                                  const SizedBox(height: 32),
                                  _buildProceedButton(),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildCongratulationsCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.orange[50]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Congratulations!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Your loan application from $supplierName has been approved by the product owner and the bank officials.",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    const TextSpan(
                        text: "The total price as the owner gives is "),
                    TextSpan(
                      text: "ETB $originalPrice",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const TextSpan(
                        text:
                            ", then the bank has added its benefits to the product price, making the final offer "),
                    TextSpan(
                      text:
                          "ETB ${double.parse(markUp) + double.parse(originalPrice)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(text: " in $repaymentPlan repayment duration."),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Now, you must accept this offer and pick your product from the owner as soon as possible.",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProceedButton() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_controller.value * 0.05),
          child: MyButton(
            height: ScreenConfig.screenHeight * 0.055,
            width: ScreenConfig.screenWidth,
            backgroundColor:
                isLoading ? AppColors.iconColor : AppColors.primaryDarkColor,
            onPressed: isLoading
                ? () {}
                : () async {
                    bool result = await _showPdfDialog(
                        context, widget.murabahaAgreementDocument);
                    if (result && mounted) {
                      // Store context in local variable
                      final currentContext = context;
                      currentContext.read<LoanApprovalStatusBloc>().add(
                          AcceptMurabahaOffer(
                              id: widget.id, status: "APPROVED"));
                    } else if (result == false) {
                      final currentContext = context;
                      currentContext.read<LoanApprovalStatusBloc>().add(
                          AcceptMurabahaOffer(
                              id: widget.id, status: "REJECTED"));
                    }
                  },
            buttonText: isLoading
                ? SizedBox(
                    height: ScreenConfig.screenHeight * 0.02,
                    width: ScreenConfig.screenHeight * 0.02,
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColors.primaryColor,
                    ),
                  )
                : const Text(
                    "Accept Offer",
                    style: TextStyle(color: AppColors.bg1),
                  ),
          ),
        );
      },
    );
  }

  Future<bool> _showPdfDialog(BuildContext context, String pdfUrl) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return PdfDialog(
          pdfUrl: pdfUrl,
          onAccept: () {
            Navigator.pop(context, true);
          },
          onReject: () {
            Navigator.pop(context, false);
          },
        );
      },
    );

    return result ?? false;
  }
}
