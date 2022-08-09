import 'package:flutter/material.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/theme/app_color.dart';

Widget createButton({
  required String? text,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeUtils.verticalBlockSize * 1.8,
        ),
        child: Text(
          "$text",
          textAlign: TextAlign.center,
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
