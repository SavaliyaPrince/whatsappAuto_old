import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class AppException implements Exception {
  //un_known error code -> 0

  late String message;
  String? tag;
  int errorCode;

  AppException({required this.message, required this.errorCode, this.tag});

  int getErrorCode() => errorCode;

  String getMessage() => message;

  String getMessageWithTag() => "${tag ?? 'noTag'} : $message";

  String? getTag() => tag;

  @override
  String toString() {
    return "${errorCode.toString()} : ${tag ?? 'noTag'} : $message";
  }

  static void showException(dynamic exception, [dynamic stackTrace]) {
    if (exception is AppException) {
      exception.show();
    } else if (exception is SocketException) {
      AppException(
              message: exception.message,
              errorCode: exception.osError?.errorCode ?? 0)
          .show();
    } else if (exception is HttpException) {
      AppException(message: 'could Not Find The Requested Data', errorCode: 0)
          .show();
    } else if (exception is FormatException) {
      AppException(message: 'badResponse Format', errorCode: 0).show();
    } else {
      AppException(message: 'something Went Wrong', errorCode: 0).show();
    }
  }

  void show() {
    AppSnackBar.showErrorSnackBar(message: message, title: 'error');
  }
}

class AppSnackBar {
  static void showErrorSnackBar(
      {required String message,
      required String title,
      SnackPosition? snackPosition}) {
    Get.snackbar(title, message,
        snackPosition: snackPosition ?? SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        borderRadius: 8,
        backgroundColor: Colors.black45,
        animationDuration: const Duration(milliseconds: 500),
        barBlur: 10,
        colorText: Colors.white,
        isDismissible: false);
  }
}
