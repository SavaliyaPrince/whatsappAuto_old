import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';

class SettingController extends GetxController {
  RxBool isSwitch = false.obs;
  NewVersion? newVersion;
  Future<void> shareNoteLink({required String title}) async {
    try {
      await FlutterShare.share(
          title: 'Mobile Tv For The Creative World',
          text:
              "Check out $title on Telly, where I've been tracking all my films and shows!",
          linkUrl: '',
          chooserTitle: 'Telly');
    } catch (e) {
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
