import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final Widget buttonText;

  const MyButton({
    Key? key,
    required this.height,
    required this.width,
    required this.backgroundColor,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
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
