import 'package:flutter/material.dart';

import 'dart:async';

Future<void> displaySnack(
    BuildContext context, String message, Color? bgColor) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 1000),
    content: Text(message),
    backgroundColor: bgColor ?? const Color(0xFF121814),
  ));
}

Future<void> displaySnackWithAction(BuildContext context, String message,
    String actionText, Function onAction, Color? bgColor) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: bgColor ?? const Color(0xFF121814),
    action: SnackBarAction(
      label: actionText,
      onPressed: () {
        onAction();
      },
    ),
  ));
}
