import 'dart:io';

import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/theme/app_string.dart';

class SettingController extends GetxController {
  RxBool isNotificationCheck = false.obs;

  @override
  void onInit() {
    super.onInit();
    isNotificationCheck.value = AppPreference.notification;
  }

  Future<void> shareNoteLink({required String title}) async {
    try {
      await FlutterShare.share(
          title: AppString.InviteFriends,
          text: "",
          linkUrl: Platform.isAndroid
              ? 'https://play.google.com/store/apps/details?id=com'
                  '.whatsapp_auto.app'
              : "https://apps.apple.com/app/id1638722301",
          chooserTitle: 'WhatsApp Tool');
    } finally {}
  }
// void basicStatusCheck() {
//   newVersion?.showAlertIfNecessary(context: context);
// }
//
// Future<void> advancedStatusCheck() async {
//   final status = await newVersion?.getVersionStatus();
//   if (status != null) {
//     debugPrint(status.releaseNotes);
//     debugPrint(status.appStoreLink);
//     debugPrint(status.localVersion);
//     debugPrint(status.storeVersion);
//     debugPrint(status.canUpdate.toString());
//     newVersion?.showUpdateDialog(
//       context: context,
//       versionStatus: status,
//       dialogTitle: 'Custom Title',
//       dialogText: 'Custom Text',
//     );
//   }
// }
//
// @override
// void onInit() {
//   super.onInit();
//   newVersion = NewVersion(
//     iOSId: 'com.google.Vespa',
//     androidId: 'com.google.android.apps.cloudconsole',
//   );
//
//   // You can let the plugin handle fetching the status and showing a dialog,
//   // or you can fetch the status and display your own dialog, or no dialog.
//   const simpleBehavior = true;
//
//   if (simpleBehavior) {
//     basicStatusCheck();
//   } else {
//     advancedStatusCheck();
//   }
// }
}
