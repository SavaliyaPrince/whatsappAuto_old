import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/my_behavior.dart';
import 'package:whatsapp_auto/modules/homePageCantroller.dart';
import 'package:whatsapp_auto/modules/homepage/home_page.dart';
import 'package:whatsapp_auto/modules/homepage/welcome_message/welcome_message.dart';
import 'package:whatsapp_auto/splashScreen.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/bottom_navigation_bar.dart';

import 'modules/homepage/welcome_message/welcome_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () async {
      //   WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      //   await Future.delayed(const Duration(milliseconds: 200));
      // },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp Auto',
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
        initialBinding: AppBidding(),
        initialRoute: SplashScreen.routeName,
        theme: ThemeData(
          fontFamily: AppString.fonts,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            textTheme: TextTheme(
              headline6: TextStyle(
                  color: Colors.black, fontSize: 18, fontFamily: "Customtext"),
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        getPages: [
          GetPage(
            name: SplashScreen.routeName,
            page: () => const SplashScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: Bottom.routeName,
            page: () => Bottom(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: HomePageScreen.routeName,
            page: () => const HomePageScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: WelcomeMessage.routeName,
            page: () => WelcomeMessage(),
            transition: Transition.rightToLeft,
          ),
        ],
      ),
    );
  }
}

class AppBidding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomePageController());
    Get.put(WelcomeController());
  }
}
