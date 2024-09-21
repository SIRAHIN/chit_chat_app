import 'package:chat_app_using_firebase/routes/routes_name.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
 

 // Checking Permission Setting //
  static Future<void> requestUserPermission() async {
    // Check if the permission has been already granted
    NotificationSettings currentSettings =
        await messaging.getNotificationSettings();

    print("------- $currentSettings");

    if (currentSettings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      print("------- notDetermined");
      // Request permission only if not determined
      NotificationSettings notificationSettings =
          await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false, // Optional: Disable features you don't need
        criticalAlert: false,
        provisional: false, // Disable provisional permission
      );

      if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.authorized) {
        Get.snackbar('Notification', 'User granted notification permission',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      } else if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        Get.snackbar(
            'Notification', 'User granted provisional notification permission',
            backgroundColor: Colors.orange,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Notification', 'User denied notification permission',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Notification', 'Notification permission already handled',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  //Function to Init Notification //
  static Future<void> initNotification() async {
    //requestUserPermission();
    await messaging.requestPermission();

    // Fetch The FCM token //
    final fcmToken = await messaging.getToken();

    // printing Token //
    print('Token ------------ : $fcmToken');

    // Go to That On Notificaiton Page //
    await onNotifications();
  }
  
  // Handel the notification Routes //
  static void handelNotificationRoutes(RemoteMessage? messages) {
    if (messages == null) return;
    Get.toNamed(RoutesName.homeView);
  }

  // function to initialize background settings //
  static Future onNotifications() async {
  messaging.getInitialMessage().then(handelNotificationRoutes);
    FirebaseMessaging.onMessageOpenedApp.listen(handelNotificationRoutes);
  }
}
