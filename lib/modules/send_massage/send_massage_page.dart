import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/homepage/homePageCantroller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';
import 'package:whatsapp_auto/widgets/app_textfield.dart';
import 'package:whatsapp_auto/widgets/button.dart';

class SendMassagePage extends StatelessWidget {
  SendMassagePage({Key? key}) : super(key: key);
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
          backgroundColor: homePageController.isSwitched.value
              ? AppColor.appBarColors
              : AppColor.appBackgroundColor,
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
                    ? AppColor.whiteColor
                    : AppColor.backIconColor,
              ),
            ),
          ),
          title: AppText(
            AppString.sendMassage,
            fontSize: SizeUtils.fSize_17(),
            fontWeight: FontWeight.w600,
            color: homePageController.isSwitched.value
                ? AppColor.whiteColor
                : AppColor.textColor,
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    AppString.anyoneSend,
                    fontSize: SizeUtils.fSize_14(),
                    fontWeight: FontWeight.w400,
                    color: homePageController.isSwitched.value
                        ? AppColor.whiteColor
                        : AppColor.textColor.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: SizeUtils.fSize_20(),
                  ),
                  AppTextField(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.horizontalBlockSize * 4),
                    hintText: AppString.phoneNumber,
                    // contentPadding: ,
                  ),
                  SizedBox(
                    height: SizeUtils.fSize_14(),
                  ),
                  AppTextField(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: SizeUtils.verticalBlockSize * 1.5,
                        horizontal: SizeUtils.horizontalBlockSize * 4),
                    hintText: AppString.typeMassage,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(bottom: SizeUtils.horizontalBlockSize * 5),
              child: createButton(
                onTap: () {},
                text: AppString.send,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
