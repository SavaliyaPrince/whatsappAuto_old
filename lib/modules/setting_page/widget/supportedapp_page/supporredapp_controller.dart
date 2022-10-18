import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

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
      final PermissionStatus contactsPermissionsStatus = await contactsPermissions();
      if (contactsPermissionsStatus == PermissionStatus.granted) {
        const platform = MethodChannel('samples.flutter.dev/battery');
        log("contactsPermissionsStatus--$contactsPermissionsStatus");
        // if (isSwitchWhatsApp.value == false) {
        // supportedAppController.getPhoneContacts();
        // whatsApp.value = isSwitchWhatsApp.value;

        // AppPreference.setWhatsApp(whatsApp: false);
        ///
        // platform.invokeMethod(
        //   'setWhatsApp',
        //   {"whatsapp": true},
        // );
        // platform.invokeMethod(
        //   'setWhatsappBusiness',
        //   {"whatsappBusiness": true},
        // );
        log("contactsPermissionsStatus-0-$contactsPermissionsStatus");

        // }
        // else {
        //     // supportedAppController.getPhoneContacts();
        //     // supportedAppController.whatsApp.value = value;
        //     AppPreference.setWhatsApp(whatsApp: true);
        //     await platform.invokeMethod(
        //       'setWhatsApp',
        //       {"whatsapp": whatsApp.value},
        //     );
        //   }
        if (isSwitchWhatsApp.value) {
          whatsApp.value = isSwitchWhatsApp.value;
          isSwitchWhatsApp.value = true;
          AppPreference.setWhatsApp(whatsApp: true);
          platform.invokeMethod(
            'setWhatsApp',
            {"whatsapp": whatsApp.value},
          );
        } else if (isSwitchWhatsAppBusi.value) {
          whatsappBusiness.value = true;
          isSwitchWhatsAppBusi.value = true;
          AppPreference.setWhatsAppBusi(whatsAppBusi: false);
          platform.invokeMethod(
            'setWhatsappBusiness',
            {"whatsappBusiness": whatsappBusiness.value},
          );
        } else if (isSwitchMessanger.value) {
          facebook.value = true;
          isSwitchMessanger.value = true;
          AppPreference.setFbMassager(fbMassager: false);
          platform.invokeMethod(
            'setFacebook',
            {"facebook": facebook.value},
          );
        } else if (isSwitchInstagram.value) {
          instagram.value = true;
          isSwitchInstagram.value = true;
          AppPreference.setInstagram(instagram: false);
          platform.invokeMethod(
            'setInstagramResponse',
            {"instagramResponse": instagram.value},
          );
        } else if (isSwitchTelegram.value) {
          telegram.value = true;
          isSwitchTelegram.value = true;
          AppPreference.setTelegram(telegram: false);
          platform.invokeMethod(
            'setTelegram',
            {"telegram": telegram.value},
          );
        } else if (isSwitchTwitter.value) {
          twitter.value = true;
          isSwitchTwitter.value = true;
          AppPreference.setTwitter(twitter: false);
          platform.invokeMethod(
            'setTwitter',
            {"twitter": twitter.value},
          );
        }
      } else {
        // isSwitchWhatsApp.value = false;
        // whatsApp.value = false;
        // AppPreference.setWhatsApp(whatsApp: true);
        //  platform.invokeMethod(
        //   'setWhatsApp',
        //   {"whatsapp": whatsApp.value},
        // );
        // // AppPreference.setWhatsAppBusi(
        // //   whatsAppBusi: isSwitchWhatsAppBusi.value,
        // // );
        // isSwitchMessanger.value = false;
        // // AppPreference.setFbMassager(
        // //   fbMassager: isSwitchMessanger.value,
        // // );
        // isSwitchInstagram.value = false;
        // // AppPreference.setInstagram(
        // //   instagram: isSwitchInstagram.value,
        // // );
        // isSwitchTelegram.value = false;
        // // AppPreference.setTelegram(
        // //   telegram: isSwitchTelegram.value,
        // // );
        // isSwitchTwitter.value = false;
        // // AppPreference.setTwitter(
        // //   twitter: isSwitchTwitter.value,
        // // );
      }
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
      final result = await platform.invokeMethod('checkNotificationServiceEnabled');

      if (result == false) {
        Get.dialog(
          SimpleDialog(
            elevation: 0,
            backgroundColor: themeController.isSwitched.value ? ColorCollection.backGroundColorDark : AppColor.primaryColor,
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
                      primary: AppColor.primaryColor,
                    ),
                    child: const AppText('Not Now', color: AppColor.whiteColor),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () async {
                        Get.back();
                        await platform.invokeMethod('serviceEnable');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.primaryColor,
                      ),
                      child: const AppText('Activate', color: AppColor.whiteColor)),
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
