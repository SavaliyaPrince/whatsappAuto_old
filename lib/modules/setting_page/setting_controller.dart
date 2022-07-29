import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  RxBool isSwitch = false.obs;
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
}
