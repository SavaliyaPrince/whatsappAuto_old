import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';

class SupportedAppController extends GetxController {
  final ThemeController themeController = Get.find();
  RxBool isSwitchWhatsApp = false.obs;
  RxBool isSwitchMessanger = false.obs;
  RxBool isSwitchInstagram = false.obs;
  RxBool isSwitchWhatsAppBusi = false.obs;
  RxBool isSwitchTelegram = false.obs;
  RxBool isSwitchTwitter = false.obs;
  RxString responseFromNativeCode = 'Waiting for Response...'.obs;
  RxString response = "".obs;

  RxInt selectedIndex = 0.obs;
  RxBool whatsApp = false.obs;
  RxBool facebook = false.obs;
  RxBool whatsappBusiness = false.obs;
  RxBool autoMassageOnOff = false.obs;
  RxBool telegram = false.obs;
  RxBool twitter = false.obs;
  RxBool instagram = false.obs;

  @override
  void onInit() {
    isSwitchWhatsApp.value = AppPreference.whatsApp;
    isSwitchMessanger.value = AppPreference.fbMassager;
    isSwitchInstagram.value = AppPreference.instagrams;
    isSwitchWhatsAppBusi.value = AppPreference.whatsAppBusi;
    isSwitchTelegram.value = AppPreference.telegram;
    isSwitchTwitter.value = AppPreference.twitter;

    ///
    // if (!Platform.isIOS) {
    //   sendWhatsAppSellerId();
    //   sendLanguage();
    // } // print("-=-=-=-=-getWhatsAuto-=-=-=-=-==-${getWhatsAuto()}");

    super.onInit();
  }

  Future<void> getPhoneContacts() async {
    try {
      final PermissionStatus contactsPermissionsStatus =
          await contactsPermissions();
      if (contactsPermissionsStatus == PermissionStatus.granted) {}
    } catch (e, st) {
      print('------e----$e----+----st-------$st-----');
    }
  }

  Future<PermissionStatus> contactsPermissions() async {
    final PermissionStatus permission = await Permission.contacts.status;

    if (permission != PermissionStatus.granted) {
      final Map<Permission, PermissionStatus> permissionStatus = await [
        Permission.contacts,
      ].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
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
            elevation: 0,
            backgroundColor: themeController.isSwitched.value
                ? ColorCollection.backGroundColorDark
                : AppColor.primaryColor,
            // backgroundColor: AppColor.primaryColor,
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
                      primary: AppColor.green38,
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
                        primary: AppColor.green38,
                      ),
                      child: const Text('Activate')),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        );
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

  // @override
  // Future<void> onInit() async {
  //   // TODO: implement onInit
  //   super.onInit();
  //   if (!Platform.isIOS) {
  //     sendWhatsAppSellerId();
  //     sendLanguage();
  //   }
  //   getWhatsAuto();
  //   print("-=-=-=-=-getWhatsAuto-=-=-=-=-==-${getWhatsAuto()}");
  // }
}
