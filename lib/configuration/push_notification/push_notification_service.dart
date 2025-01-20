import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

  static Future<void> initializeNotifications() async {
    // Create high importance channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    // Create the channel
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<String?> generateDeviceRecognitionToken() async {
    int retryCount = 0;

    while (retryCount < _maxRetries) {
      try {
        await Firebase.initializeApp();

        // Check Google Play Services availability
        final googlePlayServices = await GoogleApiAvailability.instance
            .checkGooglePlayServicesAvailability();
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
    await initializeNotifications(); // Initialize notification channel

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

      RemoteNotification? notification = remoteMsg.notification;
      AndroidNotification? android = remoteMsg.notification?.android;

      if (notification != null && android != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              channelDescription:
                  'This channel is used for important notifications.',
              importance: Importance.high,
              priority: Priority.high,
              playSound: true,
              enableVibration: true,
            ),
          ),
        );
      }
    });

    ///3. Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMsg) {
      String? title = remoteMsg.data['title'];
      print('Background Notification: $title');
    });
  }
}
