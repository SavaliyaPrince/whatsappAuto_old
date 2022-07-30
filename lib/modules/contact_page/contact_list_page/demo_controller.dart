import 'dart:core';
import 'dart:developer';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/data_source/contact_model.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/data_source/group_contact_select_screen.dart';

class ContactServiceController extends GetxController {
  RxList<Contact> contacts = <Contact>[].obs;
  RxBool isLoader = false.obs;
  RxBool isSelectedContactsView = false.obs;
  final RxList<ContactModel> contactModel = <ContactModel>[].obs;
  RxList<groupSelectedModel> selectedContactModel = <groupSelectedModel>[].obs;

  Future<void> getPhoneContacts() async {
    try {
      isLoader.value = true;
      print("getPhoneContacts :- 1 ${isLoader.value}");
      final PermissionStatus contactsPermissionsStatus = await _contactsPermissions();
      print("getPhoneContacts :- 2 $contactsPermissionsStatus");
      if (contactsPermissionsStatus == PermissionStatus.granted) {
        Navigation.pushNamed(Routes.contactPage);
        print('------GET-------${PermissionStatus.granted}-------GET-------');
        final List<Contact> contacts = await FlutterContacts.getContacts(withPhoto: true,withProperties: true);
        print("getPhoneContacts :- 3 ${contacts.toString()}");
        for (var i = 0; i <= contacts.length; i++) {
          print("getPhoneContacts :- 4 ${contacts.length} ===>>$i");
          final ContactModel model = ContactModel(
            displayName: contacts[i].displayName,
            mobileNumber: contacts[i].phones.toString(),
            avatar: contacts[i].photo ,
            isCheck: false.obs,
          );
          print("getPhoneContacts :- 5 ${model.mobileNumber}");
          contactModel.add(model);
        }
        isLoader.value = false;
      }
    } catch (e, st) {
      print('------e----$e----+----st-------$st-----');
    }
  }

  Future<PermissionStatus> _contactsPermissions() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted) {
      final Map<Permission, PermissionStatus> permissionStatus = await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }

  Future<void> getContacts1() async {
    try {
      isLoader.value = true;
        Navigation.pushNamed(Routes.contactListPage);
      isLoader.value = false;
    } catch (e, st) {
      print('------e----$e--------st-------$st-----');
    }
  }

  Future<void> contactStoreModel() async {
    log("groupStore 0: ${selectedContactModel.length}");
    try {
      final String encodedData = groupSelectedModel.encode(selectedContactModel);
      log("groupStore 1: $encodedData");
      await AppPreference.setString('selectedContactModel', encodedData);
      log("groupStore 2:");
    } catch (e, st) {
      print('-----$e-----STORE MODEL-----$st------');
    }
  }

  Future<void> contactGetModel() async {
    try {
      log("groupStore 3:");
      final String musicsString = AppPreference.getString('selectedContactModel');
      log("groupStore 4: $musicsString");
      final List<groupSelectedModel> musics = groupSelectedModel.decode(musicsString);
      log("groupStore 5: $musics");

      selectedContactModel.clear();
      selectedContactModel.addAll(musics);
    } catch (e, st) {
      print('-----$e-----GET MODEL-----$st------');
    }
  }


  @override
  void onInit() {
    getPhoneContacts();
    contactGetModel();
    super.onInit();
  }
}
