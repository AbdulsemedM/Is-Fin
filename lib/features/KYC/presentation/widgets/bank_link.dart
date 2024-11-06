import 'package:flutter/material.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/bank_account_widget.dart';

class BankLink extends StatefulWidget {
  const BankLink({super.key});

  @override
  State<BankLink> createState() => _BankLinkState();
}

class _BankLinkState extends State<BankLink> {
  var loading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Complete all the fields below"),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Account Number',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyButton(
                    backgroundColor: loading
                        ? AppColors.iconColor
                        : AppColors.primaryDarkColor,
                    onPressed: loading
                        ? () {}
                        : () {
                            setState(() {
                              loading = true;
                            });
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
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          )),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Divider(),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'OTP',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyButton(
                    backgroundColor: loading
                        ? AppColors.iconColor
                        : AppColors.primaryDarkColor,
                    onPressed: loading
                        ? () {}
                        : () {
                            setState(() {
                              loading = true;
                            });
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
                            "Add",
                            style: TextStyle(color: Colors.white),
                          )),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Divider(),
          ),
          AccountCard(
            name: 'Abdulsemed Mussema',
            id: '1022200133387',
            onAccept: () {
              // Handle accept action
            },
            onReject: () {
              // Handle reject action
            },
          ),
        ],
      ),
    );
  }
}
