import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';

class HomePageController extends GetxController {
  RxBool isSwitched = false.obs;

  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    onThemeChange();
    super.onInit();
  }

  void onThemeChange() {
    isSwitched.value = AppPreference.getBoolean("theme");
  }
}
