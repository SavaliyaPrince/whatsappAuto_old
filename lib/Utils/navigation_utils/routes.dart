import 'package:get/get.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/contact_list_page.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_page.dart';
import 'package:whatsapp_auto/modules/contact_page/group_page/group_page.dart';
import 'package:whatsapp_auto/modules/homepage/home_page.dart';
import 'package:whatsapp_auto/modules/send_massage/send_massage_page.dart';
import 'package:whatsapp_auto/modules/setting_page/setting_page.dart';
import 'package:whatsapp_auto/modules/setting_page/widget/Advance_setting/advance_setting_page.dart';
import 'package:whatsapp_auto/modules/setting_page/widget/appearance/appearance.dart';
import 'package:whatsapp_auto/modules/setting_page/widget/auto_reply_message_sent/auto_reply_massege_page.dart';
import 'package:whatsapp_auto/modules/supportedapp_page/supportedapp_page.dart';
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
  static const String supportedApp = "/supportedApp";
  static const String contactPage = "/contactPage";
  static const String groupsSettingPage = "/groupsSettingPage";
  static const String contactListPage = "/contactListPage";

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
    GetPage(
      name: supportedApp,
      page: () => SupportedAppPage(),
      transition: defaultTransition,
    ),
    GetPage(
      name: contactPage,
      page: () => ContactPage(),
      transition: defaultTransition,
    ),
    GetPage(
      name: groupsSettingPage,
      page: () => GroupsSettingsPage(),
      transition: defaultTransition,
    ),
    GetPage(
      name: contactListPage,
      page: () => ContactListPage(),
      transition: defaultTransition,
    ),
  ];
}
