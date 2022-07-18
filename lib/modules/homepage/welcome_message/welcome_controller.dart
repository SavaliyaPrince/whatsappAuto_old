import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  RxBool isWelcomeMessage = false.obs;
  RxInt isMessageSelection = 1.obs;

  TextEditingController messageController = TextEditingController();
}
