import 'package:flutter/material.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';

class ImageTextButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final Color? buttonColor;
  final Color? textColor;
  final IconData? icon;
  final double? width;

  ImageTextButton({
    this.onTap,
    this.text,
    this.buttonColor,
    this.textColor,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeUtils.horizontalBlockSize * 3,
          ),
          color: buttonColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.horizontalBlockSize * 5,
              vertical: SizeUtils.verticalBlockSize * 1.2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: textColor,
                size: SizeUtils.horizontalBlockSize * 6,
              ),
              SizedBox(
                width: SizeUtils.horizontalBlockSize * 3,
              ),
              Text(
                text ?? "",
                style: TextStyle(
                  color: textColor,
                  fontSize: SizeUtils.fSize_16(),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
