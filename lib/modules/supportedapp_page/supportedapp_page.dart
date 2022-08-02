import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/banner_ad.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/homepage/homePageCantroller.dart';
import 'package:whatsapp_auto/modules/supportedapp_page/supporredapp_controller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class SupportedAppPage extends StatelessWidget {
  SupportedAppPage({Key? key}) : super(key: key);
  final ThemeController themeController = Get.find();
  final SupportedAppController supportedAppController = Get.find();
  final HomePageController _homePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor(context),
      appBar: AppBar(
        backgroundColor: themeController.isSwitched.value
            ? AppColor.darkThem.withOpacity(0.2)
            : AppColor.whiteColor,
        leadingWidth: SizeUtils.fSize_40(),
        elevation: 0.2,
        leading: GestureDetector(
          onTap: () {
            Navigation.pop();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeUtils.horizontalBlockSize * 3,
            ),
            child: Image.asset(
              AppIcons.backIcon,
              color: themeController.isSwitched.value
                  ? AppColor.whiteColor
                  : AppColor.backIconColor,
            ),
          ),
        ),
        title: AppText(
          AppString.supportedApps,
          fontWeight: FontWeight.w600,
          color: themeController.isSwitched.value
              ? AppColor.whiteColor
              : AppColor.backIconColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeUtils.horizontalBlockSize * 4.5,
            right: SizeUtils.horizontalBlockSize * 4.5,
            top: SizeUtils.horizontalBlockSize * 5.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                AppString.enableDisabble,
                fontWeight: FontWeight.w600,
                fontSize: SizeUtils.fSize_16(),
                color: ColorRes.textColor(context),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 0.8,
              ),
              AppText(
                AppString.description,
                fontWeight: FontWeight.w400,
                fontSize: SizeUtils.fSize_14(),
                color: ColorRes.textColor(context).withOpacity(0.6),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 4,
              ),
              Obx(
                () => _enableApps(
                  context,
                  image: AppIcons.whatsapp,
                  text: AppString.WhatsApp,
                  value: supportedAppController.isSwitchWhatsApp.value,
                  onChanged: (value) async {
                    print('checkService check 0 $value');
                    supportedAppController.isSwitchWhatsApp.value = value;
                    if (supportedAppController.isSwitchWhatsApp.value == true) {
                      supportedAppController.getPhoneContacts();
                    }
                    AppPreference.setWhatsApp(
                      whatsApp: _homePageController.whatsApp.value,
                    );

                    const platform =
                        MethodChannel('samples.flutter.dev/battery');

                    // if (value == false) {
                    //   _homePageController.autoMassageOnOff.value = value;
                    //   _homePageController.whatsApp.value = value;
                    //   _homePageController.whatsappBusiness.value = value;
                    //   _homePageController.facebook.value = value;
                    //   _homePageController.instagram.value = value;
                    //   // _homePageController.twitter.value = value;
                    //   AppPreference.setAutoResponse(autoResponse: false);
                    //   // await platform.invokeMethod('notificationDisable');
                    // } else {
                    //   log('val ==>> ${value.toString()}');
                    //   _homePageController.autoMassageOnOff.value = value;
                    //   AppPreference.setAutoResponse(autoResponse: true);
                    //   _homePageController.whatsApp.value = value;
                    //   AppPreference.setWhatsApp(whatsApp: true);
                    //   await platform.invokeMethod(
                    //     'setWhatsApp',
                    //     {"whatsapp": _homePageController.whatsApp.value},
                    //   );
                    // }
                    print('checkService check 1');
                    if (value == false) {
                      _homePageController.whatsApp.value = value;
                      AppPreference.setWhatsApp(
                        whatsApp: _homePageController.whatsApp.value,
                      );
                      platform.invokeMethod(
                        'setWhatsApp',
                        {"whatsapp": _homePageController.whatsApp.value},
                      );
                    } else {
                      _homePageController.whatsApp.value = value;
                      AppPreference.setWhatsApp(whatsApp: true);
                      print('checkService check 2');
                      try {
                        await platform.invokeMethod(
                          'setWhatsApp',
                          {"whatsapp": _homePageController.whatsApp.value},
                        );
                      } catch (e) {
                        print('checkService check 2 exception: $e');
                      }
                    }
                    final result = await platform
                        .invokeMethod('checkNotificationServiceEnabled');

                    if (result == false) {
                      platform.invokeMethod('serviceEnable');
                    }
                    print("result-=-=-=-=-==-=-==---=$result");
                  },
                ),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 2,
              ),
              Obx(
                () => _enableApps(
                  context,
                  image: AppIcons.whatsappBusiness,
                  text: AppString.whatsappBusiness,
                  value: supportedAppController.isSwitchWhatsAppBusi.value,
                  onChanged: (value) {
                    supportedAppController.isSwitchWhatsAppBusi.value = value;
                    AppPreference.setWhatsAppBusi(
                      whatsAppBusi:
                          supportedAppController.isSwitchWhatsAppBusi.value,
                    );
                    const platform =
                        MethodChannel('samples.flutter.dev/battery');

                    if (value == false) {
                      _homePageController.whatsappBusiness.value = value;

                      AppPreference.setWhatsAppBusi(whatsAppBusi: false);
                      platform.invokeMethod(
                        'setWhatsappBusiness',
                        {
                          "whatsappBusiness":
                              _homePageController.whatsappBusiness.value
                        },
                      );
                    } else {
                      _homePageController.whatsappBusiness.value = value;
                      AppPreference.setWhatsAppBusi(whatsAppBusi: true);

                      platform.invokeMethod(
                        'setWhatsappBusiness',
                        {
                          "whatsappBusiness":
                              _homePageController.whatsappBusiness.value
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 2,
              ),
              Obx(
                () => _enableApps(
                  context,
                  image: AppIcons.fbMessenger,
                  text: AppString.massanger,
                  value: supportedAppController.isSwitchMessanger.value,
                  onChanged: (value) {
                    supportedAppController.isSwitchMessanger.value = value;
                    AppPreference.setFbMassager(
                      fbMassager:
                          supportedAppController.isSwitchMessanger.value,
                    );
                    const platform =
                        MethodChannel('samples.flutter.dev/battery');
                    if (value == false) {
                      _homePageController.facebook.value = value;
                      AppPreference.setFbMassager(fbMassager: false);
                      platform.invokeMethod(
                        'setFacebook',
                        {"facebook": _homePageController.facebook.value},
                      );
                    } else {
                      _homePageController.facebook.value = value;
                      AppPreference.setFbMassager(fbMassager: true);
                      platform.invokeMethod(
                        'setFacebook',
                        {"facebook": _homePageController.facebook.value},
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 2,
              ),
              Obx(
                () => _enableApps(
                  context,
                  image: AppIcons.instagram,
                  text: AppString.instagram,
                  value: supportedAppController.isSwitchInstagram.value,
                  onChanged: (value) {
                    supportedAppController.isSwitchInstagram.value = value;
                    AppPreference.setInstagram(
                      instagram: supportedAppController.isSwitchInstagram.value,
                    );
                    const platform =
                        MethodChannel('samples.flutter.dev/battery');
                    if (value == false) {
                      _homePageController.instagram.value = value;
                      AppPreference.setInstagram(instagram: false);
                      platform.invokeMethod(
                        'setInstagramResponse',
                        {
                          "instagramResponse":
                              _homePageController.instagram.value
                        },
                      );
                    } else {
                      _homePageController.instagram.value = value;
                      AppPreference.setInstagram(instagram: true);
                      platform.invokeMethod(
                        'setInstagramResponse',
                        {
                          "instagramResponse":
                              _homePageController.instagram.value
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 2,
              ),
              Obx(
                () => _enableApps(
                  context,
                  image: AppIcons.telegram,
                  text: AppString.telegram,
                  value: supportedAppController.isSwitchTelegram.value,
                  onChanged: (value) {
                    supportedAppController.isSwitchTelegram.value = value;
                    AppPreference.setWhatsAppBusi(
                      whatsAppBusi:
                          supportedAppController.isSwitchTelegram.value,
                    );
                    const platform =
                        MethodChannel('samples.flutter.dev/battery');

                    if (value == false) {
                      _homePageController.telegram.value = value;

                      AppPreference.setTelegram(telegram: false);
                      platform.invokeMethod(
                        'setTelegram',
                        {"telegram": _homePageController.telegram.value},
                      );
                    } else {
                      _homePageController.telegram.value = value;
                      AppPreference.setTelegram(telegram: true);

                      platform.invokeMethod(
                        'setTelegram',
                        {"telegram": _homePageController.telegram.value},
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 2,
              ),
              Obx(
                () => _enableApps(
                  context,
                  image: AppIcons.twitter,
                  text: AppString.twitter,
                  value: supportedAppController.isSwitchTwitter.value,
                  onChanged: (value) {
                    supportedAppController.isSwitchTwitter.value = value;
                    AppPreference.setTwitter(
                      twitter: supportedAppController.isSwitchTwitter.value,
                    );
                    const platform =
                        MethodChannel('samples.flutter.dev/battery');

                    if (value == false) {
                      _homePageController.twitter.value = value;

                      AppPreference.setTwitter(twitter: false);
                      platform.invokeMethod(
                        'setTwitter',
                        {"twitter": _homePageController.twitter.value},
                      );
                    } else {
                      _homePageController.twitter.value = value;
                      AppPreference.setTelegram(telegram: true);

                      platform.invokeMethod(
                        'setTwitter',
                        {"twitter": _homePageController.twitter.value},
                      );
                    }
                  },
                ),
              ),
              Obx(
                () => SizedBox(
                  height: isBannerLoaded.value
                      ? SizeUtils.verticalBlockSize * 8
                      : 0,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: const BannerAdView(),
    );
  }

  Widget _enableApps(
    BuildContext context, {
    final String? image,
    final String? text,
    final bool? value,
    final ValueChanged<bool>? onChanged,
  }) {
    return Container(
      height: SizeUtils.verticalBlockSize * 10.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorRes.textColor(context).withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.horizontalBlockSize * 2,
        ),
        child: Row(
          children: [
            SizedBox(
              width: SizeUtils.horizontalBlockSize * 4.5,
            ),
            Image.asset(
              '$image',
              width: SizeUtils.horizontalBlockSize * 8,
              height: SizeUtils.verticalBlockSize * 4.1,
            ),
            SizedBox(
              width: SizeUtils.horizontalBlockSize * 4.5,
            ),
            AppText(
              '$text',
              fontWeight: FontWeight.w600,
              fontSize: SizeUtils.fSize_16(),
              color: ColorRes.textColor(context),
            ),
            const Spacer(),
            Switch(
              activeColor: AppColor.primaryColor,
              value: value!,
              onChanged: onChanged,
            ),
            SizedBox(
              width: SizeUtils.horizontalBlockSize * 4.5,
            ),
          ],
        ),
      ),
    );
  }
}
