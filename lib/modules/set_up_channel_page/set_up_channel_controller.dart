import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/theme/app_string.dart';

enum AppSelectName { whatsapp, whatsappBusiness, messenger, instagram, telegram, twitter }

enum AppResponse { slack }
// enum AppUrl { url }

class SetUpChannelController extends GetxController {
  TextEditingController urlController = TextEditingController();

  RxString selectedValue = 'Selected App'.obs;
  RxBool selectWhatsapp = false.obs;
  RxBool selectWhatsappBusiness = false.obs;
  RxBool selectMessenger = false.obs;
  RxBool selectInstagram = false.obs;
  RxBool selectTelegram = false.obs;
  RxBool selectTwitter = false.obs;
  RxBool selectSlack = false.obs;
  RxBool url = false.obs;

  DataModel? dataModel;
  AppSelectedModel? appSelectedModel;

  List<DataModel> appSelect = [
    DataModel(image: AppIcons.whatsapp, name: AppString.WhatsApp),
    DataModel(image: AppIcons.whatsappBusiness, name: AppString.whatsappBusiness),
    DataModel(image: AppIcons.fbMessenger, name: AppString.messenger),
    DataModel(image: AppIcons.instagram, name: AppString.instagram),
    DataModel(image: AppIcons.telegram, name: AppString.telegram),
    DataModel(image: AppIcons.twitter, name: AppString.twitter),
  ];

  List<AppSelectedModel> appSelectMenu = [
    AppSelectedModel(image: AppIcons.slack, name: AppString.slack),
  ];

  static const platform = MethodChannel('samples.flutter.dev/battery');

  void whatsappAppSelect(AppSelectName appSelectName) {
    platform.invokeMethod(
      'whatsappApp',
      {"autoReplyTo": appSelectName.name},
    );
  }

  void whatsappBusinessAppSelect(AppSelectName appSelectName) {
    platform.invokeMethod(
      'whatsappBusinessApp',
      {"autoReplyTo": appSelectName.name},
    );
  }

  void messengerAppSelect(AppSelectName appSelectName) {
    platform.invokeMethod(
      'messengerApp',
      {"autoReplyTo": appSelectName.name},
    );
  }

  void instagramAppSelect(AppSelectName appSelectName) {
    platform.invokeMethod(
      'instagramApp',
      {"autoReplyTo": appSelectName.name},
    );
  }

  void telegramAppSelect(AppSelectName appSelectName) {
    platform.invokeMethod(
      'telegramApp',
      {"autoReplyTo": appSelectName.name},
    );
  }

  void twitterAppSelect(AppSelectName appSelectName) {
    platform.invokeMethod(
      'twitterApp',
      {"autoReplyTo": appSelectName.name},
    );
  }

  void slackAppSelect(AppResponse appResponse) {
    platform.invokeMethod(
      'slack',
      {"autoReplyTo": appResponse.name},
    );
  }

  void showUrl() {
    platform.invokeMethod(
      'url',
      {"appUrl": urlController.text.toLowerCase().trim()},
    );
  }

  @override
  void onInit() {
    //  contactServiceController.getPhoneContacts();
    selectWhatsapp.value = AppPreference.getBoolean("whatsappApp");
    selectWhatsappBusiness.value = AppPreference.getBoolean("whatsappBusinessApp");
    selectMessenger.value = AppPreference.getBoolean("messengerApp");
    selectInstagram.value = AppPreference.getBoolean("instagramApp");
    selectTelegram.value = AppPreference.getBoolean("telegramApp");
    selectTwitter.value = AppPreference.getBoolean("twitterApp");
    selectSlack.value = AppPreference.getBoolean("slack");
    url.value = AppPreference.getBoolean("url");
    super.onInit();
  }
}

class DataModel {
  final String image;
  final String name;

  DataModel({required this.image, required this.name});
}

class AppSelectedModel {
  final String image;
  final String name;

  AppSelectedModel({required this.image, required this.name});
}
