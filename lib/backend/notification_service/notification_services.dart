import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  void requestNotificationPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("permission accesed");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("permission provisioned");
    } else {
      print("permission denied");
    }
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title.toString());
      print(message.notification!.body.toString());
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    return token!;
  }

  void isRefreshToken() {
    firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
      print('refersh token');
    });
  }
}
