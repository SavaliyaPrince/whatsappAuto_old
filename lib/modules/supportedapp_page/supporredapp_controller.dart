import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';

class SupportedAppController extends GetxController {
  RxBool isSwitchWhatsApp = false.obs;
  RxBool isSwitchMessanger = false.obs;
  RxBool isSwitchInstagram = false.obs;
  RxBool isSwitchWhatsAppBusi = false.obs;
  RxBool isSwitchTelegram = false.obs;
  RxBool isSwitchTwitter = false.obs;
  RxString responseFromNativeCode = 'Waiting for Response...'.obs;
  RxString response = "".obs;

  @override
  void onInit() {
    isSwitchWhatsApp.value = AppPreference.whatsApp;
    isSwitchMessanger.value = AppPreference.fbMassager;
    isSwitchInstagram.value = AppPreference.instagrams;
    isSwitchWhatsAppBusi.value = AppPreference.whatsAppBusi;
    isSwitchTelegram.value = AppPreference.telegram;
    isSwitchTwitter.value = AppPreference.twitter;
    super.onInit();
  }

  Future<void> getPhoneContacts() async {
    try {
      final PermissionStatus contactsPermissionsStatus =
          await contactsPermissions();
      print("getPhoneContacts :- 2 $contactsPermissionsStatus");
      if (contactsPermissionsStatus == PermissionStatus.granted) {}
    } catch (e, st) {
      print('------e----$e----+----st-------$st-----');
    }
  }

  Future<PermissionStatus> contactsPermissions() async {
    final PermissionStatus permission = await Permission.contacts.status;

    if (permission != PermissionStatus.granted) {
      final Map<Permission, PermissionStatus> permissionStatus = await [
        Permission.contacts,
        Permission.phone,
      ].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }
}
