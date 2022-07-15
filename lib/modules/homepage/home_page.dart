import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/homepage/welcome_message/welcome_message.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/categories_box.dart';

class HomePageScreen extends StatelessWidget {
  static const routeName = '/Homepage_screen';

  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColors,
        title: const Text(
          AppString.whatsAuto,
          style: TextStyle(color: AppColor.whiteColor),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 4),
            child: Row(
              children: [
                Image.asset(
                  AssetsPath.notification,
                  width: SizeUtils.horizontalBlockSize * 6,
                ),
                SizedBox(
                  width: SizeUtils.horizontalBlockSize * 4,
                ),
                const Icon(
                  Icons.more_vert,
                  color: AppColor.whiteColor,
                )
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Container(
          //   height: SizeUtils.verticalBlockSize * 11,
          //   color: AppColor.appBarColors,
          //   child: Padding(
          //     padding: EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 4,bottom: SizeUtils.verticalBlockSize *1.5,left: SizeUtils.horizontalBlockSize * 3),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //        const Expanded(
          //           child: Text(
          //             AppString.whatsAuto,
          //             style: TextStyle(color: AppColor.whiteColor,fontSize: 20,fontWeight: FontWeight.w600),
          //           ),
          //         ),
          //         Image.asset(
          //           AssetsPath.notification,
          //           width: SizeUtils.horizontalBlockSize * 6.2,
          //         ),
          //         SizedBox(width:  SizeUtils.horizontalBlockSize * 3,),
          //         const Icon(
          //           Icons.more_vert,
          //           color: AppColor.whiteColor,
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeUtils.verticalBlockSize * 2,
                left: SizeUtils.horizontalBlockSize * 5,
                right: SizeUtils.horizontalBlockSize * 5),
            // padding: EdgeInsets.only(top: SizeUtils.verticalBlockSize * 14, left: SizeUtils.horizontalBlockSize * 5,right: SizeUtils.horizontalBlockSize * 5),
            child: Stack(
              children: [
                const Text(
                  AppString.availableCategories,
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: SizeUtils.verticalBlockSize * 5),
                    child: Column(
                      children: [
                        customCategoriesBox(
                            titleText: AppString.welcomeMessageTitle,
                            subtitle: AppString.welcomeMessageSubTile,
                            image: AssetsPath.star,
                            onTap: () {
                              Get.toNamed(WelcomeMessage.routeName);
                            }),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 1.5,
                        ),
                        customCategoriesBox(
                            titleText: AppString.menuReplyTitle,
                            subtitle: AppString.menuReplySubTile,
                            image: AssetsPath.messages,
                            onTap: () {}),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 1.5,
                        ),
                        customCategoriesBox(
                            titleText: AppString.emojiTitle,
                            subtitle: AppString.emojiSubTile,
                            image: AssetsPath.emoji,
                            onTap: () {}),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 1.5,
                        ),
                        customCategoriesBox(
                            titleText: AppString.settingTitle,
                            subtitle: AppString.settingSubTile,
                            image: AssetsPath.setting,
                            onTap: () {}),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 1.5,
                        ),
                        customCategoriesBox(
                            titleText: AppString.categoryTitle,
                            subtitle: AppString.categorySubTile,
                            image: AssetsPath.category,
                            onTap: () {}),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 1.5,
                        ),
                        customCategoriesBox(
                            titleText: AppString.documentTitle,
                            subtitle: AppString.documentSubTile,
                            image: AssetsPath.document,
                            onTap: () {}),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
