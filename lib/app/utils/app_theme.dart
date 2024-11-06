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
              // fontStyle: FontStyle.italic,
              color: AppColors.primaryTextColor),
          displaySmall: TextStyle(
              fontSize: 20,
              // fontStyle: FontStyle.italic,
              color: AppColors.primaryTextColor),
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black),
          bodySmall: TextStyle(fontSize: 12.0, color: Colors.black),
        ),
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: appBarTheme());
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      backgroundColor: Colors.white,
      // color: AppColors.primaryDarkColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: textStyle(),
      toolbarTextStyle: textStyle(),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryDarkColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  static TextStyle textStyle() {
    return const TextStyle(
        color: AppColors.primaryTextColor, fontSize: 14, fontFamily: 'Poppins');
  }
}

class ScreenConfig {
  // Static variables to store screen height and width
  static late double screenWidth;
  static late double screenHeight;

  // Initialize method to set width and height
  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}

class AppDecorations {
  static InputDecoration getAppInputDecoration(
      {IconData? sIconData,
      IconData? pIconData,
      String? hintText,
      String? lableText,
      required bool myBorder,
      required BuildContext context}) {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.greyColor,
      // focusedBorder: InputBorder.none,
      enabledBorder: myBorder
          ? const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 2.0, color: AppColors.primaryDarkColor))
          : InputBorder.none,
      focusedBorder: myBorder
          ? const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 2.0, color: AppColors.primaryDarkColor))
          : InputBorder.none,
      hintText: hintText,
      labelText: lableText,
      labelStyle: Theme.of(context).textTheme.bodySmall,

      // GoogleFonts.roboto(
      //     color: AppColors.primaryDarkColor,
      //     fontSize: 16,
      //     fontWeight: FontWeight.w400),
      prefixIconColor: AppColors.iconColor,
      suffixIconColor: AppColors.iconColor,
      prefixIcon: pIconData != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(pIconData),
            )
          : null,
      suffixIcon: sIconData != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(sIconData),
            )
          : null,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    );
  }
}
