import 'package:get/get.dart';
import 'package:whatsapp_auto/modules/homepage/home_page.dart';
import 'package:whatsapp_auto/splashScreen.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  // get started
  static const String splash = '/splash';
  static const String homePage = "/homePage";

  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: homePage,
      page: () => const HomePageScreen(),
      transition: Transition.rightToLeft,
    ),

    // GetPage(
    //   name: Bottom.routeName,
    //   page: () => Bottom(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: HomePageScreen.routeName,
    //   page: () => const HomePageScreen(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: WelcomeMessage.routeName,
    //   page: () => WelcomeMessage(),
    //   transition: Transition.rightToLeft,
    // ),
  ];
}
