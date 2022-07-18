import 'package:get/get.dart';
import 'package:whatsapp_auto/modules/homepage/home_page.dart';
import 'package:whatsapp_auto/modules/setting_page/setting_page.dart';
import 'package:whatsapp_auto/modules/setting_page/widget/auto_reply_message_sent/auto_reply_massege_page.dart';
import 'package:whatsapp_auto/splashScreen.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  static const String splash = '/splash';
  static const String homePage = "/homePage";
  static const String settingPage = "/settingPage";
  static const String autoReplyMassage = "/autoReplyMassage";

  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: defaultTransition,
    ),
    GetPage(
      name: homePage,
      page: () => const HomePageScreen(),
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
  ];
}
