import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/my_behavior.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/homepage/homePageCantroller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference.initMySharedPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
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
          theme: ThemeData(
            fontFamily: AppString.fonts,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            brightness: homePageController.isSwitched.value
                ? Brightness.dark
                : Brightness.light,
            // appBarTheme: const AppBarTheme(
            //   backgroundColor: AppColor.appBarColors,
            //   // textTheme: TextTheme(
            //   //   headline6: TextStyle(
            //   //     color: Colors.black,
            //   //     fontSize: 18,
            //   //     fontFamily: "Customtext",
            //   //   ),
            //   // ),
            //   // iconTheme: IconThemeData(color: Colors.black),
            // ),
          ),
          initialRoute: Routes.splash,
          getPages: Routes.pages,
        ),
      ),
    );
  }
}

final ThemeData _darkTheme = ThemeData(
  fontFamily: AppString.fonts,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColor.appBackgroundColor,
    // textTheme: TextTheme(
    //   headline6: TextStyle(
    //     color: AppColor.whiteColor,
    //     fontSize: 18,
    //     fontFamily: "Customtext",
    //   ),
    // ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
);

final ThemeData _lightTheme = ThemeData(
  fontFamily: AppString.fonts,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColor.appBarColors,
    // textTheme: TextTheme(
    //   headline6: TextStyle(
    //     color: Colors.black,
    //     fontSize: 18,
    //     fontFamily: "Customtext",
    //   ),
    // ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
);

class AppBidding implements Bindings {
  @override
  void dependencies() {
    // Get.put(HomePageController());
  }
}
