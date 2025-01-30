import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/loan_approval_status/bloc/loan_approval_status_bloc.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/pdf_dialog.dart';
import 'package:intl/intl.dart';
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
          'Murabaha Agreement'.tr,
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
                "Congratulations!".tr,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "This finance application has been approved by the product owner and the bank officials."
                    .tr,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(text: "The total price as the owner gives is ".tr),
                    TextSpan(
                      text: "ETB ".tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: NumberFormat('#,###.##')
                          .format(double.parse(originalPrice)),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                        text:
                            ", then the bank has added its benefits to the product price, making the final offer "
                                .tr),
                    TextSpan(
                      text: "ETB ".tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: NumberFormat('#,###.##').format(
                          double.parse(markUp) + double.parse(originalPrice)),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(text: " in ".tr),
                    TextSpan(text: repaymentPlan),
                    TextSpan(text: " days payment duration.".tr),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Now, you must accept this offer and pick your product from the owner as soon as possible."
                    .tr,
                style: const TextStyle(fontSize: 16),
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
                    bool accept = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.shopping_bag_rounded,
                                size: 40,
                                color: Colors.blue.shade700,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Pick your product".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                  ),
                            ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.store_rounded,
                                      color: Colors.blue.shade700,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        "Are you sure you are ready to pick your product?"
                                            .tr,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline_rounded,
                                      color: Colors.orange.shade700,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        "Please ensure you are at the product pickup location and ready to sign the Murabaha agreement."
                                            .tr,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.close_rounded,
                                        color: Colors.grey.shade700,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Not Ready".tr,
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    backgroundColor: Colors.blue.shade700,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "I'm Ready".tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        contentPadding:
                            const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        actionsPadding:
                            const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      ),
                    );
                    if (accept) {
                      bool result = await _showPdfDialog(
                          context, widget.murabahaAgreementDocument);
                      if (result && mounted) {
                        // Store context in local variable
                        final currentContext = context;
                        currentContext.read<LoanApprovalStatusBloc>().add(
                            AcceptMurabahaOffer(
                                id: widget.id, status: "APPROVED"));
                      }
                      // else if (result == false) {
                      // final currentContext = context;
                      // currentContext.read<LoanApprovalStatusBloc>().add(
                      //     AcceptMurabahaOffer(
                      //         id: widget.id, status: "REJECTED"));
                      // }
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
                : Text(
                    "Accept Offer".tr,
                    style: const TextStyle(color: AppColors.bg1),
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
