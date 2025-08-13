import 'package:flutter/material.dart';
import 'dart:math' as math;

class InfinityLoadingIndicator extends StatefulWidget {
  final double size;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Duration duration;

  const InfinityLoadingIndicator({
    super.key,
    this.size = 80.0,
    this.primaryColor,
    this.secondaryColor,
    this.duration = const Duration(milliseconds: 2000),
  });

  @override
  State<InfinityLoadingIndicator> createState() =>
      _InfinityLoadingIndicatorState();
}

class _InfinityLoadingIndicatorState extends State<InfinityLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: InfinityPainter(
                animationValue: _animation.value,
                primaryColor: widget.primaryColor ??
                    const Color.fromARGB(255, 4, 182, 253),
                secondaryColor: widget.secondaryColor ??
                    const Color.fromARGB(255, 0, 255, 255),
              ),
            );
          },
        ),
      ),
    );
  }
}

class InfinityPainter extends CustomPainter {
  final double animationValue;
  final Color primaryColor;
  final Color secondaryColor;

  InfinityPainter({
    required this.animationValue,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.22;

    // Create the infinity symbol path
    final path = _createInfinityPath(center, radius);

    // Draw the background stroke (very subtle)
    final backgroundPaint = Paint()
      ..color = primaryColor.withOpacity(0.08)
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, backgroundPaint);

    // Draw the main animated gradient stroke
    final gradientPaint = Paint()
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Create gradient based on animation position - more pronounced effect
    final gradient = LinearGradient(
      colors: [
        primaryColor.withOpacity(0.3),
        primaryColor,
        secondaryColor,
        primaryColor,
        primaryColor.withOpacity(0.3),
      ],
      stops: [
        (animationValue - 0.5).clamp(0.0, 1.0),
        (animationValue - 0.25).clamp(0.0, 1.0),
        animationValue,
        (animationValue + 0.25).clamp(0.0, 1.0),
        (animationValue + 0.5).clamp(0.0, 1.0),
      ],
    );

    // Apply gradient to paint
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    gradientPaint.shader = gradient.createShader(rect);

    // Draw the animated stroke
    canvas.drawPath(path, gradientPaint);

    // Add stronger glow effect like the reference
    final glowPaint = Paint()
      ..color = primaryColor.withOpacity(0.6)
      ..strokeWidth = 12.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

    canvas.drawPath(path, glowPaint);

    // Add inner highlight effect
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, highlightPaint);
  }

  Path _createInfinityPath(Offset center, double radius) {
    // Create a more accurate infinity symbol like the reference
    final path = Path();

    // Calculate the centers for the two loops
    final leftCenter = Offset(center.dx - radius * 0.65, center.dy);
    final rightCenter = Offset(center.dx + radius * 0.65, center.dy);

    // Loop radius - slightly smaller for better proportions
    final loopRadius = radius * 0.45;

    // Create the left loop (counter-clockwise)
    final leftRect = Rect.fromCircle(center: leftCenter, radius: loopRadius);
    path.addArc(leftRect, -math.pi / 2, -2 * math.pi);

    // Create the right loop (clockwise)
    final rightRect = Rect.fromCircle(center: rightCenter, radius: loopRadius);
    path.addArc(rightRect, -math.pi / 2, 2 * math.pi);

    return path;
  }

  @override
  bool shouldRepaint(InfinityPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor;
  }
}
