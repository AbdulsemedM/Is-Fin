import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class BackgroundTimeoutService {
  static const storage = FlutterSecureStorage();
  static DateTime? _lastActiveTime;
  static Timer? _backgroundTimer;
  static const int _timeoutMinutes = 1;
  static bool _shouldLogout = false;

  static void startBackgroundTimer() {
    _backgroundTimer?.cancel();
    _backgroundTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _checkTimeout();
    });
  }

  static void stopBackgroundTimer() {
    _backgroundTimer?.cancel();
  }

  static void updateLastActiveTime() {
    _lastActiveTime = DateTime.now();
  }

  static Future<void> _checkTimeout() async {
    if (_lastActiveTime == null) return;

    final difference = DateTime.now().difference(_lastActiveTime!);
    if (difference.inMinutes >= _timeoutMinutes) {
      await _handleTimeout();
    }
  }

  static Future<void> _handleTimeout() async {
    try {
      debugPrint('Handling timeout - starting logout process');
      stopBackgroundTimer();
      await storage.deleteAll();
      _shouldLogout = true;
      // Close the app
      debugPrint('Closing app due to timeout');
      await Future.delayed(const Duration(milliseconds: 10));
      // ignore: use_build_context_synchronously
      SystemNavigator.pop();
    } catch (e) {
      debugPrint('Error during timeout handling: $e');
    }
  }

  static Future<void> checkAndNavigateIfNeeded() async {
    if (_shouldLogout) {
      debugPrint('Performing delayed navigation to login');
      _shouldLogout = false;
      Get.offAllNamed('/login');
    }
  }
}
