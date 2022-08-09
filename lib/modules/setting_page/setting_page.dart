import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/banner_ad.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/setting_page/setting_controller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  final SettingController settingController = Get.find();
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const BannerAdView(),
      backgroundColor: ColorRes.backgroundColor(context),
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: themeController.isSwitched.value
            ? AppColor.whiteColor
            : AppColor.appBarColors,
        leadingWidth: SizeUtils.horizontalBlockSize * 11.5,
        leading: GestureDetector(
          onTap: () {
            Navigation.pop();
          },
          child: Padding(
            padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 4.2),
            child: Image.asset(
              AppIcons.backIcon,
              color: themeController.isSwitched.value
                  ? AppColor.backIconColor
                  : AppColor.whiteColor,
            ),
          ),
        ),
        title: AppText(
          AppString.setting,
          color: themeController.isSwitched.value
              ? AppColor.backIconColor
              : AppColor.whiteColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: SizeUtils.verticalBlockSize * 1),
          if (Platform.isIOS)
            Column(
              children: [
                _settingItem(
                  context,
                  AppIcons.appearance,
                  AppString.Appearance,
                  width: SizeUtils.fSize_24(),
                  onTap: () {
                    Navigation.pushNamed(Routes.appearance);
                  },
                ),
                ListTile(
                  horizontalTitleGap: SizeUtils.horizontalBlockSize * 1,
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: Image.asset(
                    AppIcons.notification,
                    width: SizeUtils.fSize_24(),
                    color: ColorRes.textColor(context),
                  ),
                  title: AppText(
                    AppString.Notification,
                    color: ColorRes.textColor(context),
                    fontWeight: FontWeight.w600,
                    fontSize: SizeUtils.fSize_14(),
                  ),
                  trailing: Obx(
                    () => Switch(
                      activeColor: AppColor.primaryColor,
                      value: settingController.isSwitchNotification.value,
                      onChanged: (value) {
                        settingController.isSwitchNotification.value = value;
                        AppPreference.setNotification(
                          notification:
                              settingController.isSwitchNotification.value,
                        );
                      },
                    ),
                  ),
                ),
                _settingItem(
                  context,
                  AppIcons.upgrade,
                  AppString.upgrade,
                  width: SizeUtils.fSize_20(),
                  onTap: () {},
                ),
                _settingItem(
                  context,
                  AppIcons.privacy,
                  AppString.Privacy,
                  width: SizeUtils.fSize_24(),
                  onTap: () {},
                ),
                _settingItem(
                  context,
                  AppIcons.help,
                  AppString.Help,
                  width: SizeUtils.fSize_24(),
                  onTap: () {},
                ),
              ],
            )
          else
            Column(
              children: [
                _settingItem(
                  context,
                  AppIcons.autoReply,
                  AppString.autoReply,
                  width: SizeUtils.fSize_24(),
                  onTap: () {
                    Navigation.pushNamed(Routes.autoReplyMassage);
                  },
                ),
                _settingItem(
                  context,
                  AppIcons.element,
                  AppString.categoryTitle,
                  width: SizeUtils.fSize_24(),
                  onTap: () {
                    Navigation.pushNamed(Routes.supportedApp);
                  },
                ),
                _settingItem(
                  context,
                  AppIcons.appearance,
                  AppString.Appearance,
                  width: SizeUtils.fSize_24(),
                  onTap: () {
                    Navigation.pushNamed(Routes.appearance);
                  },
                ),
                ListTile(
                  horizontalTitleGap: SizeUtils.horizontalBlockSize * 1,
                  visualDensity: const VisualDensity(vertical: -3),
                  leading: Image.asset(
                    AppIcons.notification,
                    width: SizeUtils.fSize_24(),
                    color: ColorRes.textColor(context),
                  ),
                  title: AppText(
                    AppString.Notification,
                    color: ColorRes.textColor(context),
                    fontWeight: FontWeight.w600,
                    fontSize: SizeUtils.fSize_14(),
                  ),
                  trailing: Obx(
                    () => Switch(
                      activeColor: AppColor.primaryColor,
                      value: settingController.isSwitchNotification.value,
                      onChanged: (value) {
                        settingController.isSwitchNotification.value = value;

                        AppPreference.setNotification(
                          notification:
                              settingController.isSwitchNotification.value,
                        );
                      },
                    ),
                  ),
                ),
                _settingItem(
                  context,
                  AppIcons.upgrade,
                  AppString.upgrade,
                  width: SizeUtils.fSize_20(),
                  onTap: () {},
                ),
                _settingItem(
                  context,
                  AppIcons.privacy,
                  AppString.Privacy,
                  width: SizeUtils.fSize_24(),
                  onTap: () {},
                ),
                _settingItem(
                  context,
                  AppIcons.help,
                  AppString.Help,
                  width: SizeUtils.fSize_24(),
                  onTap: () {},
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget _settingItem(
    BuildContext context,
    String? image,
    String? text, {
    GestureTapCallback? onTap,
    double? width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        horizontalTitleGap: SizeUtils.horizontalBlockSize * 1,
        visualDensity: const VisualDensity(vertical: -3),
        leading: Image.asset(
          image ?? '',
          width: width,
          color: ColorRes.textColor(context),
        ),
        title: Text(
          text ?? '',
          style: TextStyle(
            fontSize: SizeUtils.fSize_14(),
            color: ColorRes.textColor(context),
            fontWeight: FontWeight.w600,
            fontFamily: AppString.fonts,
          ),
        ),
      ),
    );
  }
}
