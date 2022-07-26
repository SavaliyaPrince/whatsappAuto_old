import 'dart:convert';

import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/chat_page/data_source/chat_modal.dart';

class ChatTestController extends GetxController {
  RxList<ChatModel> chatModal = <ChatModel>[].obs;

  @override
  void onInit() {
    if (AppPreference.getString("chatModal") != "") {
      final Iterable l = json.decode(AppPreference.getString("chatModal"));
      final List<ChatModel> posts =
          List<ChatModel>.from(l.map((model) => ChatModel.fromJson(model)));
      chatModal.clear();
      chatModal.addAll(posts);
    }
    super.onInit();
  }
}
