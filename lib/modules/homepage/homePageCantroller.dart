import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/theme/app_color.dart';

class HomePageController extends GetxController {
  RxBool isSwitched = false.obs;

  RxInt selectedIndex = 0.obs;
  RxBool whatsApp = false.obs;
  RxBool facebook = false.obs;
  RxBool whatsappBusiness = false.obs;
  RxBool autoMassageOnOff = false.obs;
  RxBool telegram = false.obs;
  RxBool twitter = false.obs;
  RxBool instagram = false.obs;

  void onThemeChange() {
    isSwitched.value = AppPreference.getBoolean("theme");
  }

  Future<void> getWhatsAuto() async {
    const platform = MethodChannel('samples.flutter.dev/battery');

    String batteryLevel;
    try {
      final result =
          await platform.invokeMethod('checkNotificationServiceEnabled');

      if (result == false) {
        Get.dialog(
          SimpleDialog(
            title: Text(
              "Do you want to activate whatsapp auto response service?",
              style: TextStyle(
                fontSize: SizeUtils.fSize_14(),
                fontFamily: "Roboto",
              ),
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.appBackgroundColor,
                    ),
                    child: const Text('Not Now'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () async {
                        Get.back();
                        await platform.invokeMethod('serviceEnable');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.appBackgroundColor,
                      ),
                      child: const Text('Activate')),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        );
      } else {
        Get.back();
      }
    } catch (e) {
      batteryLevel = "Failed to get battery level: '$e'.";
      log(batteryLevel);
    }
  }

  Future<void> sendWhatsAppSellerId() async {
    const platform = MethodChannel('samples.flutter.dev/battery');
    await platform.invokeMethod(
      'setSellerId',
      {"sellerID": 'temp'},
    );
  }

  Future<void> sendLanguage() async {
    const platform = MethodChannel('samples.flutter.dev/battery');
    await platform.invokeMethod(
      'setLanguage',
      {"languageCode": '91'},
    );
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    whatsApp.value = AppPreference.whatsApp;
    whatsappBusiness.value = AppPreference.whatsAppBusi;
    facebook.value = AppPreference.fbMassager;
    instagram.value = AppPreference.instagrams;
    telegram.value = AppPreference.telegram;
    twitter.value = AppPreference.twitter;
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    if (!Platform.isIOS) {
      sendWhatsAppSellerId();
      sendLanguage();
    }

    getWhatsAuto();

    print("-=-=-=-=-getWhatsAuto-=-=-=-=-==-${getWhatsAuto()}");
  }
}
