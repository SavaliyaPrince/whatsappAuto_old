import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/demo_controller.dart';

class GroupController extends GetxController {
  RxBool isSwitchAllGroups = false.obs;
  RxBool isSwitchGroupsList = false.obs;
  RxBool isSwitchExpectList = false.obs;
  RxList<String> groupContact = <String>[].obs;
  ContactServiceController demoController = Get.find();

  @override
  void onInit() {
    isSwitchAllGroups.value = AppPreference.getBoolean("switchAllGroups");
    print("switchAllGroups  ----->:${AppPreference.getBoolean("switchAllGroups")}");

    isSwitchGroupsList.value = AppPreference.getBoolean("isSwitchGroupsList");
    print("isSwitchGroupsList  ----->:${AppPreference.getBoolean("isSwitchGroupsList")}");

    isSwitchExpectList.value = AppPreference.getBoolean('isSwitchExpectList');
    print("isSwitchExpectList  ----->:${AppPreference.getBoolean("isSwitchExpectList")}");
    super.onInit();
  }


  // Future<void> addToSP(List<List<SelectedContactModel>> tList) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('graphLists', jsonEncode(tList));
  // }
  //
  // Future<void> getSP() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final List<dynamic> jsonData =
  //   jsonDecode(prefs.getString('graphLists') ?? '[]');
  //   demoController.selectedContactModel.value =  json.decode(AppPreference.getString("CreateReplyModel"));
  //       final List<SelectedContactModel> posts = List<SelectedContactModel>.from(
  //         l.map((models) => SelectedContactModel.fromJson(models)),
  //       );
  // }
}
