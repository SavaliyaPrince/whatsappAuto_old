import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/contact_service_controller.dart';
import 'package:whatsapp_auto/modules/contact_page/group_page/group_modal.dart';

class GroupController extends GetxController {
  RxBool isSwitchAllGroups = false.obs;
  RxBool isSwitchGroupsList = false.obs;
  RxBool isSwitchExpectList = false.obs;
  RxList<String> groupContact = <String>[].obs;
  ContactServiceController demoController = Get.find();
  TextEditingController textFieldController = TextEditingController();
  TextEditingController updateController = TextEditingController();
  RxList<GroupModal> groupName = <GroupModal>[].obs;
  RxBool editable = false.obs;
  final formKey = GlobalKey<FormState>();




  @override
  void onInit() {
    isSwitchAllGroups.value = AppPreference.getBoolean("SwitchAllGroups");
    isSwitchGroupsList.value = AppPreference.getBoolean("SwitchGroupsList");
    isSwitchExpectList.value = AppPreference.getBoolean('ExpectList');
    if (AppPreference.getString("groupname") != "") {
      final Iterable l = json.decode(AppPreference.getString("groupname"));
      final List<GroupModal> posts =
      List<GroupModal>.from(l.map((model) => GroupModal.fromJson(model)));
      groupName.clear();
      groupName.addAll(posts);
    }
    super.onInit();
  }
}
