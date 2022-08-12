// import 'package:firebase_remote_config/firebase_remote_config.dart';
//
// class FirebaseRemoteConfigUtils {
//   static final FirebaseRemoteConfigUtils _configUtils =
//       FirebaseRemoteConfigUtils._internal();
//   factory FirebaseRemoteConfigUtils() {
//     return _configUtils;
//   }
//
//   FirebaseRemoteConfigUtils._internal();
//   static final FirebaseRemoteConfig _remoteConfig =
//       FirebaseRemoteConfig.instance;
//
//   /// AppOpenAdsID
//   static const String openAppAdsId = 'appOpenId';
//   static const String openIosAdsId = 'iosOpenId';
//
//   /// BannerAdsId
//   static const String bannerAppAdsId = 'appBannerId';
//   static const String bannerIosAdsId = 'iosBannerId';
//
//   ///InterstitialAdsId
//   static const String InterstitialAppAdsId = 'appInterstitialId';
//   static const String InterstitialIosAdsId = 'iosInterstitialId';
//   // static const String openAppAdsShowOrNot = 'ads_show_flag';
//
//   static String get appOpenId => _remoteConfig.getString(openAppAdsId);
//   static String get iosOpenId => _remoteConfig.getString(openIosAdsId);
//
//   static String get appBannerId => _remoteConfig.getString(bannerAppAdsId);
//   static String get iosBannerId => _remoteConfig.getString(bannerIosAdsId);
//
//   static String get appInterstitialId =>
//       _remoteConfig.getString(InterstitialAppAdsId);
//   static String get iosInterstitialId =>
//       _remoteConfig.getString(InterstitialIosAdsId);
//   // static bool get isOpenAdsShowOrNot =>
//   //     _remoteConfig.getBool(openAppAdsShowOrNot);
//   static Future<void> initMethod() async {
//     try {
//       final remoteConfig = FirebaseRemoteConfig.instance;
//       await remoteConfig.setConfigSettings(
//         RemoteConfigSettings(
//             fetchTimeout: const Duration(seconds: 1),
//             minimumFetchInterval: const Duration(seconds: 0)),
//       );
//       await _remoteConfig.fetchAndActivate();
//     } catch (e) {
//       print(e);
//     }
//   }
// }
