import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';

class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontFamily: "Poppins",
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryTextColor),
        displayMedium: TextStyle(
            fontSize: 24.0,
            fontStyle: FontStyle.italic,
            color: AppColors.primaryTextColor),
        displaySmall: TextStyle(
            fontStyle: FontStyle.italic, color: AppColors.primaryTextColor),
        bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
        bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey),
        bodySmall: TextStyle(fontSize: 14.0, color: Colors.grey),
      ),
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: textStyle(),
        toolbarTextStyle: textStyle(),
        systemOverlayStyle: SystemUiOverlayStyle.dark);
  }

  static TextStyle textStyle() {
    return const TextStyle(
        color: AppColors.primaryTextColor, fontSize: 14, fontFamily: 'Poppins');
  }
}
