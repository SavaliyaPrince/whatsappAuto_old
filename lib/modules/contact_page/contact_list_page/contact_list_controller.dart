import 'package:get/get.dart';

class ContactListController extends GetxController {
  RxBool isLoader = false.obs;
 // List<Contact> contacts = <Contact>[];

  //  ScrollController scrollController = ScrollController();
  //  RxInt page = 0.obs;
  // // final RxInt _limit = 20.obs;
  //  RxBool hasNextPage = true.obs;
  //  RxBool isFirstLoadRunning = false.obs;
  //  RxBool isLoadMoreRunning = false.obs;
  //  RxList posts = [].obs;

  // // permission handler contact
  // Future<PermissionStatus> _contactsPermissions() async {
  //   final PermissionStatus permission = await Permission.contacts.status;
  //   if (permission != PermissionStatus.granted) {
  //     final Map<Permission, PermissionStatus> permissionStatus =
  //         await [Permission.contacts].request();
  //     return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
  //   } else {
  //     return permission;
  //   }
  // }
  //
  // //Function to import contacts
  // Future<void> getContacts() async {
  //   // isFirstLoadRunning.value = true;
  //   try {
  //     isLoader.value = true;
  //     final PermissionStatus contactsPermissionsStatus =
  //         await _contactsPermissions();
  //     if (contactsPermissionsStatus == PermissionStatus.granted) {
  //    //   Navigation.pushNamed(Routes.contactListPage);
  //       print(
  //         '------GRANTED-------${PermissionStatus.granted}-------GRANTED-------',
  //       );
  //       final List<Contact> _contacts = await ContactsService.getContacts();
  //      // _populateContacts(_contacts);
  //       contacts = _contacts;
  //       //posts.value = contacts;
  //       isLoader.value = false;
  //     }
  //   } catch (e, st) {
  //     print('------e----$e--------st-------$st-----');
  //   }
  //
  //   //  isFirstLoadRunning.value = false;
  // }
  //
  // Future<void> _populateContacts(Iterable<Contact> _contacts) async {
  //   contacts = contacts.where((item) => item.displayName != null).toList();
  //   contacts.sort(
  //     (a, b) => a.displayName!.compareTo(
  //       b.displayName.toString(),
  //     ),
  //   );
  //   uiCustomContacts.value = contacts
  //       .map(
  //         (contact) => CustomContact(contact: contact, isChecked: false.obs),
  //       )
  //       .toList();
  //   isLoader.value = false;
  // }

  // Future<void> _loadMore() async {
  //   if(hasNextPage.value == true && isFirstLoadRunning.value == false &&
  //       isLoadMoreRunning.value == false && scrollController.position
  //       .extentAfter < 300) {
  //     isLoadMoreRunning.value = true;
  //     page.value += 1;
  //     try {
  //       isLoader.value = true;
  //       final List<Contact> contacts = await ContactsService.getContacts();
  //       final List fetchedPosts = contacts;
  //       if(fetchedPosts.isNotEmpty) {
  //         posts.value.addAll(fetchedPosts);
  //       } else {
  //         hasNextPage.value = false;
  //       }
  //       isLoader.value = false;
  //     } catch (e, st) {
  //       print('------e----$e--------st-------$st-----');
  //     }
  //     isLoadMoreRunning.value = false;
  //     print('----isLoadMoreRunning---${isLoadMoreRunning.value}----isLoadMoreRunning---');
  //   }
  // }

  @override
  void onInit() {
//    getContacts();
    // scrollController = ScrollController()..addListener(_loadMore);
    super.onInit();
  }

  @override
  void dispose() {
//    scrollController.removeListener(_loadMore);
    super.dispose();
  }
}
