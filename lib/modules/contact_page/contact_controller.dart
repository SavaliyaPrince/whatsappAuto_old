import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/demo_controller.dart';

class ContactController extends GetxController {
  final ContactServiceController contactServiceController = Get.put(ContactServiceController());
  RxBool isSwitchEveryone = false.obs;
  RxBool isSwitchMyContact = false.obs;
  RxBool isSwitchExpectContact = false.obs;
  RxBool isSwitchPhoneContact = false.obs;
  RxBool checkEnable = false.obs;

  void nativeCode() {
    const platform = MethodChannel('samples.flutter.dev/battery');

    final List<String> allContacts = [];
    allContacts.add('87588588888');
    platform.invokeMethod('allContacts', allContacts);


    // platform.invokeMethod('autoReplyTo', 'everyone');
    // platform.invokeMethod('autoReplyTo', 'myContacts');
    // platform.invokeMethod('autoReplyTo', 'exceptMyContacts');
  }

  @override
  void onInit() {
    isSwitchEveryone.value = AppPreference.getBoolean("everyone");
    print("phoneContact  ----->:${AppPreference.getBoolean("everyone")}");

    isSwitchMyContact.value = AppPreference.getBoolean("contactList");
    print("phoneContact  ----->:${AppPreference.getBoolean("contactList")}");

    isSwitchExpectContact.value = AppPreference.getBoolean('expectContact');
    print("phoneContact  ----->:${AppPreference.getBoolean("expectContact")}");

    isSwitchPhoneContact.value = AppPreference.getBoolean("phoneContact");
    print("phoneContact  ----->:${AppPreference.getBoolean("phoneContact")}");
    super.onInit();
  }
}
