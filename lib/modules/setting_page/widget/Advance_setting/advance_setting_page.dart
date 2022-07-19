import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/homepage/homePageCantroller.dart';
import 'package:whatsapp_auto/modules/setting_page/widget/Advance_setting/advance_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class ASpage extends StatelessWidget {
  ASpage({Key? key}) : super(key: key);
  final HomePageController homePageController = Get.find();
  final ASController asController = Get.put(ASController());
  final ValueNotifier<bool> _isDisable = ValueNotifier(true);

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
            AppString.advance,
            fontSize: SizeUtils.fSize_17(),
            fontWeight: FontWeight.w600,
            color: AppColor.textColor,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.horizontalBlockSize * 4),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3,
                ),
                AppText(
                  AppString.modes,
                  color: homePageController.isSwitched.value
                      ? AppColor.whiteColor
                      : AppColor.textColor,
                  fontSize: SizeUtils.fSize_16(),
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: SizeUtils.verticalBlockSize * 3),
                Row(
                  children: [
                    AppText(
                      AppString.PhoneIdle,
                      color: homePageController.isSwitched.value
                          ? AppColor.whiteColor
                          : AppColor.textColor,
                      fontSize: SizeUtils.fSize_14(),
                      fontWeight: FontWeight.w600,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        !asController.phoneIdle.value;
                      },
                      child: SizedBox(
                        height: SizeUtils.verticalBlockSize * 2,
                        width: SizeUtils.horizontalBlockSize * 12,
                        child: Switch(
                          value: asController.phoneIdle.value,
                          onChanged: (value) {
                            asController.phoneIdle.value = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeUtils.verticalBlockSize * 1),
                AppText(
                  AppString.whatsAusto,
                  color: homePageController.isSwitched.value
                      ? AppColor.whiteColor
                      : AppColor.textColor.withOpacity(0.5),
                  fontSize: SizeUtils.fSize_14(),
                  fontWeight: FontWeight.w500,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeUtils.verticalBlockSize * 3,
                    bottom: SizeUtils.verticalBlockSize * 2.7,
                  ),
                  child: Divider(
                    height: 0,
                    color: homePageController.isSwitched.value
                        ? AppColor.whiteColor.withOpacity(0.2)
                        : AppColor.textColor.withOpacity(0.2),
                    thickness: SizeUtils.fSize_1(),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _isDisable,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _settingItem(
                            AppString.DrivingModes,
                            AppString.driving,
                            isSwitch: value,
                            value: asController.drivingMode.value,
                            onChanged: (val) {
                              asController.drivingMode.value = val;
                              print("----------drivingMode-------");
                            },
                          ),
                          SizedBox(height: SizeUtils.verticalBlockSize * 2),
                          _settingItem(
                            AppString.ReplyM,
                            AppString.iAmDriving,
                          ),
                          SizedBox(height: SizeUtils.verticalBlockSize * 3.5),
                          AppText(
                            AppString.ReplyTime,
                            color: homePageController.isSwitched.value
                                ? AppColor.whiteColor
                                : AppColor.textColor,
                            fontSize: SizeUtils.fSize_16(),
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: SizeUtils.verticalBlockSize * 3.5),
                          _settingItem(
                            AppString.ReplyM,
                            AppString.iAmDriving,
                          ),
                          SizedBox(height: SizeUtils.verticalBlockSize * 2),
                          _settingItem(
                            AppString.Wait,
                            AppString.WaitMassage,
                            isSwitch: value,
                            value: asController.waitTime.value,
                            onChanged: (val) {
                              print("----------waitTime-------");
                              asController.waitTime.value = val;
                              print("----------waitTime-------");
                            },
                          ),
                          SizedBox(height: SizeUtils.verticalBlockSize * 2),
                          _settingItem(
                            AppString.ReplyOnce,
                            AppString.ReplyMassage,
                            isSwitch: value,
                            value: asController.replyOnce.value,
                            onChanged: (val) {
                              print("----------replyOnce-------");
                              asController.replyOnce.value = val;
                              print("----------replyOnce-------");
                            },
                          ),
                          SizedBox(height: SizeUtils.verticalBlockSize * 3.5),
                          AppText(
                            AppString.ReplyHeader,
                            color: homePageController.isSwitched.value
                                ? AppColor.whiteColor
                                : AppColor.textColor,
                            fontSize: SizeUtils.fSize_16(),
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: SizeUtils.verticalBlockSize * 3.5),
                          _settingItem(
                            AppString.Enable,
                            AppString.EnableMassage,
                            isSwitch: value,
                            value: asController.enable.value,
                            onChanged: (val) {
                              print("----------waitTime-------");
                              asController.enable.value = val;
                              print("----------waitTime-------");
                            },
                          ),
                          SizedBox(height: SizeUtils.verticalBlockSize * 2),
                          _settingItem(
                            AppString.HeaderText,
                            AppString.AutoReply,
                          ),
                          SizedBox(height: SizeUtils.verticalBlockSize * 3.5),
                          AppText(
                            AppString.AppSecurity,
                            color: homePageController.isSwitched.value
                                ? AppColor.whiteColor
                                : AppColor.textColor,
                            fontSize: SizeUtils.fSize_16(),
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: SizeUtils.verticalBlockSize * 3.5),
                          _settingItem(
                            AppString.AppLockPassword,
                            AppString.AppLockPasswordMassage,
                            isSwitch: value,
                            value: asController.appLockPassword.value,
                            onChanged: (val) {
                              print("----------waitTime-------");
                              asController.appLockPassword.value = val;
                              print("----------waitTime-------");
                            },
                          ),
                          SizedBox(height: SizeUtils.verticalBlockSize * 4),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _settingItem(
    final String? item,
    final String? aboutItem, {
    final bool isSwitch = false,
    final bool value = false,
    final ValueChanged<bool>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText(
              item ?? "",
              color: homePageController.isSwitched.value
                  ? AppColor.whiteColor
                  : AppColor.textColor,
              fontSize: SizeUtils.fSize_14(),
              fontWeight: FontWeight.w600,
            ),
            const Spacer(),
            if (isSwitch)
              GestureDetector(
                onTap: () {
                  !value;
                },
                child: SizedBox(
                  height: SizeUtils.verticalBlockSize * 2,
                  width: SizeUtils.horizontalBlockSize * 12,
                  child: Switch(
                    value: value,
                    onChanged: onChanged,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              )
            else
              const SizedBox(),
          ],
        ),
        SizedBox(height: SizeUtils.verticalBlockSize * 0.7),
        AppText(
          aboutItem ?? "",
          color: homePageController.isSwitched.value
              ? AppColor.whiteColor
              : AppColor.textColor.withOpacity(0.5),
          fontSize: SizeUtils.fSize_14(),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
