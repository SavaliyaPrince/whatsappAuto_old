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

  // testing method
  Future<void> nativeCode() async {
    // platform.invokeMethod('autoReplyTo', 'everyone');
    // platform.invokeMethod('autoReplyTo', 'myContacts');
    // platform.invokeMethod('autoReplyTo', 'exceptMyContacts');
  }

  void changeAutoReplyTo (AutoReplyTo autoReplyTo) {
    platform.invokeMethod(
      'autoReplyTo',
      {"autoReplyTo": autoReplyTo.name},
    );
  }

  void passAllContacts() {
    const MethodChannel platform = MethodChannel('samples.flutter.dev/battery');

    final List<String> allContacts = [];
    for(final items in contactServiceController.contactModel){
      allContacts.add(items.displayName.toString().trim());
      print('checkNumber --${items.mobileNumber.toString().trim()}--');
      allContacts.add(items.mobileNumber.toString().trim());
    }

    platform.invokeMethod(
      'allContacts',
      {"contactList": allContacts.toString()},
    );
  }


  @override
  void onInit() {
    nativeCode();
    isSwitchEveryone.value = AppPreference.getBoolean("everyone");
    isSwitchMyContact.value = AppPreference.getBoolean("contactList");
    isSwitchExpectContact.value = AppPreference.getBoolean('expectContact');
    isSwitchPhoneContact.value = AppPreference.getBoolean("phoneContact");
    super.onInit();
  }
}
