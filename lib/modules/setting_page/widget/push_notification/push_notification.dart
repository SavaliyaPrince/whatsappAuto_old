import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/modules/setting_page/setting_page.dart';

class FirebaseMessagingUtils {
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool isSelectPage = false;

  ///channel id in Firebase -> Cloud Messaging -> Additional options -> Android Notification Channel ma (cloud messaging last step)
  AndroidNotificationChannel? channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.max,
  );
  Future<void> init() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        final RemoteNotification? notification = message.notification;
        final AndroidNotification? android = message.notification?.android;
        // notificationCounter = notificationCounter + 1 ;
        // FlutterAppBadger.updateBadgeCount(notificationCounter);
        // final bool isBadgeSupported = await FlutterAppBadger.isAppBadgeSupported();
        //    final bool isBadgeSupported = await FlutterAppBadger.isAppBadgeSupported();
        //   print("isAppBadgeSupported22 :- $isBadgeSupported");
        if (notification != null && android != null && !kIsWeb) {
          // isSelectPage = selectPage(message);
          final RemoteNotification? notification = message.notification;
          final androidPlatformChannelSpecifics = AndroidNotificationDetails(
            channel!.id,
            channel!.name,
            // channel!.description,
            icon: 'launch_background',
            playSound: true,
            enableVibration: true,
            importance: Importance.max,
            priority: Priority.high,
          );
          const iOSPlatformChannelSpecifics = IOSNotificationDetails();
          final platformChannelSpecifics = NotificationDetails(
              android: androidPlatformChannelSpecifics,
              iOS: iOSPlatformChannelSpecifics);

          await flutterLocalNotificationsPlugin!.show(
              notification.hashCode,
              notification?.title.toString(),
              notification?.body.toString(),
              platformChannelSpecifics,
              payload: message.data['screeDetails']);
          // await flutterLocalNotificationsPlugin!.show(
          //   notification.hashCode,
          //   notification.title,
          //   notification.body,
          //   NotificationDetails(
          //     android: AndroidNotificationDetails(
          //       channel!.id,
          //       channel!.name,
          //       channelDescription: channel!.description,
          //
          //       /// app_icon.png must be include in Android>app>src>main>res>drawable folder
          //       icon: 'app_icon',
          //     ),
          //   ),
          // );
        }
        firebaseMessaging.requestPermission(
          sound: true,
          badge: true,
          alert: true,
          provisional: false,
        );
        if (message.data["body"] != null) {
          final String messageString = message.data["body"];
          log("messageString ;-$messageString");
        }
      },
    );
    FirebaseMessaging.onBackgroundMessage((message) async {
      log("bg msg");
      // notificationCounter = notificationCounter + 1 ;
      // FlutterAppBadger.updateBadgeCount(notificationCounter);
      if (!kIsWeb) {
        channel = const AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          description: 'This channel is used for important notifications.',
          // description
          importance: Importance.high,
        );
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

        /// Create an Android Notification Channel.
        /// We use this channel in the `AndroidManifest.xml` file to override the
        /// default FCM channel to enable heads up notifications.
        await flutterLocalNotificationsPlugin!
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel!);

        /// Update the iOS foreground notification presentation options to allow
        /// heads up notifications.
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
    });

    ///app background ma open hoy tyare
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      ///for open specific screen when user click on notification
      if (message.data["page"] ==
          "example") //firebase cloud messaging ->Additional options -> key : value hoy aema key=page and value=example
      {
        Get.to(SettingPage());
      }
    });

    /// app terminated hoy ae code in home's initstate
    final String? token = await FirebaseMessaging.instance.getToken();
    log('token----$token');
    firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      provisional: false,
    );
    initializeNotification();
  }

  Future<void> initializeNotification() async {
    try {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      const initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      const initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      const initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await flutterLocalNotificationsPlugin!.initialize(initializationSettings,
          onSelectNotification: onSelectNotification);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> onSelectNotification(String? payload) async {}
}
