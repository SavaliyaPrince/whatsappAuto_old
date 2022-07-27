import 'package:get/get.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';

class SupportedAppController extends GetxController {
  RxBool isSwitchWhatsApp = false.obs;
  RxBool isSwitchMessanger = false.obs;
  RxBool isSwitchViber = false.obs;
  RxString responseFromNativeCode = 'Waiting for Response...'.obs;
  RxString response = "".obs;
  @override
  void onInit() {
    isSwitchWhatsApp.value = AppPreference.whatsApp;
    isSwitchMessanger.value = AppPreference.fbMassager;
    isSwitchViber.value = AppPreference.viber;
    super.onInit();
  }
}
