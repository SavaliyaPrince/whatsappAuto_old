import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static void toastMessage(
    String message,
    Color backgroundColor,
  ) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: backgroundColor,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14);
  }
}
