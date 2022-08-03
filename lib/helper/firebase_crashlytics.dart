import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FireBaseCrashlyticsUtils {
  static const _kShouldTestAsyncErrorOnInit = false;
  static const _kTestingCrashlytics = true;

  // static Future<void> _initializeFlutterFireFuture;
  //  late Future<void> _initializeFlutterFireFuture;

  void init() {
    print("init state..");
    _initializeFlutterFire();
  }

  Future<void> _testAsyncErrorOnInit() async {
    Future<void>.delayed(const Duration(seconds: 2), () {
      print("_testAsyncErrorOnInit....");
      final List<int> list = <int>[];
      print(list[100]);
    });
  }

  Future<void> _initializeFlutterFire() async {
    if (_kTestingCrashlytics) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      print("FirebaseCrashlytics --->$_kTestingCrashlytics");
    } else {
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }
    final Function? originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      print("FirebaseCrashlytics errorDetails->$errorDetails....");
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      originalOnError!(errorDetails);
    };

    if (_kShouldTestAsyncErrorOnInit) {
      await _testAsyncErrorOnInit();
    }
  }
}
