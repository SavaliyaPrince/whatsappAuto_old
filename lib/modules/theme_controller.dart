import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';

class ThemeController extends GetxController {
  RxBool isSwitched = false.obs;

  // static bool isDarkMode = false;
  RxBool isDarkMode = false.obs;
  RxInt whatsAppMassageSent = 0.obs;
  RxInt fbMassangerMassageSent = 0.obs;
  RxInt telegramMassageSent = 0.obs;
  RxInt twitterMassageSent = 0.obs;
  RxInt whatsAppBusiMassageSent = 0.obs;
  RxInt instaMassageSent = 0.obs;
  RxInt totalMassageSent = 0.obs;

  @override
  void onInit() {
    getTheme();
    getWhatsappMessageCount();
    getFbMessageCount();
    getTelegramMessageCount();
    getTwitterMessageCount();
    getWhatsappBusiMessageCount();
    getInstaMessageCount();
    super.onInit();
  }

  ThemeMode setTheme() {
    return isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  }

  void getTheme() {
    isSwitched.value = AppPreference.getBoolean("theme");
    isDarkMode.value = isSwitched.value;
  }

  Future<String> getWhatsappMessageCount() async {
    print("------000000--------");

    const platform = MethodChannel('samples.flutter.dev/battery');
    final String result = await platform.invokeMethod('getMessageCount');
    whatsAppMassageSent.value = int.parse(result);
    print(
        'AppPreference.getStringt --0--: ${AppPreference.getInt("totalMassageSent")}');
    print('getMessageCount messageCount: $result');

    return result;
  }

  Future<String> getFbMessageCount() async {
    print("------1111111--------");

    const platform = MethodChannel('samples.flutter.dev/battery');
    final String result = await platform.invokeMethod('getFbMessageCount');
    fbMassangerMassageSent.value = int.parse(result);
    print('getFbMessageCount messageCount: $result');
    return result;
  }

  Future<String> getTelegramMessageCount() async {
    print("------222222222--------");

    // telegramMassageSent.value = telegramMassageSent.value;
    const platform = MethodChannel('samples.flutter.dev/battery');
    final String result =
        await platform.invokeMethod('getTelegramMessageCount');
    telegramMassageSent.value = int.parse(result);
    print('getTelegramMessageCount messageCount: $result');
    return result;
  }

  Future<String> getTwitterMessageCount() async {
    const platform = MethodChannel('samples.flutter.dev/battery');
    final String result = await platform.invokeMethod('getTwitterMessageCount');
    twitterMassageSent.value = int.parse(result);
    print('getTwitterMessageCount messageCount: $result');
    return result;
  }

  Future<String> getWhatsappBusiMessageCount() async {
    print("------444444444--------");
    const platform = MethodChannel('samples.flutter.dev/battery');
    final String result =
        await platform.invokeMethod('getWhatsappBusiMessageCount');
    whatsAppBusiMassageSent.value = int.parse(result);
    print('getWhatsappBusiMessageCount messageCount: $result');
    return result;
  }

  Future<String> getInstaMessageCount() async {
    print("------5555555--------");
    const platform = MethodChannel('samples.flutter.dev/battery');
    final String result = await platform.invokeMethod('getInstaMessageCount');
    instaMassageSent.value = int.parse(result);
    print('getInstaMessageCount messageCount: $result');
    return result;
  }

  void getTotalCount() {
    totalMassageSent.value = whatsAppMassageSent.value +
        fbMassangerMassageSent.value +
        telegramMassageSent.value +
        twitterMassageSent.value +
        whatsAppBusiMassageSent.value +
        instaMassageSent.value;
  }
}
