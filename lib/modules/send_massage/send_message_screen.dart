import 'dart:developer';
import 'dart:io';

import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  Country? selectedCountry;

  Future<void> initCountry() async {
    final country = await getDefaultCountry(Get.context!);
    setState(() {
      selectedCountry = country;
    });
    // getCountryCode = country.callingCode;
    print('country ${country.callingCode}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const BannerAdView(),
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: themeController.isSwitched.value ? AppColor.darkThem.withOpacity(0.2) : AppColor.whiteColor,
        leadingWidth: SizeUtils.horizontalBlockSize * 11.5,
        leading: GestureDetector(
          onTap: () {
            Navigation.pop();
          },
          child: Padding(
            padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 4.2),
            child: Image.asset(
              AppIcons.backIcon,
              color: themeController.isSwitched.value ? AppColor.whiteColor : AppColor.backIconColor,
            ),
          ),
        ),
        title: Text(
          AppString.welcomeMessageTitle,
          style: TextStyle(
            color: themeController.isSwitched.value ? AppColor.whiteColor : AppColor.backIconColor,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5),
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
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            // _sendMessageController.pickCountry(context);
                            onPressedShowBottomSheet();
                            setState(() {});
                            // Country? _selectedCountry;
                          },
                          child: Container(
                            height: SizeUtils.verticalBlockSize * 5.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:AppColor.white38,
                            ),
                            child: Center(
                              child: Text(
                                _sendMessageController.getCountryCode,
                                style: TextStyle(
                                  fontSize: SizeUtils.fSize_16(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: SizeUtils.horizontalBlockSize * 2),
                      Expanded(
                        flex: 4,
                        child: AppTextField(
                          contentPadding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 4),
                          onChanged: (value) {},
                          controller: _sendMessageController.phoneController,
                          hintText: AppString.phoneNumber,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
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
                          _sendMessageController.phoneController.text, _sendMessageController.textController.text);
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
                        String mobileNumber = "";
                        // String mobileNumber =
                        //     await _sendMessageController.getCountryNumber();
                        if (mobileNumber == "" && prefs.getString("countryCode") != null) {
                          mobileNumber = prefs.getString("countryCode") ?? "";
                        }

                        final uri = 'sms:$mobileNumber?body=${_sendMessageController.textController.text}%20';
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
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 1.5,
                ),
                Obx(
                  () => SizedBox(
                    height: isBannerLoaded.value ? SizeUtils.verticalBlockSize * 8 : 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {
        selectedCountry = country;
        print('selected COuntry ${selectedCountry!.name}');
      });
      _sendMessageController.getCountryCode = selectedCountry!.callingCode;
      // getCountryCode = country.callingCode;
    }
  }
}
