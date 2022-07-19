import 'package:flutter/material.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/theme/app_color.dart';

class AppTextField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final String? hintText;
  int? maxLines = 1;

  AppTextField({
    this.contentPadding,
    this.maxLines,
    this.hintText,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        filled: true,
        fillColor: AppColor.appBackgroundColor,
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: SizeUtils.fSize_14(),
            color: AppColor.textColor.withOpacity(0.4),
            fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}