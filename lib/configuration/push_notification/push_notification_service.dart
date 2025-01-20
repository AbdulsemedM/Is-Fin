import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);
  static const storage = FlutterSecureStorage();
  static const String FCM_TOKEN_KEY = 'fcmToken';

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

    // First try to get the token from storage
    String? storedToken = await storage.read(key: FCM_TOKEN_KEY);
    if (storedToken != null && storedToken.isNotEmpty) {
      debugPrint('Retrieved FCM Token from storage: $storedToken');
      return storedToken;
    }

    while (retryCount < _maxRetries) {
      try {
        await Firebase.initializeApp();

        final googlePlayServices = await GoogleApiAvailability.instance
            .checkGooglePlayServicesAvailability();
        if (googlePlayServices != GooglePlayServicesAvailability.success) {
          debugPrint('Google Play Services not available: $googlePlayServices');
          return null;
        }

        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null && fcmToken.isNotEmpty) {
          // Store FCM token in secure storage
          await storage.write(key: FCM_TOKEN_KEY, value: fcmToken);
          debugPrint('FCM Token generated and stored: $fcmToken');

          // Verify storage
          final verifyToken = await storage.read(key: FCM_TOKEN_KEY);
          debugPrint('Verified stored token: $verifyToken');

          return fcmToken;
        }

        throw Exception('FCM token is null or empty');
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

  // Add a method to explicitly get the stored token
  static Future<String?> getStoredToken() async {
    try {
      final token = await storage.read(key: FCM_TOKEN_KEY);
      debugPrint('Retrieved stored FCM token: $token');
      return token;
    } catch (e) {
      debugPrint('Error retrieving stored FCM token: $e');
      return null;
    }
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
