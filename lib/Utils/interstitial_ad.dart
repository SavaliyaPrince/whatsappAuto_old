import 'dart:developer';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitalAd {
  static InterstitialAd? _interstitialAd;
  static int maxFailedLoadAttempts = 3;
  static int _numInterstitialLoadAttempts = 0;

  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  // @override
  // void initState() {
  //   createInterstitialAd();
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _interstitialAd?.dispose();
  //   super.dispose();
  // }

  // @override
  // InterstitialAd myInterstitial = InterstitialAd(
  //   adUnitId: Platform.isAndroid
  //       ? 'ca-app-pub-3940256099942544~3347511713'
  //       : '', //and:ca-app-pub-3940256099942544/6300978111,
  //   request: request,
  //   listener: AdListener(
  //     onAdLoaded: (Ad ad) {
  //       print('${ad.runtimeType} loaded.');
  //       _interstitialReady = true;
  //     },
  //     onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //       print('${ad.runtimeType} failed to load: $error.');
  //       ad.dispose();
  //       _interstitialAd = null;
  //       createInterstitialAd();
  //     },
  //     onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
  //     onAdClosed: (Ad ad) {
  //       print('${ad.runtimeType} closed.');
  //       ad.dispose();
  //       createInterstitialAd();
  //     },
  //     onApplicationExit: (Ad ad) =>
  //         print('${ad.runtimeType} onApplicationExit.'),
  //   ),
  // );

  static Future<void> createInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : '', //and:ca-app-pub-3940256099942544/6300978111
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          log('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  static void showInterstitialAd() {
    if (_interstitialAd == null) {
      log('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        log('ad onAdShowedFullScreenContent.');
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
