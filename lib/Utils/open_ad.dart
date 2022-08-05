import 'dart:developer';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:whatsapp_auto/helper/admanag.dart';

class AppOpenAdManager {
  static AppOpenAd? appOpenAd;
  static bool isShowingAd = false;
  static bool isLoaded = false;

  static final String appOpenId = FirebaseRemoteConfigUtils.appOpenId;
  static final String iosOpenId = FirebaseRemoteConfigUtils.iosOpenId;

  static Future<void> loadAd() async {
    print("appopenId----$appOpenId");
    print("iosOpenId----$iosOpenId");
    AppOpenAd.load(
      adUnitId: Platform.isAndroid ? appOpenId : iosOpenId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print("Open Ad Loaded........");
          appOpenAd = ad;
          isLoaded = true;
        },
        onAdFailedToLoad: (e) {
          log("open ad Error--->${e.toString()}");
          loadAd();
        },
      ),
    );
  }

  // Whether an ad is available to be shown.
  static bool get isAdAvailable {
    return appOpenAd != null;
  }

  static void showOpenAdIfAvailable() {
    log("Open add Called=============");
    if (appOpenAd == null) {
      log('Tried to show ad before available.');
      loadAd();
      return;
    }
    if (isShowingAd) {
      log('Tried to show ad while already showing an ad.');
      return;
    }
    appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        isShowingAd = true;
        appOpenAd = ad;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        isShowingAd = false;
        ad.dispose();
        appOpenAd = null;
        loadAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent');
        isShowingAd = false;
        ad.dispose();
        appOpenAd = null;
        loadAd();
      },
    );
    appOpenAd!.show();
    appOpenAd = null;
  }
}
