import 'dart:developer';
import 'dart:io';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/banner_ad.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/toast_helper.dart';
import 'package:whatsapp_auto/modules/send_massage/send_message_controller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_textfield.dart';
import 'package:whatsapp_auto/widgets/image_text_button.dart';

class SendMessageScreen extends StatefulWidget {
  SendMessageScreen({Key? key}) : super(key: key);

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  final SendMessageController _sendMessageController = Get.find();
  final ThemeController themeController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const BannerAdView(),
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: themeController.isSwitched.value
            ? AppColor.darkThem.withOpacity(0.2)
            : AppColor.whiteColor,
        leadingWidth: SizeUtils.horizontalBlockSize * 10,
        leading: GestureDetector(
          onTap: () {
            Navigation.pop();
          },
          child: Padding(
            padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 3),
            child: Image.asset(
              AppIcons.backIcon,
              color: themeController.isSwitched.value
                  ? AppColor.whiteColor
                  : AppColor.backIconColor,
            ),
          ),
        ),
        title: Text(
          AppString.welcomeMessageTitle,
          style: TextStyle(
            color: themeController.isSwitched.value
                ? AppColor.whiteColor
                : AppColor.backIconColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.horizontalBlockSize * 5),
          child: Column(
            children: [
              SizedBox(
                height: SizeUtils.verticalBlockSize * 2,
              ),
              Text(
                AppString.anyoneSend,
                style: TextStyle(
                  color: AppColor.iconColor,
                  fontSize: SizeUtils.fSize_14(),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 3,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    SizeUtils.horizontalBlockSize * 10,
                  ),
                  color: AppColor.whiteColor,
                ),
                child: AppTextField(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 4),
                  onChanged: (value) {},
                  controller: _sendMessageController.phoneController,
                  hintText: AppString.phoneNumber,
                  keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 1.5,
              ),
              Container(
                height: SizeUtils.verticalBlockSize * 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    SizeUtils.horizontalBlockSize * 2,
                  ),
                  color: AppColor.whiteColor,
                ),
                child: AppTextField(
                  maxLines: 50,
                  onChanged: (value) {},
                  controller: _sendMessageController.textController,
                  hintText: AppString.typeMassage,
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 5,
              ),
              ImageTextButton(
                onTap: () async {
                  if (_sendMessageController.phoneController.text != "") {
                    _sendMessageController.onOpenWhatsApp(
                        _sendMessageController.phoneController.text,
                        _sendMessageController.textController.text);
                  } else {
                    AppToast.toastMessage("Enter Mobile Number");
                  }
                },
                text: AppString.openWhatsapp,
                buttonColor: AppColor.primaryColor,
                textColor: AppColor.whiteColor,
                icon: Icons.whatsapp,
                width: SizeUtils.horizontalBlockSize * 50,
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 3,
              ),
              ImageTextButton(
                onTap: () async {
                  if (_sendMessageController.phoneController.text != "") {
                    if (Platform.isAndroid) {
                      final prefs = await SharedPreferences.getInstance();
                      String mobileNumber =
                          await _sendMessageController.getCountryNumber();
                      if (mobileNumber == "" &&
                          prefs.getString("countryCode") != null) {
                        mobileNumber = prefs.getString("countryCode") ?? "";
                      }

                      final uri =
                          'sms:$mobileNumber?body=${_sendMessageController.textController.text}%20';
                      log("Sms :- $uri");
                      await launch(uri);
                    } else if (Platform.isIOS) {
                      final uri =
                          'sms:${_sendMessageController.phoneController.text}&body=${_sendMessageController.textController.text}%20';
                      await launch(uri);
                    }
                  } else {
                    AppToast.toastMessage("Enter Mobile Number");
                  }
                },
                text: AppString.openMessage,
                buttonColor: AppColor.primaryColor,
                textColor: AppColor.whiteColor,
                icon: Icons.message,
                width: SizeUtils.horizontalBlockSize * 48,
              ),
              Obx(
                () => SizedBox(
                  height: isBannerLoaded.value
                      ? SizeUtils.verticalBlockSize * 8
                      : 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPermission() async {
    await Geolocator.requestPermission();
    final permission = await Permission.location.status.isGranted;

    if (permission) {
      // final Position position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.high);
      // _homePageController.countryCode.value = country.phoneCode;
      // await prefs.setString("countryCode", country.phoneCode);
    }
  }

  Future<void> callHistoryButtonClick() async {
    try {
      if (_sendMessageController.contactList.isEmpty) {
        await CallLog.get();
      }
    } catch (e) {
      await openAppSettings();
    }
    if (!_sendMessageController.isShowDialPad.value) {
      if (await Permission.phone.status == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      } else {
        if (_sendMessageController.contactList.isEmpty) {
          await getContact();
        }
      }
    }
    _sendMessageController.isShowDialPad.value =
        !_sendMessageController.isShowDialPad.value;
    _sendMessageController.isShowCallHistory.value =
        !_sendMessageController.isShowCallHistory.value;
  }

  Future<void> getContact() async {
    try {
      _sendMessageController.contactList.clear();
      final entries = await CallLog.get();
      for (var element in entries) {
        if (_sendMessageController.contactList.length < 100 &&
            _sendMessageController.contactList.indexWhere(
                    (elementInner) => elementInner.name == element.name) ==
                -1) {
          _sendMessageController.contactList.add(element);
        }
      }
    } catch (e, st) {
      log("e : $e , st $st");
    }
    setState(() {});
  }

  Future<void> dialogBox(BuildContext context) async {
    await showDialog(
      barrierColor: Colors.black38,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: AlertDialog(
            title: Center(
              child: Text(
                "Attention",
                style: TextStyle(
                  // height: 1.2,
                  fontSize: SizeUtils.fSize_18(),
                  fontWeight: FontWeight.w500,
                  // fontFamily: StringRes.mukta,
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We need the call log permission to fetch the recent call history to make the life easier for sending whatsapp message by single tap",
                  style: TextStyle(
                    height: 1.5,
                    fontSize: SizeUtils.fSize_14(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: SizeUtils.horizontalBlockSize * 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: SizeUtils.fSize_14(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeUtils.horizontalBlockSize * 5,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop(true);
                        callHistoryButtonClick();
                      },
                      child: Text(
                        "Allow",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: SizeUtils.fSize_14(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
