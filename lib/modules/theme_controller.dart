import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';

class ThemeController extends GetxController {
  RxBool isSwitched = false.obs;

  // static bool isDarkMode = false;
  RxBool isDarkMode = false.obs;
  RxString whatsAppMassageSent = "".obs;
  RxString fbMassangerMassageSent = "".obs;
  RxString telegramMassageSent = "".obs;
  RxString lineMassangerMassageSent = "".obs;
  RxString viberMassageSent = "".obs;
  RxString discordMassangerMassageSent = "".obs;
  RxString totalMassageSent = "".obs;

  @override
  void onInit() {
    getTheme();
    getMessageCount();
    super.onInit();
  }

  ThemeMode setTheme() {
    return isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  }

  Future<String> getMessageCount() async {
    totalMassageSent.value = whatsAppMassageSent.value;
    const platform = MethodChannel('samples.flutter.dev/battery');
    final String result = await platform.invokeMethod('getMessageCount');
    whatsAppMassageSent.value = result;
    print('getMessageCount messageCount: $result');
    return result;
  }

  void getTheme() {
    isSwitched.value = AppPreference.getBoolean("theme");
    isDarkMode.value = isSwitched.value;
  }
  //
  // Future<String> getMessageCount() async {
  //   totalMassageSent.value = whatsAppMassageSent.value;
  //   const platform = MethodChannel('samples.flutter.dev/battery');
  //   final String result = await platform.invokeMethod('getMessageCount');
  //   whatsAppMassageSent.value = result;
  //   print('getMessageCount messageCount: $result');
  //   return result;
  // }
}
