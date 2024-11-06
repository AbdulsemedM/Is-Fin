import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';

class MyButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final Widget buttonText;

  const MyButton({
    Key? key,
    this.height,
    this.width,
    required this.backgroundColor,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? ScreenConfig.screenHeight * 0.055,
      width: width ?? ScreenConfig.screenWidth * 0.9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: buttonText,
      ),
    );
  }
}
