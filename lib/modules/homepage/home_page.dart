import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/toast_helper.dart';
import 'package:whatsapp_auto/modules/homepage/homePageCantroller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.find();
  final HomePageController homePageController = Get.put(HomePageController());
  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    // homePageController.getWhatsAuto();
    // print(
    //     "----------homePageController.getWhatsAuto-----------${homePageController.getWhatsAuto()}");
    return Obx(
      () => WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Scaffold(
          backgroundColor: themeController.isSwitched.value
              ? ColorCollection.backGroundColorDark
              : AppColor.homeScreen,
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: themeController.isSwitched.value
                ? AppColor.darkThem.withOpacity(0.2)
                : AppColor.whiteColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: AppText(
              AppString.whatsAuto,
              color: themeController.isSwitched.value
                  ? AppColor.whiteColor
                  : AppColor.backIconColor,
              fontWeight: FontWeight.w600,
              fontSize: SizeUtils.fSize_18(),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: SizeUtils.horizontalBlockSize * 5,
              right: SizeUtils.horizontalBlockSize * 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.verticalBlockSize * 2,
                  ),
                  child: SizedBox(
                    // height: SizeUtils.verticalBlockSize * 7,
                    child: Text(
                      AppString.availableCategories,
                      style: TextStyle(
                        color: ColorRes.textColor(context),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (Platform.isIOS)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customCategoriesBox(
                            context,
                            titleText: AppString.welcomeMessageTitle,
                            subtitle: AppString.welcomeMessageSubTile,
                            image: AssetsPath.star,
                            onTap: () {
                              Navigation.pushNamed(Routes.sendMassagePage);
                            },
                          ),
                          // SizedBox(
                          //   height: SizeUtils.verticalBlockSize * 1.5,
                          // ),
                          // customCategoriesBox(
                          //   context,
                          //   titleText: AppString.emojiTitle,
                          //   subtitle: AppString.emojiSubTile,
                          //   image: AssetsPath.emoji,
                          //   onTap: () {
                          //     Navigation.pushNamed(Routes.createReply);
                          //   },
                          // ),
                          // SizedBox(
                          //   height: SizeUtils.verticalBlockSize * 1.5,
                          // ),
                          // customCategoriesBox(
                          //   context,
                          //   titleText: AppString.testReplyTitle,
                          //   subtitle: AppString.testReplySubTile,
                          //   image: AssetsPath.messages,
                          //   onTap: () {
                          //     Navigation.pushNamed(Routes.chatTestReply);
                          //   },
                          // ),
                          // SizedBox(
                          //   height: SizeUtils.verticalBlockSize * 1.5,
                          // ),
                          // customCategoriesBox(
                          //   context,
                          //   titleText: AppString.contactUsTitle,
                          //   subtitle: AppString.contactUsSubTile,
                          //   image: AssetsPath.document,
                          //   onTap: () {
                          //     Navigation.pushNamed(Routes.contactPage);
                          //   },
                          // ),
                          // SizedBox(
                          //   height: SizeUtils.verticalBlockSize * 1.5,
                          // ),
                          // customCategoriesBox(
                          //   context,
                          //   titleText: AppString.categoryTitle,
                          //   subtitle: AppString.categorySubTile,
                          //   image: AssetsPath.category,
                          //   onTap: () {
                          //     Navigation.pushNamed(Routes.supportedApp);
                          //   },
                          // ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                          customCategoriesBox(
                            context,
                            titleText: AppString.settingTitle,
                            subtitle: AppString.settingSubTile,
                            image: AssetsPath.setting,
                            onTap: () {
                              Navigation.pushNamed(Routes.settingPage);
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                          customCategoriesBox(
                            context,
                            titleText: AppString.documentTitle,
                            subtitle: AppString.documentSubTile,
                            image: AssetsPath.document,
                            onTap: () async {
                              if (await inAppReview.isAvailable()) {
                                print(
                                    "---appreview---:${inAppReview.isAvailable()}");
                                inAppReview.requestReview();
                              } else {
                                print("---appreview--tost--");

                                AppToast.toastMessage(
                                    "app review not available at time.");
                              }

                              // Navigation.pushNamed(Routes.chatPage);
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customCategoriesBox(
                            context,
                            titleText: AppString.welcomeMessageTitle,
                            subtitle: AppString.welcomeMessageSubTile,
                            image: AssetsPath.star,
                            onTap: () {
                              Navigation.pushNamed(Routes.sendMassagePage);
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                          customCategoriesBox(
                            context,
                            titleText: AppString.emojiTitle,
                            subtitle: AppString.emojiSubTile,
                            image: AssetsPath.emoji,
                            onTap: () {
                              Navigation.pushNamed(Routes.createReply);
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                          // customCategoriesBox(
                          //   context,
                          //   titleText: AppString.testReplyTitle,
                          //   subtitle: AppString.testReplySubTile,
                          //   image: AssetsPath.messages,
                          //   onTap: () {
                          //     Navigation.pushNamed(Routes.chatTestReply);
                          //   },
                          // ),
                          // SizedBox(
                          //   height: SizeUtils.verticalBlockSize * 1.5,
                          // ),
                          customCategoriesBox(
                            context,
                            titleText: AppString.contactUsTitle,
                            subtitle: AppString.contactUsSubTile,
                            image: AssetsPath.document,
                            onTap: () {
                              Navigation.pushNamed(Routes.contactPage);
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                          customCategoriesBox(
                            context,
                            titleText: AppString.categoryTitle,
                            subtitle: AppString.categorySubTile,
                            image: AssetsPath.category,
                            onTap: () {
                              Navigation.pushNamed(Routes.supportedApp);
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                          customCategoriesBox(
                            context,
                            titleText: AppString.settingTitle,
                            subtitle: AppString.settingSubTile,
                            image: AssetsPath.setting,
                            onTap: () {
                              Navigation.pushNamed(Routes.settingPage);
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                          customCategoriesBox(
                            context,
                            titleText: AppString.documentTitle,
                            subtitle: AppString.documentSubTile,
                            image: AssetsPath.document,
                            onTap: () async {
                              if (await inAppReview.isAvailable()) {
                                print(
                                    "---appreview---:${inAppReview.isAvailable()}");
                                inAppReview.requestReview();
                              } else {
                                print("---appreview--tost--");

                                AppToast.toastMessage(
                                    "app review not available at time.");
                              }

                              // Navigation.pushNamed(Routes.chatPage);
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                          // customCategoriesBox(
                          //   context,
                          //   titleText: AppString.contact,
                          //   subtitle: AppString.documentSubTile,
                          //   image: AssetsPath.document,
                          //   onTap: () {
                          //     Navigation.pushNamed(Routes.contactPage);
                          //   },
                          // ),
                          // SizedBox(
                          //   height: SizeUtils.verticalBlockSize * 1.5,
                          // ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customCategoriesBox(
    BuildContext context, {
    required String? titleText,
    required String? subtitle,
    required String? image,
    required GestureTapCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: themeController.isSwitched.value
              ? AppColor.homeScreen.withOpacity(0.1)
              : AppColor.whiteColor,
          // border: Border.all(width: 0.1, color: AppColor.textColor),
          borderRadius:
              BorderRadius.circular(SizeUtils.horizontalBlockSize * 2),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeUtils.verticalBlockSize * 2,
            horizontal: SizeUtils.horizontalBlockSize * 4,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "$image",
                width: SizeUtils.horizontalBlockSize * 12,
              ),
              SizedBox(
                width: SizeUtils.horizontalBlockSize * 3,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$titleText",
                      style: TextStyle(
                        color: ColorRes.textColor(context),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 0.5,
                    ),
                    Text(
                      "$subtitle",
                      style: TextStyle(
                        color: ColorRes.textColor(context),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: SizeUtils.verticalBlockSize * 1.8),
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: SizeUtils.horizontalBlockSize * 5,
                  color: ColorRes.textColor(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
