import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/homepage/homePageCantroller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class AppearancePage extends StatelessWidget {
  AppearancePage({Key? key}) : super(key: key);
  final HomePageController homePageController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: homePageController.isSwitched.value
            ? AppColor.darkThem
            : AppColor.lightThem,
        appBar: AppBar(
          elevation: 0.2,
          backgroundColor: AppColor.appBackgroundColor,
          leadingWidth: SizeUtils.fSize_40(),
          leading: GestureDetector(
            onTap: () {
              Navigation.pop();
            },
            child: Padding(
              padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 3),
              child: Image.asset(
                AppIcons.backIcon,
                color: AppColor.backIconColor,
              ),
            ),
          ),
          title: AppText(
            AppString.Appearance,
            fontSize: SizeUtils.fSize_17(),
            fontWeight: FontWeight.w600,
            color: AppColor.textColor,
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
                  ),
                  SizedBox(height: SizeUtils.verticalBlockSize * 0.7),
                  AppText(
                    homePageController.isSwitched.value
                        ? AppString.dark
                        : AppString.SystemDefault,
                    fontSize: SizeUtils.fSize_14(),
                    fontWeight: FontWeight.w400,
                    color: homePageController.isSwitched.value
                        ? AppColor.whiteColor
                        : AppColor.textColor.withOpacity(0.5),
                  ),
                ],
              ),
              const Spacer(),
              Switch(
                value: homePageController.isSwitched.value,
                onChanged: (value) {
                  homePageController.isSwitched.value =
                      !homePageController.isSwitched.value;
                  AppPreference.setBoolean("theme",
                      value: homePageController.isSwitched.value);
                  log("AppPreference---->>>${AppPreference.getBoolean("theme")}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
