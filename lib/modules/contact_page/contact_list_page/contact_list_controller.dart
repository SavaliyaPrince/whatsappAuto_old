import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';

class ContactListController extends GetxController {
  RxBool isLoader = false.obs;
  List<Contact> contacts = <Contact>[];

  ScrollController scrollController = ScrollController();
  RxInt page = 0.obs;
 // final RxInt _limit = 20.obs;
  RxBool hasNextPage = true.obs;
  RxBool isFirstLoadRunning = false.obs;
  RxBool isLoadMoreRunning = false.obs;
  RxList posts = [].obs;

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
    isFirstLoadRunning.value = true;
    print('---isFirstLoadRunning---TRUE------${isFirstLoadRunning
        .value}----isFirstLoadRunning---TRUE-------');
    try {
      isLoader.value = true;
      final PermissionStatus contactsPermissionsStatus =
          await _contactsPermissions();
      if (contactsPermissionsStatus == PermissionStatus.granted) {
        Navigation.pushNamed(Routes.contactListPage);
        print(
            '------GRANTED-------${PermissionStatus.granted}-------GRANTED-------');
        final List<Contact> _contacts = await ContactsService.getContacts();
        contacts = _contacts;
        posts.value = contacts;
        isLoader.value = false;
      }
    } catch (e, st) {
      print('------e----$e--------st-------$st-----');
    }

    isFirstLoadRunning.value = false;
    print('----isFirstLoadRunning--FALSE---${isFirstLoadRunning
        .value}----isFirstLoadRunning----FALSE-');
  }

  Future<void> _loadMore() async {
    if(hasNextPage.value == true && isFirstLoadRunning.value == false &&
        isLoadMoreRunning.value == false && scrollController.position
        .extentAfter < 300) {
      isLoadMoreRunning.value = true;
      page.value += 1;
      try {
        isLoader.value = true;
        final List<Contact> _contacts = await ContactsService.getContacts();
        final List fetchedPosts = _contacts;
        if(fetchedPosts.isNotEmpty) {
          posts.value.addAll(fetchedPosts);
        } else {
          hasNextPage.value = false;
        }
        isLoader.value = false;
      } catch (e, st) {
        print('------e----$e--------st-------$st-----');
      }
      isLoadMoreRunning.value = false;
      print('----isLoadMoreRunning---${isLoadMoreRunning.value}----isLoadMoreRunning---');
    }
  }

  @override
  void onInit() {
    getContacts();
    scrollController = ScrollController()..addListener(_loadMore);
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.removeListener(_loadMore);
    super.dispose();
  }
}
