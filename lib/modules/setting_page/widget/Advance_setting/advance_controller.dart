import 'package:get/get.dart';

class ASController extends GetxController {
  RxBool phoneIdle = false.obs;
  RxBool drivingMode = false.obs;
  RxBool waitTime = false.obs;
  RxBool replyOnce = false.obs;
  RxBool enable = false.obs;
  RxBool appLockPassword = false.obs;
}
