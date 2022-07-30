import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/banner_ad.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class AutoReply extends StatelessWidget {
  AutoReply({Key? key}) : super(key: key);

  final ValueNotifier<bool> _isDisable = ValueNotifier(true);
  final ThemeController themeController = Get.find()..getMessageCount();
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
          AppString.autoReplyMassage,
          fontSize: SizeUtils.fSize_17(),
          fontWeight: FontWeight.w600,
          color: themeController.isSwitched.value
              ? AppColor.whiteColor
              : AppColor.backIconColor,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 4),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                AppIcons.import,
                width: SizeUtils.fSize_24(),
                color: themeController.isSwitched.value
                    ? AppColor.whiteColor
                    : AppColor.backIconColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: SizeUtils.verticalBlockSize * 2.7),
              AppText(
                "${themeController.totalMassageSent}",
                color: AppColor.primaryColor,
                fontSize: SizeUtils.fSize_24(),
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: SizeUtils.verticalBlockSize * 0.7),
              AppText(
                AppString.massageSent,
                color: ColorRes.textColor(context),
                fontSize: SizeUtils.fSize_16(),
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: SizeUtils.verticalBlockSize * 0.7),
              AppText(
                AppString.lastSync,
                color: ColorRes.textColor(context),
                fontSize: SizeUtils.fSize_14(),
              ),
              SizedBox(height: SizeUtils.verticalBlockSize * 3.2),
              ValueListenableBuilder(
                valueListenable: _isDisable,
                builder: (BuildContext context, bool value, Widget? child) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          replyMassageItem(
                            context,
                            AppIcons.whatsapp,
                            AppString.welcomeMessage,
                            "${AppString.massageSent}  ${themeController.whatsAppMassageSent.isEmpty ? 0 : themeController.whatsAppMassageSent}",
                            colorText:
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                themeController.whatsAppMassageSent.isEmpty
                                    ? false
                                    : value,
                          ),
                          replyMassageItem(
                            context,
                            AppIcons.telegram,
                            AppString.Telegram,
                            "${AppString.massageSent} ${themeController.telegramMassageSent.isEmpty ? 0 : themeController.telegramMassageSent}",
                            colorText:
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                themeController.telegramMassageSent.isEmpty
                                    ? false
                                    : value,
                          ),
                        ],
                      ),
                      SizedBox(height: SizeUtils.verticalBlockSize * 2.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          replyMassageItem(
                            context,
                            AppIcons.viber,
                            AppString.instagram,
                            "${AppString.massageSent} 0",
                          ),
                          replyMassageItem(
                            context,
                            AppIcons.fbMessenger,
                            AppString.Messanger,
                            "${AppString.massageSent} ${themeController.fbMassangerMassageSent.isEmpty ? 0 : themeController.fbMassangerMassageSent}",
                            colorText:
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                themeController.fbMassangerMassageSent.isEmpty
                                    ? false
                                    : value,
                          ),
                        ],
                      ),
                      SizedBox(height: SizeUtils.verticalBlockSize * 2.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          replyMassageItem(
                            context,
                            AppIcons.line,
                            AppString.LineMessenger,
                            "${AppString.massageSent} ${themeController.lineMassangerMassageSent.isEmpty ? 0 : themeController.lineMassangerMassageSent}",
                            colorText:
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                themeController.lineMassangerMassageSent.isEmpty
                                    ? false
                                    : value,
                          ),
                          replyMassageItem(
                            context,
                            AppIcons.discord,
                            AppString.Messanger,
                            "${AppString.massageSent} ${themeController.discordMassangerMassageSent.isEmpty ? 0 : themeController.discordMassangerMassageSent}",
                            colorText:
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                themeController
                                        .discordMassangerMassageSent.isEmpty
                                    ? false
                                    : value,
                          ),
                        ],
                      ),
                    ],
                  );
                },
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

  Widget replyMassageItem(
    BuildContext context,
    final String icon,
    final String iconName,
    final String massageSent, {
    final bool colorText = false,
  }) {
    return Container(
      width: SizeUtils.horizontalBlockSize * 43,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorRes.textColor(context),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          // horizontal: SizeUtils.horizontalBlockSize * 4.5,
          vertical: SizeUtils.verticalBlockSize * 1.5,
        ),
        child: Column(
          children: [
            Image.asset(
              icon,
              width: SizeUtils.horizontalBlockSize * 9,
            ),
            SizedBox(height: SizeUtils.verticalBlockSize * 1),
            AppText(
              iconName,
              fontWeight: FontWeight.w400,
              fontSize: SizeUtils.fSize_14(),
              color: ColorRes.textColor(context),
            ),
            SizedBox(height: SizeUtils.verticalBlockSize * 1),
            AppText(
              massageSent,
              fontWeight: FontWeight.w400,
              fontSize: SizeUtils.fSize_12(),
              color: colorText
                  ? AppColor.primaryColor
                  : ColorRes.textColor(context),
            ),
          ],
        ),
      ),
    );
  }
}
