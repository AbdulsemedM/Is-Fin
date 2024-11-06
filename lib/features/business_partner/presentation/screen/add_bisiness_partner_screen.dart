import 'package:flutter/material.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/business_partner/presentation/widget/url_card_widget.dart';

class AddBisinessPartnerScreen extends StatefulWidget {
  const AddBisinessPartnerScreen({super.key});

  @override
  State<AddBisinessPartnerScreen> createState() =>
      _AddBisinessPartnerScreenState();
}

class _AddBisinessPartnerScreenState extends State<AddBisinessPartnerScreen> {
  var loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Business Partner",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Business Partne\'s Phone Number',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MyButton(
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
                          "Verify Partner",
                          style: TextStyle(color: Colors.white),
                        )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Divider(),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Partners Name',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Partne\'s Phone Number',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MyButton(
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                    "If your business partner is not registered you can invite them to join the platform by the following link or you can fill all the KYC on behalf of them by clicking the bottom button and let them join the platform and just accept the loan term and conditions"),
              ),
              UrlCard(
                url:
                    'https://play.google.com/store/apps/details?id=com.example.app',
                onShare: () {
                  // Define share functionality here
                },
              ),
              SizedBox(height: 24),
              MyButton(
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
                          "Register your Partner",
                          style: TextStyle(color: Colors.white),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
