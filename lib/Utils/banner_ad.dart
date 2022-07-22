import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdView extends StatefulWidget {
  const BannerAdView({Key? key}) : super(key: key);

  @override
  State<BannerAdView> createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<BannerAdView> {
  BannerAd? _anchoredBanner;
  bool _loadingAnchoredBanner = false;
  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  @override
  void dispose() {
    _anchoredBanner?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        if (!_loadingAnchoredBanner) {
          _loadingAnchoredBanner = true;
          _createAnchoredBanner(context);
        }
        return Container(
          height: _anchoredBanner == null ? 0 : 70,
          alignment: Alignment.center,
          child: _anchoredBanner == null
              ? const SizedBox()
              : AdWidget(
                  ad: _anchoredBanner!,
                ),
        );
      },
    );
  }

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: const AdSize(width: 320, height: 70),
      request: request,

      // ///live
      // adUnitId: Platform.isAndroid
      //     ? ''
      //     : '',

      ///test
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',

      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('AdMob Banner Ad onAdLoaded:');
          setState(() {
            _anchoredBanner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('AdMob Banner Ad failedToLoad: $error');
          ad.dispose();
        },
        onAdImpression: (Ad ad) {
          print('AdMob Banner Ad onAdImpression:');
        },
        onAdOpened: (Ad ad) {
          print('AdMob Banner Ad onAdImpression: $ad');
        },
        onAdClosed: (Ad ad) {
          print('AdMob Banner Ad onAdClosed.');
        },
      ),
    );
    return banner.load();
  }
}
