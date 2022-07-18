import 'package:flutter/material.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';

import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';
import 'package:whatsapp_auto/widgets/categories_box.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const AppText(
          AppString.whatsAuto,
          color: AppColor.whiteColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: SizeUtils.verticalBlockSize * 2,
          left: SizeUtils.horizontalBlockSize * 5,
          right: SizeUtils.horizontalBlockSize * 5,
        ),
        // padding: EdgeInsets.only(top: SizeUtils.verticalBlockSize * 14, left: SizeUtils.horizontalBlockSize * 5,right: SizeUtils.horizontalBlockSize * 5),
        child: Stack(
          children: [
            const Text(
              AppString.availableCategories,
              style: TextStyle(color: AppColor.textColor, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: SizeUtils.verticalBlockSize * 5),
                child: Column(
                  children: [
                    customCategoriesBox(
                        titleText: AppString.welcomeMessageTitle,
                        subtitle: AppString.welcomeMessageSubTile,
                        image: AssetsPath.star,
                        onTap: () {
                          // Get.toNamed(WelcomeMessage.routeName);
                        }),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1.5,
                    ),
                    customCategoriesBox(
                      titleText: AppString.emojiTitle,
                      subtitle: AppString.emojiSubTile,
                      image: AssetsPath.emoji,
                      onTap: () {},
                    ),
                    // SizedBox(
                    //   height: SizeUtils.verticalBlockSize * 1.5,
                    // ),
                    // customCategoriesBox(
                    //   titleText: AppString.menuReplyTitle,
                    //   subtitle: AppString.menuReplySubTile,
                    //   image: AssetsPath.messages,
                    //   onTap: () {},
                    // ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1.5,
                    ),
                    customCategoriesBox(
                      titleText: AppString.categoryTitle,
                      subtitle: AppString.categorySubTile,
                      image: AssetsPath.category,
                      onTap: () {},
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1.5,
                    ),
                    customCategoriesBox(
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
                      titleText: AppString.documentTitle,
                      subtitle: AppString.documentSubTile,
                      image: AssetsPath.document,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
