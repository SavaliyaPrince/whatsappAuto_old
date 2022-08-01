import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/banner_ad.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/setting_page/setting_controller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  final SettingController settingController = Get.put(SettingController());
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const BannerAdView(),
      backgroundColor: ColorRes.backgroundColor(context),
      appBar: AppBar(
        elevation: 0.2,

        backgroundColor: themeController.isSwitched.value
            ? AppColor.darkThem.withOpacity(0.2)
            : AppColor.whiteColor,
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
              color: themeController.isSwitched.value ? AppColor.whiteColor : Colors.black,
            ),
          ),
        ),
        title: AppText(
          AppString.setting,
          color: themeController.isSwitched.value ? AppColor.whiteColor : AppColor.backIconColor,
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
                  AppIcons.upgrade,
                  AppString.upgrade,
                  onTap: () {},
                ),
                // _settingItem(
                //   context,
                //   AppIcons.advance,
                //   AppString.advance,
                //   onTap: () {
                //     Navigation.pushNamed(Routes.asPage);
                //   },
                // ),
                _settingItem(
                  context,
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
                      value: settingController.isSwitch.value,
                      onChanged: (value) {
                        settingController.isSwitch.value = value;
                      },
                    ),
                  ),
                ),
                _settingItem(
                  context,
                  AppIcons.privacy,
                  AppString.Privacy,
                  onTap: () {},
                ),
                _settingItem(
                  context,
                  AppIcons.help,
                  AppString.Help,
                  onTap: () {},
                ),
                _settingItem(
                  context,
                  AppIcons.inviteFriends,
                  AppString.InviteFriends,
                  onTap: () async {
                    settingController.shareNoteLink(title: "Test");
                  },
                )
              ],
            )
          else
            Column(
              children: [
                _settingItem(
                  context,
                  AppIcons.autoReply,
                  AppString.autoReply,
                  onTap: () {
                    Navigation.pushNamed(Routes.autoReplyMassage);
                  },
                ),
                _settingItem(
                  context,
                  AppIcons.upgrade,
                  AppString.upgrade,
                  onTap: () {},
                ),
                // _settingItem(
                //   context,
                //   AppIcons.advance,
                //   AppString.advance,
                //   onTap: () {
                //     Navigation.pushNamed(Routes.asPage);
                //   },
                // ),
                _settingItem(
                  context,
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
                      value: settingController.isSwitch.value,
                      onChanged: (value) {
                        settingController.isSwitch.value = value;
                      },
                    ),
                  ),
                ),
                _settingItem(
                  context,
                  AppIcons.profileContact,
                  AppString.contact,
                  onTap: () {
                    Navigation.pushNamed(Routes.contactPage);
                  },
                ),
                _settingItem(
                  context,
                  AppIcons.privacy,
                  AppString.Privacy,
                  onTap: () {},
                ),
                _settingItem(
                  context,
                  AppIcons.help,
                  AppString.Help,
                  onTap: () {},
                ),
                _settingItem(
                  context,
                  AppIcons.inviteFriends,
                  AppString.InviteFriends,
                  onTap: () async {
                    settingController.shareNoteLink(title: "Test");
                  },
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget _settingItem(
    BuildContext context,
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
