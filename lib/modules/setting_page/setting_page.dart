import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/homepage/homePageCantroller.dart';
import 'package:whatsapp_auto/modules/setting_page/setting_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  final HomePageController homePageController = Get.find();
  final SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: homePageController.isSwitched.value
            ? AppColor.darkThem
            : AppColor.lightThem,
        appBar: AppBar(
          backgroundColor: homePageController.isSwitched.value
              ? AppColor.appBackgroundColor
              : AppColor.appBarColors,
          // centerTitle: true,
          leadingWidth: SizeUtils.fSize_40(),
          leading: GestureDetector(
            onTap: () {
              Navigation.pop();
            },
            child: Padding(
              padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 3),
              child: Image.asset(
                AppIcons.backIcon,
                color: homePageController.isSwitched.value
                    ? AppColor.backIconColor
                    : AppColor.whiteColor,
              ),
            ),
          ),
          title: AppText(
            AppString.setting,
            color: homePageController.isSwitched.value
                ? AppColor.textColor
                : AppColor.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: SizeUtils.verticalBlockSize * 1),
            _settingItem(
              AppIcons.autoReply,
              AppString.autoReply,
              onTap: () {
                Navigation.pushNamed(Routes.autoReplyMassage);
              },
            ),
            _settingItem(
              AppIcons.upgrade,
              AppString.upgrade,
              onTap: () {},
            ),
            _settingItem(
              AppIcons.advance,
              AppString.advance,
              onTap: () {
                Navigation.pushNamed(Routes.asPage);
              },
            ),
            _settingItem(
              AppIcons.appearance,
              AppString.Appearance,
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
                color: homePageController.isSwitched.value
                    ? AppColor.whiteColor
                    : AppColor.textColor,
              ),
              title: AppText(
                AppString.Notification,
                color: homePageController.isSwitched.value
                    ? AppColor.whiteColor
                    : AppColor.textColor,
                fontWeight: FontWeight.w600,
                fontSize: SizeUtils.fSize_14(),
              ),
              trailing: Obx(
                () => Switch(
                  value: settingController.isSwitch.value,
                  onChanged: (value) {
                    settingController.isSwitch.value = value;
                  },
                ),
              ),
            ),
            _settingItem(
              AppIcons.privacy,
              AppString.Privacy,
              onTap: () {},
            ),
            _settingItem(
              AppIcons.help,
              AppString.Help,
              onTap: () {},
            ),
            _settingItem(
              AppIcons.inviteFriends,
              AppString.InviteFriends,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingItem(
    final String? image,
    final String? text, {
    final GestureTapCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        horizontalTitleGap: SizeUtils.horizontalBlockSize * 1,
        visualDensity: const VisualDensity(vertical: -3),
        leading: Image.asset(
          image ?? '',
          width: SizeUtils.fSize_24(),
          color: homePageController.isSwitched.value
              ? AppColor.whiteColor
              : AppColor.textColor,
        ),
        title: Text(
          text ?? '',
          style: TextStyle(
            fontSize: SizeUtils.fSize_14(),
            color: homePageController.isSwitched.value
                ? AppColor.whiteColor
                : AppColor.textColor,
            fontWeight: FontWeight.w600,
            fontFamily: AppString.fonts,
          ),
        ),
      ),
    );
  }
}
