import 'package:flutter/material.dart';
import 'package:ifb_loan/core/services/background_timeout_service.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;

  const BaseScreen({super.key, required this.child});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  void _updateUserActivity() {
    BackgroundTimeoutService.updateLastActiveTime();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) => _updateUserActivity(),
      onPanDown: (_) => _updateUserActivity(),
      child: widget.child,
    );
  }
}
