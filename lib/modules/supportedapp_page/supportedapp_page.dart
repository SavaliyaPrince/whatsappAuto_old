import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/supportedapp_page/supporredapp_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class SupportedAppPage extends StatelessWidget {
  SupportedAppPage({Key? key}) : super(key: key);
  final SupportedAppController supportedAppController =
      Get.put(SupportedAppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor(context),
      appBar: AppBar(
        backgroundColor: ColorRes.appBarBackground(context),
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
            ),
          ),
        ),
        title: AppText(
          AppString.supportedApps,
          fontWeight: FontWeight.w600,
          color: ColorRes.textColor(context),
        ),
      ),
      body: Padding(
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
              () => _enableApps(context,
                  image: AppIcons.whatsapp,
                  text: AppString.WhatsApp,
                  value: supportedAppController.isSwitchWhatsApp.value,
                  onChanged: (value) {
                supportedAppController.isSwitchWhatsApp.value = value;
              }),
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 2,
            ),
            Obx(
              () => _enableApps(context,
                  image: AppIcons.fbMessenger,
                  text: AppString.Messanger,
                  value: supportedAppController.isSwitchMessanger.value,
                  onChanged: (value) {
                supportedAppController.isSwitchMessanger.value = value;
              }),
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 2,
            ),
            Obx(
              () => _enableApps(
                context,
                image: AppIcons.viber,
                text: AppString.Viber,
                value: supportedAppController.isSwitchViber.value,
                onChanged: (value) {
                  supportedAppController.isSwitchViber.value = value;
                },
              ),
            )
          ],
        ),
      ),
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
