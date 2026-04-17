import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static void init() {
    // _firebaseMessaging.onTokenRefresh.listen(_saveFcmToken);
  }

  static Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  // Future<void> setFcmToken() async {
  //   final fcmToken = await _firebaseMessaging.getToken();
  //   if (fcmToken != null) {
  //     await _saveFcmToken(fcmToken);
  //   }
  // }

  // Future<void> _saveFcmToken(String fcmToken) async {
  //   await _supabase.from('profiles').upsert({
  //     'id': _supabase.auth.currentUser!.id,
  //     'fcm_token': fcmToken,
  //   });
  // }
}
