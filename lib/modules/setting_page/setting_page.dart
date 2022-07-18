import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/setting_page/setting_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  final SettingController settingController = Get.put(SettingController());
  final ValueNotifier<bool> _isDisable = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const AppText(
          AppString.setting,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _isDisable,
        builder: (BuildContext context, value, Widget? child) {
          return Column(
            children: [
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
                onTap: () {},
              ),
              _settingItem(
                AppIcons.appearance,
                AppString.Appearance,
                onTap: () {},
              ),
              _settingItem(
                AppIcons.notification,
                AppString.Notification,
                onTap: () {},
              ),
              ListTile(
                leading: Image.asset(
                  AppIcons.notification,
                  width: SizeUtils.fSize_24(),
                ),
                title: AppText(
                  AppString.Notification,
                  color: AppColor.textColor,
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
          );
        },
      ),
    );
  }

  Widget _settingItem(
    final String? image,
    final String? text, {
    final GestureTapCallback? onTap,
    final bool showTrilling = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Image.asset(
          image ?? '',
          width: SizeUtils.fSize_24(),
        ),
        title: Text(
          text ?? '',
          style: TextStyle(
            fontSize: SizeUtils.fSize_14(),
            color: AppColor.textColor,
            fontWeight: FontWeight.w600,
            fontFamily: AppString.fonts,
          ),
        ),
        trailing: showTrilling
            ? Obx(
                () => Switch(
                  value: settingController.isSwitch.value,
                  onChanged: (value) {
                    settingController.isSwitch.value = value;
                  },
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
