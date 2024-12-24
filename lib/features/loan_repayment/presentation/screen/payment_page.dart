import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/loan_repayment/bloc/loan_repayment_bloc.dart';
import 'package:ifb_loan/features/repayment/presentation/screen/reciept_screen.dart';

class PaymentPage extends StatefulWidget {
  final String loanId;
  const PaymentPage({super.key, required this.loanId});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final myKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Page",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                "Payment Instructions",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                          "- Add the amount of birr you want to pay in the amount field"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                          "- Then click on the pay button to make the payment"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                          "- After the payment is successful, you will be redirected to the payment success page"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                          "- There you can see and save the payment details and the status of the payment"),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Form(
                key: myKey,
                child: TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: AppDecorations.getAppInputDecoration(
                    lableText: 'Amount (ETB)',
                    myBorder: false,
                    // pIconData: Icons.phone_android,
                    hintText: 'Amount (ETB)',
                    context: context,
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Amount is required';
                    } else if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value!)) {
                      return 'Amount must contain only numbers or decimals';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: BlocConsumer<LoanRepaymentBloc, LoanRepaymentState>(
                  listener: (context, state) {
                    if (state is LoanRepaymentPaymentLoading) {
                      setState(() {
                        loading = true;
                      });
                    } else if (state is LoanRepaymentPaymentSuccess) {
                      setState(() {
                        loading = false;
                      });
                      print(state.transactionId);
                      context
                          .read<LoanRepaymentBloc>()
                          .add(GetRepaymentHistoryEvent());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReceiptPage(
                                  transactionId: state.transactionId,
                                  customerName: state.customerName,
                                  amount:
                                      double.parse(state.amount.toString()))));
                    } else if (state is LoanRepaymentPaymentFailure) {
                      setState(() {
                        loading = false;
                      });
                      displaySnack(context, state.errorMessage, Colors.red);
                    }
                  },
                  builder: (context, state) => MyButton(
                    height: ScreenConfig.screenHeight * 0.055,
                    width: ScreenConfig.screenWidth,
                    backgroundColor: loading
                        ? AppColors.iconColor
                        : AppColors.primaryDarkColor,
                    onPressed: loading
                        ? () {}
                        : () async {
                            if (myKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Confirm Payment"),
                                  content:
                                      Text("Are you sure you want to pay?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<LoanRepaymentBloc>().add(
                                            MakePaymentEvent(
                                                loanId: widget.loanId,
                                                amount: amountController.text));
                                        Navigator.pop(context);
                                      },
                                      child: Text("Confirm"),
                                    ),
                                  ],
                                ),
                              );
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
                            "PAY",
                            style: TextStyle(color: AppColors.bg1),
                          ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
