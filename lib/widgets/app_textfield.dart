import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/homepage/homePageCantroller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';

class AppTextField extends StatelessWidget {
  final HomePageController homePageController = Get.find();
  final EdgeInsetsGeometry? contentPadding;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  int? maxLines = 1;
  final TextEditingController? controller;

  AppTextField({
    this.contentPadding,
    this.maxLines,
    this.hintText,
    this.controller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      cursorColor: Colors.grey,
      controller: controller,
      validator: validator,
      style: const TextStyle(
        color: AppColor.backIconColor,
      ),
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
