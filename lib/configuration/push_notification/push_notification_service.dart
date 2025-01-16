import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_api_availability/google_api_availability.dart';

class PushNotificationService {
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

   Future<String?> generateDeviceRecognitionToken() async {
    int retryCount = 0;

    while (retryCount < _maxRetries) {
      try {
        await Firebase.initializeApp();
        
        // Check Google Play Services availability
        final googlePlayServices = await GoogleApiAvailability.instance.checkGooglePlayServicesAvailability();
        if (googlePlayServices != GooglePlayServicesAvailability.success) {
          debugPrint('Google Play Services not available: $googlePlayServices');
          return null;
        }

        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          debugPrint('FCM Token successfully generated: $fcmToken');
          return fcmToken;
        }
        
        throw Exception('FCM token is null');

      } catch (e) {
        retryCount++;
        debugPrint('Attempt $retryCount failed. Error: $e');
        
        if (retryCount < _maxRetries) {
          debugPrint('Retrying in ${_retryDelay.inSeconds} seconds...');
          await Future.delayed(_retryDelay);
        } else {
          debugPrint('All retry attempts failed');
          return null;
        }
      }
    }
    return null;
  }

  startListeningForNewNotifications(BuildContext context) async {
    ///1. Terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMsg) {
      if (remoteMsg != null) {
        String? title = remoteMsg.data['title'];
        print('Terminated Notification: $title');
      }
    });

    ///2. Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMsg) {
      String? title = remoteMsg.data['title'];
      print('Foreground Notification: $title');
    });

    ///3. Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMsg) {
      String? title = remoteMsg.data['title'];
      print('Background Notification: $title');
    });
  }
}
