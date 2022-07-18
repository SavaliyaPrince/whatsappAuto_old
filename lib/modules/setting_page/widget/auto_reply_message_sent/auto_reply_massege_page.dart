import 'package:flutter/material.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class AutoReply extends StatelessWidget {
  AutoReply({Key? key}) : super(key: key);

  final ValueNotifier<bool> _isDisable = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: AppColor.whiteColor,
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
          AppString.autoReplyMassage,
          fontSize: SizeUtils.fSize_17(),
          fontWeight: FontWeight.w600,
          color: AppColor.textColor,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 4),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                AppIcons.import,
                width: SizeUtils.fSize_24(),
                color: AppColor.backIconColor,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: SizeUtils.verticalBlockSize * 2.7),
            AppText(
              "27",
              color: AppColor.primaryColor,
              fontSize: SizeUtils.fSize_24(),
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: SizeUtils.verticalBlockSize * 0.7),
            AppText(
              AppString.massageSent,
              color: AppColor.textColor,
              fontSize: SizeUtils.fSize_16(),
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: SizeUtils.verticalBlockSize * 0.7),
            AppText(
              AppString.lastSync,
              color: AppColor.textColor.withOpacity(0.7),
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
                          AppIcons.whatsapp,
                          AppString.welcomeMessage,
                          "${AppString.massageSent} 20",
                          colorText: value,
                        ),
                        replyMassageItem(
                          AppIcons.telegram,
                          AppString.Telegram,
                          "${AppString.massageSent} 7",
                          colorText: value,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeUtils.verticalBlockSize * 2.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        replyMassageItem(
                          AppIcons.viber,
                          AppString.Viber,
                          "${AppString.massageSent} 0",
                        ),
                        replyMassageItem(
                          AppIcons.fbMessenger,
                          AppString.Messanger,
                          "${AppString.massageSent} 0",
                        ),
                      ],
                    ),
                    SizedBox(height: SizeUtils.verticalBlockSize * 2.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        replyMassageItem(
                          AppIcons.line,
                          AppString.LineMessenger,
                          "${AppString.massageSent} 0",
                        ),
                        replyMassageItem(
                          AppIcons.discord,
                          AppString.Messanger,
                          "${AppString.massageSent} 0",
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget replyMassageItem(
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
          color: AppColor.textColor.withOpacity(0.2),
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
              color: AppColor.textColor,
            ),
            SizedBox(height: SizeUtils.verticalBlockSize * 1),
            AppText(
              massageSent,
              fontWeight: FontWeight.w400,
              fontSize: SizeUtils.fSize_12(),
              color: colorText ? AppColor.primaryColor : AppColor.textColor,
            ),
          ],
        ),
      ),
    );
  }
}
