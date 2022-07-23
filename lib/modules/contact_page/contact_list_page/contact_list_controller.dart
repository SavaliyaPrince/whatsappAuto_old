import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';

class ContactListController extends GetxController {
  RxBool isLoader = false.obs;
  RxList<Contact> contacts = <Contact>[].obs;

  // permission handler contact
  Future<PermissionStatus> _contactsPermissions() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }

  //Function to import contacts
  Future<void> getContacts() async {
    try {
      isLoader.value = true;
      final PermissionStatus contactsPermissionsStatus =
          await _contactsPermissions();
      if (contactsPermissionsStatus == PermissionStatus.granted) {
        Navigation.pushNamed(Routes.contactListPage);
        print(
            '------GRANTED-------${PermissionStatus.granted}-------GRANTED-------');
        final List<Contact> _contacts = await ContactsService.getContacts();
        contacts.value = _contacts;
        isLoader.value = false;
      }
    } catch (e, st) {
      print('------e----$e--------st-------$st-----');
    }
  }
}
