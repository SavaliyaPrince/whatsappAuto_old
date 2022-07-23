import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/helper/toast_helper.dart';
import 'package:whatsapp_auto/modules/create_reply_page/datasources/create_reply_model.dart';
import 'package:whatsapp_auto/theme/app_string.dart';

class CreateReplyController extends GetxController {
  final TextEditingController inComingKeywordController =
      TextEditingController();
  final TextEditingController replyMassageController = TextEditingController();
  RxList<CreateReplyModel> createModal = <CreateReplyModel>[].obs;

  String? inComingKeywordValidator() {
    if (inComingKeywordController.text.isEmpty) {
      AppToast.toastMessage(
        AppString.enterInComingKeyword,
      );
    }
  }

  String? replyMassageValidator() {
    if (replyMassageController.text.isEmpty) {
      AppToast.toastMessage(
        AppString.enterReplyMassage,
      );
    }
  }

  @override
  void onInit() {
    if (AppPreference.getString("CreateReplyModel") != "") {
      final Iterable l =
          json.decode(AppPreference.getString("CreateReplyModel"));
      final List<CreateReplyModel> posts = List<CreateReplyModel>.from(
          l.map((model) => CreateReplyModel.fromJson(model)));
      createModal.clear();
      createModal.addAll(posts);
    }

    super.onInit();
  }
}
