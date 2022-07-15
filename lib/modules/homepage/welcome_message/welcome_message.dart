import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/button.dart';

class WelcomeMessage extends StatelessWidget {
  static const routeName = '/WelcomeMessage_screen';

  const WelcomeMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back)),
            SizedBox(
              width: SizeUtils.horizontalBlockSize * 4,
            ),
            const Text(
              AppString.welcomeMessageTitle,
              style: TextStyle(color: AppColor.textColor),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 4),
            child: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.horizontalBlockSize * 5,
                vertical: SizeUtils.verticalBlockSize * 2),
            child: Column(
              children: [Box()],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: SizeUtils.verticalBlockSize * 2),
            child: createButton(text: "Create welcome message"),
          )
        ],
      ),
    );
  }

  Widget Box() {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.splashScreenBackgroundColor10,
          borderRadius:
              BorderRadius.circular(SizeUtils.horizontalBlockSize * 2)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.horizontalBlockSize * 5,
            vertical: SizeUtils.verticalBlockSize * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Send welcome message",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.toggle_on_outlined,
                  size: SizeUtils.horizontalBlockSize * 10,
                )
              ],
            ),
            const Text(
              "send a welcome message when\nsomeone message you first time or every 3 days once",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColor.iconColor),
            )
          ],
        ),
      ),
    );
  }
}
