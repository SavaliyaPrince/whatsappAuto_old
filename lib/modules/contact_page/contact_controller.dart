import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/contact_service_controller.dart';

enum AutoReplyTo { everyone, my_contact_list, except_my_contact_list, except_my_phone_contacts }

class ContactController extends GetxController {
  final ContactServiceController contactServiceController = Get.put(ContactServiceController());
  RxBool isSwitchEveryone = false.obs;
  RxBool isSwitchMyContact = false.obs;
  RxBool isSwitchExpectContact = false.obs;
  RxBool isSwitchPhoneContact = false.obs;
  RxBool checkEnable = false.obs;
  String? result;
  RxString? deviceInfo;
  List<dynamic> phoneNumbersList = <dynamic>[];
  static const platform = MethodChannel('samples.flutter.dev/battery');

  void changeAutoReplyTo (AutoReplyTo autoReplyTo) {
    platform.invokeMethod(
      'autoReplyTo',
      {"autoReplyTo": autoReplyTo.name},
    );
  }


  @override
  void onInit() {
  //  contactServiceController.getPhoneContacts();
    isSwitchEveryone.value = AppPreference.getBoolean("everyone");
    isSwitchMyContact.value = AppPreference.getBoolean("contactList");
    isSwitchExpectContact.value = AppPreference.getBoolean('expectContact');
    isSwitchPhoneContact.value = AppPreference.getBoolean("phoneContact");
    checkEnable.value = AppPreference.getBoolean("checkEnable");
    super.onInit();
  }
}
