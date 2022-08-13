import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/banner_ad.dart';
import 'package:whatsapp_auto/Utils/interstitial_ad.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/Utils/open_ad.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/toast_helper.dart';
import 'package:whatsapp_auto/modules/homepage/homePageCantroller.dart';
import 'package:whatsapp_auto/modules/setting_page/setting_controller.dart';
import 'package:whatsapp_auto/modules/setting_page/widget/supportedapp_page/supporredapp_controller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with WidgetsBindingObserver {
  final ThemeController themeController = Get.find();
  final HomePageController homePageController = Get.put(HomePageController());
  final SupportedAppController supportedAppController =
      Get.put(SupportedAppController())..getWhatsAuto();
  final SettingController settingController = Get.put(SettingController());
  final InAppReview inAppReview = InAppReview.instance;
  bool isPaused = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      log("home Screen test");
      if (message != null) {
        // if (message.data["page"] == "example") {
        //   // Get.to(const NotificationOpenScreen());
        // }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print("------AppLifecycleState---1-->$state");
      isPaused = true;
    }
    if (state == AppLifecycleState.inactive && isPaused) {
      print("------AppLifecycleState---2->$state");
      AppOpenAdManager.showOpenAdIfAvailable();
      isPaused = false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            elevation: 0.2,
            backgroundColor: themeController.isSwitched.value
                ? AppColor.darkThem.withOpacity(0.2)
                : AppColor.appBarColors,
            automaticallyImplyLeading: false,
            title: Padding(
              padding:
                  EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 1.2),
              child: AppText(
                AppString.whatsAuto,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: SizeUtils.fSize_18(),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeUtils.verticalBlockSize * 2,
              horizontal: SizeUtils.horizontalBlockSize * 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            image: AssetsPath.messages,
                            onTap: () {
                              Navigation.pushNamed(Routes.sendMassagePage);
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                          customCategoriesBox(
                            context,
                            titleText: AppString.InviteFriends,
                            subtitle: AppString.testReplySubTile,
                            image: AssetsPath.invite,
                            onTap: () {
                              settingController.shareNoteLink(
                                  title: AppString.InviteFriends);
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
                              InterstitalAd.showInterstitialAd();
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
                            image: AssetsPath.star,
                            onTap: () async {
                              if (await inAppReview.isAvailable()) {
                                inAppReview.requestReview();
                              } else {
                                AppToast.toastMessage(
                                    "app review not available at time.");
                              }
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
                            image: AssetsPath.messages,
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
                            subtitle: AppString.menuReplySubTile,
                            image: AssetsPath.emoji,
                            onTap: () {
                              InterstitalAd.showInterstitialAd();
                              Navigation.pushNamed(Routes.createReply);
                            },
                          ),
                          SizedBox(height: SizeUtils.verticalBlockSize * 1.5),
                          customCategoriesBox(
                            context,
                            titleText: AppString.contact,
                            subtitle: AppString.emojiSubTile,
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
                            titleText: AppString.InviteFriends,
                            subtitle: AppString.documentSubTile,
                            image: AssetsPath.invite,
                            onTap: () {
                              settingController.shareNoteLink(
                                  title: AppString.InviteFriends);
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                          //

                          customCategoriesBox(
                            context,
                            titleText: AppString.settingTitle,
                            subtitle: AppString.settingSubTile,
                            image: AssetsPath.setting,
                            onTap: () {
                              // InterstitalAd.showInterstitialAd();
                              Navigation.pushNamed(Routes.settingPage);
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),

                          customCategoriesBox(
                            context,
                            titleText: AppString.documentTitle,
                            subtitle: AppString.categorySubTile,
                            image: AssetsPath.star,
                            onTap: () async {
                              if (await inAppReview.isAvailable()) {
                                inAppReview.requestReview();
                              } else {
                                AppToast.toastMessage(
                                    "app review not available at time.");
                              }
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          bottomSheet: const BannerAdView(),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: themeController.isSwitched.value
              ? AppColor.homeScreen.withOpacity(0.1)
              : AppColor.whiteColor,
          borderRadius:
              BorderRadius.circular(SizeUtils.horizontalBlockSize * 2),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeUtils.verticalBlockSize * 2,
            horizontal: SizeUtils.horizontalBlockSize * 4,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "$image",
                width: SizeUtils.horizontalBlockSize * 12,
              ),
              SizedBox(
                width: SizeUtils.horizontalBlockSize * 5,
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
                        color: ColorRes.textColor(context).withOpacity(0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: SizeUtils.horizontalBlockSize * 5,
                color: ColorRes.textColor(context).withOpacity(0.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
