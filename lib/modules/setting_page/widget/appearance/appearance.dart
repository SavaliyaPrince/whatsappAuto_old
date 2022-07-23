import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class AppearancePage extends StatelessWidget {
  AppearancePage({Key? key}) : super(key: key);
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor(context),
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: themeController.isSwitched.value
            ? AppColor.darkThem.withOpacity(0.2)
            : AppColor.whiteColor,
        leadingWidth: SizeUtils.fSize_40(),
        leading: GestureDetector(
          onTap: () {
            Navigation.pop();
          },
          child: Padding(
            padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 3),
            child: Image.asset(
              AppIcons.backIcon,
              color: themeController.isSwitched.value
                  ? AppColor.whiteColor
                  : AppColor.backIconColor,
            ),
          ),
        ),
        title: AppText(
          AppString.Appearance,
          fontSize: SizeUtils.fSize_17(),
          fontWeight: FontWeight.w600,
          color: themeController.isSwitched.value
              ? AppColor.whiteColor
              : AppColor.backIconColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.horizontalBlockSize * 4,
          vertical: SizeUtils.verticalBlockSize * 2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  AppString.Theme,
                  fontSize: SizeUtils.fSize_14(),
                  fontWeight: FontWeight.w600,
                  color: ColorRes.textColor(context),
                ),
                SizedBox(height: SizeUtils.verticalBlockSize * 0.7),
                AppText(
                  themeController.isSwitched.value == true
                      ? AppString.dark
                      : AppString.SystemDefault,
                  fontSize: SizeUtils.fSize_14(),
                  fontWeight: FontWeight.w400,
                  color: ColorRes.textColor(context),
                ),
              ],
            ),
            const Spacer(),
            Switch(
              activeColor: AppColor.primaryColor,
              value: themeController.isSwitched.value,
              onChanged: (value) {
                themeController.isSwitched.value = value;
                Get.changeThemeMode(
                  themeController.isSwitched.value == true
                      ? ThemeMode.dark
                      : ThemeMode.light,
                );
                AppPreference.setBoolean("theme",
                    value: themeController.isSwitched.value);
                log("AppPreference---->>>${AppPreference.getBoolean("theme")}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
