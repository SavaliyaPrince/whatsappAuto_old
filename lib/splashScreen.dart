import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/interstitial_ad.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/Utils/open_ad.dart';
import 'package:whatsapp_auto/theme/app_color.dart';

import 'Utils/size_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AppOpenAdManager.loadAd();
    InterstitalAd.createInterstitialAd();
    startTimeOut();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Stack(
      children: [
        Container(
          color: AppColor.primaryColor,
          // decoration:  const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(AppString.splashScreen),
          //     fit: BoxFit.fill,
          //   ),
          // ),
          child: Center(
            child: SizedBox(
              width: SizeUtils.horizontalBlockSize * 37,
              child: Image.asset(
                AssetsPath.appLogoNew,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void startTimeOut() {
    Timer(
      const Duration(seconds: 3),
      () {
        // AppOpenAdManager.showOpenAdIfAvailable();
        InterstitalAd.createInterstitialAd();
        Navigation.pushNamed(Routes.homePage);
        print("---splashscreen---");
      },
    );
  }
}
