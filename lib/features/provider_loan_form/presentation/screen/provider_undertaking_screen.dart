import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/pdf_dialog.dart';
import 'package:ifb_loan/features/provider_loan_form/bloc/provider_loan_form_bloc.dart';
import 'package:lottie/lottie.dart';

class ProviderUndertakingScreen extends StatefulWidget {
  final String id;
  final String undertakingAgreementtDocument;
  // final String agentAgreementDocument;

  const ProviderUndertakingScreen({
    super.key,
    required this.id,
    required this.undertakingAgreementtDocument,
    // required this.agentAgreementDocument
  });

  @override
  State<ProviderUndertakingScreen> createState() =>
      _ProviderUndertakingScreenState();
}

class _ProviderUndertakingScreenState extends State<ProviderUndertakingScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
      ),
      backgroundColor: Colors.orange[100],
      body: BlocListener<ProviderLoanFormBloc, ProviderLoanFormState>(
        listener: (context, state) {
          if (state is AcceptUnderTakingAndagentAgreementLoading) {
            setState(() {
              loading = true;
            });
          } else if (state is AcceptUnderTakingAndAgentAgreementSuccess) {
            setState(() {
              loading = false;
            });
            displaySnack(context, state.message, Colors.black);
            context
                .read<ProviderLoanFormBloc>()
                .add(FetchProviderLoanFormList());
            Navigator.pop(context);
          } else if (state is AcceptUnderTakingAndAgentAgreementFailure) {
            setState(() {
              loading = false;
            });
            displaySnack(context, state.errorMessage, Colors.red);
          }
        },
        child: Stack(
          children: [
            // Background Animation
            Positioned.fill(
              child: Lottie.asset('assets/animation/background.json',
                  fit: BoxFit.cover, repeat: false),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Step 1: Sign Agreement
                  Lottie.asset(
                    'assets/animation/done.json',
                    height: 200,
                    repeat: true,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Step 1: Earmark the product',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "Mark the product requested for a finance to ensure it's reserved for the customer until the process is completed.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Step 2: Sign Agreements',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Sign the product undertaking agreement to proceed.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Step 2: Product Transfer
                  const SizedBox(height: 20),
                  const Text(
                    'Step 3: Transfer Product',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Provide the product to the buyer on behalf of the bank to finalize the finance.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Finalize Button
                  MyButton(
                    height: ScreenConfig.screenHeight * 0.055,
                    width: ScreenConfig.screenWidth,
                    backgroundColor: loading
                        ? AppColors.iconColor
                        : AppColors.primaryDarkColor,
                    onPressed: loading
                        ? () {}
                        : () async {
                            final result1 = await showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.orange[100],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                                Icons.label_important_outline,
                                                color: Colors.deepOrange),
                                          ),
                                          const SizedBox(width: 12),
                                          const Expanded(
                                            child: Text(
                                              "Earmark Product",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Lottie.asset(
                                            'assets/animation/earmark1.json',
                                            height: 150,
                                            repeat: true,
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            "Have you earmarked the product?",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            "Please ensure the product is reserved before proceeding with the finance process.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black54,
                                              height: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.orange,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: const Text(
                                            "Yes, Proceed",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                      actionsPadding: const EdgeInsets.fromLTRB(
                                          16, 0, 16, 16),
                                    ));
                            if (result1) {
                              final result2 = await _showPdfDialog(context,
                                  widget.undertakingAgreementtDocument);
                              if (result2) {
                                context.read<ProviderLoanFormBloc>().add(
                                    AcceptUnderTakingAndagentAgreement(
                                        widget.id, "APPROVED"));
                              } else {
                                setState(() {
                                  loading = false;
                                });
                              }
                            }
                          },
                    buttonText: loading
                        ? SizedBox(
                            height: ScreenConfig.screenHeight * 0.02,
                            width: ScreenConfig.screenHeight * 0.02,
                            child: const CircularProgressIndicator(
                              strokeWidth: 3,
                              color: AppColors.primaryColor,
                            ),
                          )
                        : const Text(
                            "Finalize Finance Process",
                            style: TextStyle(color: AppColors.bg1),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
