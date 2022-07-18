import 'package:flutter/material.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/theme/app_color.dart';

Widget customCategoriesBox({
  required String? titleText,
  required String? subtitle,
  required String? image,
  required GestureTapCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          // border: Border.all(width: 0.1, color: AppColor.textColor),
          borderRadius:
              BorderRadius.circular(SizeUtils.horizontalBlockSize * 2)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: SizeUtils.verticalBlockSize * 2,
            horizontal: SizeUtils.horizontalBlockSize * 4),
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
                    style: const TextStyle(
                        color: AppColor.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 0.5,
                  ),
                  Text(
                    "$subtitle",
                    style: const TextStyle(
                        color: AppColor.iconColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: SizeUtils.verticalBlockSize * 1.8),
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                size: SizeUtils.horizontalBlockSize * 5,
                color: AppColor.iconColor,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

// ListTile(
//   leading: Container(
//     child: Image.asset("${image}",width: SizeUtils.horizontalBlockSize * 10,),
//   ),
//   // CircleAvatar(
//   //   backgroundImage: AssetImage("${image}"),
//   // ),
//   title: Text(
//     "${titleText}",
//     style: const TextStyle(color: AppColor.textColor,fontSize: 16,fontWeight: FontWeight.w500),
//   ),
//   subtitle: Text(
//     "${subtitle}",
//     style: const TextStyle(color: AppColor.iconColor,fontSize: 14,fontWeight: FontWeight.w400),
//   ),
//   trailing: Icon(
//     Icons.arrow_forward_ios_outlined,
//     size: SizeUtils.horizontalBlockSize * 5,
//     color: AppColor.iconColor,
//   ),
// ),
