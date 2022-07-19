import 'package:get/get.dart';
import 'package:whatsapp_auto/modules/homepage/home_page.dart';
import 'package:whatsapp_auto/modules/send_massage/send_massage_page.dart';
import 'package:whatsapp_auto/modules/setting_page/setting_page.dart';
import 'package:whatsapp_auto/modules/setting_page/widget/Advance_setting/advance_setting_page.dart';
import 'package:whatsapp_auto/modules/setting_page/widget/appearance/appearance.dart';
import 'package:whatsapp_auto/modules/setting_page/widget/auto_reply_message_sent/auto_reply_massege_page.dart';
import 'package:whatsapp_auto/splashScreen.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  static const String splash = '/splash';
  static const String homePage = "/homePage";
  static const String settingPage = "/settingPage";
  static const String autoReplyMassage = "/autoReplyMassage";
  static const String appearance = "/appearance";
  static const String sendMassagePage = "/sendMassagePage";
  static const String asPage = "/asPage";

  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: defaultTransition,
    ),
    GetPage(
      name: homePage,
      page: () => HomePageScreen(),
      transition: defaultTransition,
    ),
    GetPage(
      name: settingPage,
      page: () => SettingPage(),
      transition: defaultTransition,
    ),
    GetPage(
      name: autoReplyMassage,
      page: () => AutoReply(),
      transition: defaultTransition,
    ),
    GetPage(
      name: appearance,
      page: () => AppearancePage(),
      transition: defaultTransition,
    ),
    GetPage(
      name: sendMassagePage,
      page: () => SendMassagePage(),
      transition: defaultTransition,
    ),
    GetPage(
      name: asPage,
      page: () => ASpage(),
      transition: defaultTransition,
    ),
  ];
}
