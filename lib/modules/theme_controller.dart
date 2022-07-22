import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';

class ThemeController extends GetxController {
  RxBool isSwitched = false.obs;
  // static bool isDarkMode = false;
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    getTheme();
    super.onInit();
  }

  ThemeMode setTheme() {
    return isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  }

  void getTheme() {
    isSwitched.value = AppPreference.getBoolean("theme");
    isDarkMode.value = isSwitched.value;
  }
}
