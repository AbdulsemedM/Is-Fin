import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<String?> generateDeviceRecognitionToken() async {
    final deviceRecognitionToken = await _firebaseMessaging.getToken();
    DataBaseReference ref = FirebaseDatabase.instance.ref();
    
  }
}
