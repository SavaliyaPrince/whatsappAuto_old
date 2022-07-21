import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static void toastMessage(
    String message,
  ) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14);
  }
}
