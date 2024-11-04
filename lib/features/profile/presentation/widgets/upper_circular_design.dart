import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // First curve (bottom-most)
    final paint1 = Paint()
      ..color = const Color.fromARGB(255, 245, 225, 195)
      ..style = PaintingStyle.fill;
    final path1 = Path();
    path1.lineTo(0, size.height * 0.6);
    path1.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.6);
    path1.lineTo(size.width, 0);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Second curve (middle)
    final paint2 = Paint()
      ..color = const Color.fromARGB(255, 231, 157, 82)
      ..style = PaintingStyle.fill;
    final path2 = Path();
    path2.lineTo(0, size.height * 0.4);
    path2.quadraticBezierTo(
        size.width / 2, size.height * 0.8, size.width, size.height * 0.4);
    path2.lineTo(size.width, 0);
    path2.close();
    canvas.drawPath(path2, paint2);

    // Third curve (top-most)
    final paint3 = Paint()
      ..color = AppColors.primaryDarkColor
      ..style = PaintingStyle.fill;
    final path3 = Path();
    path3.lineTo(0, size.height * 0.2);
    path3.quadraticBezierTo(
        size.width / 2, size.height * 0.6, size.width, size.height * 0.2);
    path3.lineTo(size.width, 0);
    path3.close();
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
