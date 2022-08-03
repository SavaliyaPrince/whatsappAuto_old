import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/contact_service_controller.dart';

class GroupController extends GetxController {
  RxBool isSwitchAllGroups = false.obs;
  RxBool isSwitchGroupsList = false.obs;
  RxBool isSwitchExpectList = false.obs;
  RxList<String> groupContact = <String>[].obs;
  ContactServiceController demoController = Get.find();

  @override
  void onInit() {
    isSwitchAllGroups.value = AppPreference.getBoolean("SwitchAllGroups");
    isSwitchGroupsList.value = AppPreference.getBoolean("SwitchGroupsList");
    isSwitchExpectList.value = AppPreference.getBoolean('ExpectList');
    super.onInit();
  }
}
