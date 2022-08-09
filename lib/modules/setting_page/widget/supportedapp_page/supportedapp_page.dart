import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/banner_ad.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/setting_page/widget/supportedapp_page/supporredapp_controller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class SupportedAppPage extends StatelessWidget {
  SupportedAppPage({Key? key}) : super(key: key);
  final ThemeController themeController = Get.find();
  final SupportedAppController supportedAppController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor(context),
      appBar: AppBar(
        backgroundColor: themeController.isSwitched.value
            ? AppColor.darkThem.withOpacity(0.2)
            : AppColor.whiteColor,
        leadingWidth: SizeUtils.horizontalBlockSize * 11.5,
        elevation: 0.2,
        leading: GestureDetector(
          onTap: () {
            Navigation.pop();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeUtils.horizontalBlockSize * 4.2,
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
                    supportedAppController.isSwitchWhatsApp.value = value;
                    AppPreference.setWhatsApp(
                      whatsApp: supportedAppController.isSwitchWhatsApp.value,
                    );
                    const platform =
                        MethodChannel('samples.flutter.dev/battery');

                    if (value == false) {
                      // supportedAppController.getPhoneContacts();
                      supportedAppController.whatsApp.value = value;
                      AppPreference.setWhatsApp(whatsApp: false);
                      platform.invokeMethod(
                        'setWhatsApp',
                        {"whatsapp": supportedAppController.whatsApp.value},
                      );
                    } else {
                      supportedAppController.getPhoneContacts();
                      supportedAppController.whatsApp.value = value;
                      AppPreference.setWhatsApp(whatsApp: true);
                      await platform.invokeMethod(
                        'setWhatsApp',
                        {"whatsapp": supportedAppController.whatsApp.value},
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
                      supportedAppController.whatsappBusiness.value = value;

                      AppPreference.setWhatsAppBusi(whatsAppBusi: false);
                      platform.invokeMethod(
                        'setWhatsappBusiness',
                        {
                          "whatsappBusiness":
                              supportedAppController.whatsappBusiness.value
                        },
                      );
                    } else {
                      supportedAppController.whatsappBusiness.value = value;
                      AppPreference.setWhatsAppBusi(whatsAppBusi: true);

                      platform.invokeMethod(
                        'setWhatsappBusiness',
                        {
                          "whatsappBusiness":
                              supportedAppController.whatsappBusiness.value
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
                      supportedAppController.facebook.value = value;
                      AppPreference.setFbMassager(fbMassager: false);
                      platform.invokeMethod(
                        'setFacebook',
                        {"facebook": supportedAppController.facebook.value},
                      );
                    } else {
                      supportedAppController.facebook.value = value;
                      AppPreference.setFbMassager(fbMassager: true);
                      platform.invokeMethod(
                        'setFacebook',
                        {"facebook": supportedAppController.facebook.value},
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
                      supportedAppController.instagram.value = value;
                      AppPreference.setInstagram(instagram: false);
                      platform.invokeMethod(
                        'setInstagramResponse',
                        {
                          "instagramResponse":
                              supportedAppController.instagram.value
                        },
                      );
                    } else {
                      supportedAppController.instagram.value = value;
                      AppPreference.setInstagram(instagram: true);
                      platform.invokeMethod(
                        'setInstagramResponse',
                        {
                          "instagramResponse":
                              supportedAppController.instagram.value
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
                      supportedAppController.telegram.value = value;

                      AppPreference.setTelegram(telegram: false);
                      platform.invokeMethod(
                        'setTelegram',
                        {"telegram": supportedAppController.telegram.value},
                      );
                    } else {
                      supportedAppController.telegram.value = value;
                      AppPreference.setTelegram(telegram: true);

                      platform.invokeMethod(
                        'setTelegram',
                        {"telegram": supportedAppController.telegram.value},
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
                      supportedAppController.twitter.value = value;

                      AppPreference.setTwitter(twitter: false);
                      platform.invokeMethod(
                        'setTwitter',
                        {"twitter": supportedAppController.twitter.value},
                      );
                    } else {
                      supportedAppController.twitter.value = value;
                      AppPreference.setTelegram(telegram: true);

                      platform.invokeMethod(
                        'setTwitter',
                        {"twitter": supportedAppController.twitter.value},
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
    String? image,
    String? text,
    bool? value,
    ValueChanged<bool>? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 0.5,
          color: ColorRes.textColor(context).withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.horizontalBlockSize * 2,
            vertical: SizeUtils.verticalBlockSize * 1.1),
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
