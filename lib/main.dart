import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:whatsapp_auto/Utils/my_behavior.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/helper/admanag.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/create_reply_page/create_reply_controller.dart';
import 'package:whatsapp_auto/modules/homepage/homePageCantroller.dart';
import 'package:whatsapp_auto/modules/send_massage/send_message_controller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';

import 'modules/setting_page/widget/push_notification/push_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseRemoteConfigUtils.initMethod();
  final FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  runZonedGuarded<Future<void>>(() async {
    await crashlytics.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = crashlytics.recordFlutterError;
    await AppPreference.initMySharedPreferences();
    MobileAds.instance.initialize();
    FirebaseMessagingUtils().init();
    runApp(MyApp());
  }, (error, stack) => crashlytics.recordError(error, stack));
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await AppPreference.initMySharedPreferences();
//   MobileAds.instance.initialize();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () async {
      //   WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      //   await Future.delayed(const Duration(milliseconds: 200));
      // },
      child: GetMaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: themeController.setTheme(),
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp Auto',
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
        initialBinding: AppBidding(),
        initialRoute: Routes.splash,
        getPages: Routes.pages,
      ),
    );
  }
}

class AppBidding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomePageController());
    Get.put(SendMessageController());
    Get.put(CreateReplyController());
  }
}
