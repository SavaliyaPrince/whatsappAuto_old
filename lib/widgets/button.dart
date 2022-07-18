import 'package:flutter/material.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/theme/app_color.dart';

Widget createButton({required String? text, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: AppColor.splashScreenBackgroundColor,
        borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.horizontalBlockSize * 16,
          vertical: SizeUtils.verticalBlockSize * 1.4,
        ),
        child: Text(
          "$text",
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: SizeUtils.fSize_16(),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
