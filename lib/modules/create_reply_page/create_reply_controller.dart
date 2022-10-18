import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/helper/toast_helper.dart';
import 'package:whatsapp_auto/modules/create_reply_page/datasources/create_reply_model.dart';
import 'package:whatsapp_auto/theme/app_string.dart';

// enum AutoReplyTo { inComingKeywordController, replyMassageController }

class CreateReplyController extends GetxController {
  final TextEditingController inComingKeywordController = TextEditingController();
  final TextEditingController replyMassageController = TextEditingController();
  RxList<CreateReplyModel> createModal = <CreateReplyModel>[].obs;
  // Timer? _timer;

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
    return null;
  }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }

  @override
  void onInit() {
    if (AppPreference.getString("CreateReplyModel") != "") {
      final Iterable l = json.decode(AppPreference.getString("CreateReplyModel"));
      final List<CreateReplyModel> posts = List<CreateReplyModel>.from(l.map((model) => CreateReplyModel.fromJson(model)));
      createModal.clear();
      createModal.addAll(posts);
    }
    super.onInit();
  }

  Future<void> saveMethode() async {
    AppPreference.setString("CreateReplyModel", json.encode(createModal));
    final Iterable l = json.decode(AppPreference.getString("CreateReplyModel"));
    final List<CreateReplyModel> posts = List<CreateReplyModel>.from(l.map((model) => CreateReplyModel.fromJson(model)));
    createModal.clear();
    createModal.addAll(posts);

    const platform = MethodChannel('samples.flutter.dev/battery');

    platform.invokeMethod('addNewMessage', {
      "message": inComingKeywordController.text.toLowerCase().trim(),
      "replyMessage": replyMassageController.text.trim(),
    });
    print("message---------->>>>>>>> ${inComingKeywordController.text}");
    print("replyMessage---------->>>>>>>> ${replyMassageController.text.trim()}");
  }

  // Future<void> autoReplay() async {
  //   await saveMethode();
  //   print("------000000------");
  //   AppPreference.setString("CreateReplyModel", json.encode(createModal));
  //   print("------111111------");
  //   final Iterable l = json.decode(AppPreference.getString("CreateReplyModel"));
  //   print("------222222------");
  //   final List<CreateReplyModel> posts = List<CreateReplyModel>.from(l.map((model) => CreateReplyModel.fromJson(model)));
  //   print("------333333------");
  //   createModal.clear();
  //   print("------44444------");
  //   createModal.addAll(posts);
  //   print("------55555------");
  //   const platform = MethodChannel('samples.flutter.dev/battery');
  //   print("saveMethode ----- >>> ${saveMethode()}");
  //   platform.invokeMethod('addNewMessageReplay', {
  //     "message": inComingKeywordController.text.toLowerCase().trim(),
  //     "replyMessageAuto": replyMassageController.text.trim(),
  //   });
  //   print("------666666------");
  // }
}
