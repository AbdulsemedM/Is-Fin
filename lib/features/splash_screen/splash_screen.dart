import 'package:flutter/material.dart';
// import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
// import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/login/presentation/screen/login_screen.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    // Delaying navigation to LoginScreen for demonstration
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  // final String? _dropdownValue = 'en'; // Default language is English
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ScreenConfig.init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            Opacity(
              opacity: 0.3,
              child: SizedBox.expand(
                child: Image.asset(
                  "assets/images/backgound.png", // Replace with your background image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Foreground Content
            Column(
              children: [
                SizedBox(
                  height: ScreenConfig.screenHeight * 0.18,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        height: ScreenConfig.screenHeight * 0.08,
                        child: Image.asset("assets/images/Alhuda-Logo.png"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenConfig.screenHeight * 0.02),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        height: ScreenConfig.screenHeight * 0.05,
                        child: Image.asset("assets/images/Rizq.png"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenConfig.screenHeight * 0.02),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "Welcome to",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenConfig.screenHeight * 0.03),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "RIZQ",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                color: AppColors.primaryDarkColor,
                                fontSize: 50),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenConfig.screenHeight * 0.07,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //           color: Colors.black, width: 1.5), // Black border
                //       borderRadius: BorderRadius.circular(5), // Rounded corners
                //     ),
                //     child: DropdownButtonFormField<String>(
                //       hint: Text(
                //         "Choose Language",
                //         style: Theme.of(context).textTheme.bodyMedium,
                //       ),
                //       dropdownColor: AppColors.greyColor,
                //       value: _dropdownValue,
                //       decoration: InputDecoration(
                //         // labelText: 'Business Type',
                //         filled: true,
                //         fillColor: Colors.transparent,
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(8.0),
                //           borderSide: BorderSide.none,
                //         ),
                //       ),
                //       items: const [
                //         DropdownMenuItem(
                //           value: 'en',
                //           child: Text('English'),
                //         ),
                //         DropdownMenuItem(
                //           value: 'fr',
                //           child: Text('Afaan Oromoo'),
                //         ),
                //         DropdownMenuItem(
                //           value: 'es',
                //           child: Text('Amharic'),
                //         ),
                //         DropdownMenuItem(
                //           value: 'de',
                //           child: Text('Afaan Somaali'),
                //         ),
                //         // Add more languages as needed
                //       ],
                //       onChanged: (value) {
                //         // Handle value change
                //       },
                //     ),
                //     // DropdownButton<String>(
                //     //   value: _dropdownValue, // Set default value
                //     //   isExpanded: true,
                //     //   hint: Text(
                //     //     "Choose Language",
                //     //     style: Theme.of(context).textTheme.bodyMedium,
                //     //   ),
                //     //   icon: const Icon(Icons.arrow_drop_down_outlined),
                //     //   elevation: 16,
                //     //   style: Theme.of(context).textTheme.titleMedium,
                //     //   underline: Container(
                //     //     color: Colors.transparent,
                //     //   ),
                //     //   onChanged: (String? value) {
                //     //     setState(() {
                //     //       _dropdownValue = value;
                //     //     });
                //     //   },
                //     //   items: const [
                //     //     DropdownMenuItem(
                //     //       value: 'en',
                //     //       child: Text('English'),
                //     //     ),
                //     //     DropdownMenuItem(
                //     //       value: 'fr',
                //     //       child: Text('Afaan Oromoo'),
                //     //     ),
                //     //     DropdownMenuItem(
                //     //       value: 'es',
                //     //       child: Text('Amharic'),
                //     //     ),
                //     //     DropdownMenuItem(
                //     //       value: 'de',
                //     //       child: Text('Afaan Somaali'),
                //     //     ),
                //     //     // Add more languages as needed
                //     //   ],
                //     // ),
                //   ),
                // ),
                SizedBox(
                  height: ScreenConfig.screenHeight * 0.03,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 15.0),
                //       child: MyButton(
                //           // height: ScreenConfig.screenHeight * 0.06,
                //           width: ScreenConfig.screenWidth * 0.5,
                //           backgroundColor: loading
                //               ? AppColors.iconColor
                //               : AppColors.primaryDarkColor,
                //           onPressed: loading
                //               ? () {}
                //               : () {
                //                   //  Delaying navigation to LoginScreen for demonstration
                //                   setState(() {
                //                     loading = true;
                //                   });
                //                   Future.delayed(const Duration(seconds: 4),
                //                       () {
                //                     Navigator.pushReplacement(
                //                         context,
                //                         MaterialPageRoute(
                //                             builder: (context) =>
                //                                 const LoginScreen()));
                //                   });
                //                 },
                //           buttonText: loading
                //               ? SizedBox(
                //                   height: ScreenConfig.screenHeight * 0.02,
                //                   width: ScreenConfig.screenHeight * 0.02,
                //                   child: const CircularProgressIndicator(
                //                     strokeWidth: 3,
                //                     color: AppColors.primaryColor,
                //                   ),
                //                 )
                //               : const Text(
                //                   "Next",
                //                   style: TextStyle(color: Colors.white),
                //                 )),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: ScreenConfig.screenHeight * 0.16,
                ),
                // CircularProgressIndicator(
                //   color: AppColors.primaryDarkColor,
                // ),
                // Text(
                //   "Loading",
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
