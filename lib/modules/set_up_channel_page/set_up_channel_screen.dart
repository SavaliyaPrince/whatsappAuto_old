import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/helper/toast_helper.dart';
import 'package:whatsapp_auto/modules/set_up_channel_page/set_up_channel_controller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';
import 'package:whatsapp_auto/widgets/app_textfield.dart';
import 'package:whatsapp_auto/widgets/button.dart';

class SetUpChannelScreen extends StatefulWidget {
  SetUpChannelScreen({Key? key}) : super(key: key);

  @override
  State<SetUpChannelScreen> createState() => _SetUpChannelScreenState();
}

class _SetUpChannelScreenState extends State<SetUpChannelScreen> {
  final ThemeController themeController = Get.find();
  final SetUpChannelController _setUpChannelController = Get.put(SetUpChannelController());
  GlobalKey<FormState> selectAppKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorRes.backgroundColor(context),
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: themeController.isSwitched.value ? AppColor.darkThem.withOpacity(0.2) : AppColor.whiteColor,
          leadingWidth: SizeUtils.horizontalBlockSize * 11.5,
          leading: GestureDetector(
            onTap: () {
              // Navigation.pop();
              Navigation.replaceAll(Routes.homePage);
            },
            child: Padding(
              padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 4.2),
              child: Image.asset(
                AppIcons.backIcon,
                color: ColorRes.appBarBackground(context),
              ),
            ),
          ),
          title: AppText(
            AppString.setUpChannel,
            fontSize: SizeUtils.fSize_17(),
            fontWeight: FontWeight.w600,
            color: ColorRes.textColor(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5, vertical: SizeUtils.verticalBlockSize * 3),
          child: Form(
            key: selectAppKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<DataModel>(
                      isExpanded: true,
                      value: _setUpChannelController.dataModel,
                      onChanged: (value) {
                        setState(() {
                          print("-------0---------");
                          _setUpChannelController.dataModel = value!;
                          print("_setUpChannelController.dataModel---->>> ${_setUpChannelController.dataModel}");
                          if (_setUpChannelController.dataModel == value) {
                            print("--------1--------");
                            AppPreference.setBoolean("whatsappApp", value: _setUpChannelController.selectWhatsapp.value);
                            print("--------2--------");
                            AppPreference.setBoolean("whatsappBusinessApp", value: _setUpChannelController.selectWhatsappBusiness.value);
                            print("--------3--------");
                            AppPreference.setBoolean("messengerApp", value: _setUpChannelController.selectMessenger.value);
                            print("--------4--------");
                            AppPreference.setBoolean("instagramApp", value: _setUpChannelController.selectInstagram.value);
                            print("--------5--------");
                            AppPreference.setBoolean("telegramApp", value: _setUpChannelController.selectTelegram.value);
                            print("--------6--------");
                            AppPreference.setBoolean("twitterApp", value: _setUpChannelController.selectTwitter.value);
                            print("--------7--------");
                            _setUpChannelController.whatsappAppSelect(AppSelectName.whatsapp);
                            print("--------8--------");
                            _setUpChannelController.whatsappBusinessAppSelect(AppSelectName.whatsappBusiness);
                            print("--------9--------");
                            _setUpChannelController.messengerAppSelect(AppSelectName.messenger);
                            print("--------11--------");
                            _setUpChannelController.instagramAppSelect(AppSelectName.instagram);
                            print("--------12--------");
                            _setUpChannelController.telegramAppSelect(AppSelectName.telegram);
                            print("--------13--------");
                            _setUpChannelController.twitterAppSelect(AppSelectName.twitter);
                            // _setUpChannelController.isSwitchMyContact.value = false;
                            // contactController.isSwitchExpectContact.value = false;
                            // contactController.isSwitchPhoneContact.value = false;
                            // contactController.isSwitchGroup.value = false;
                            print("--------13--------");
                          } else {
                            _setUpChannelController.dataModel = value;
                            print("--------14--------");
                            AppPreference.clearSharedPreferences("whatsappApp");
                            print("--------15--------");
                            AppPreference.clearSharedPreferences("whatsappBusinessApp");
                            print("--------16--------");

                            AppPreference.clearSharedPreferences("messengerApp");
                            print("--------17--------");

                            AppPreference.clearSharedPreferences("instagramApp");
                            print("--------18--------");

                            AppPreference.clearSharedPreferences("telegramApp");
                            print("--------19--------");

                            AppPreference.clearSharedPreferences("twitterApp");
                            print("--------20--------");
                          }
                          print("--------21--------");
                        });
                      },
                      hint: Text(
                        'Select App',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: _setUpChannelController.appSelect.map<DropdownMenuItem<DataModel>>((DataModel value) {
                        return DropdownMenuItem<DataModel>(
                          value: value,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Image.asset(
                                value.image,
                                height: SizeUtils.verticalBlockSize * 5,
                              ),
                              SizedBox(width: SizeUtils.horizontalBlockSize * 5),
                              Text(value.name),
                              // SizedBox(width: SizeUtils.horizontalBlockSize * 20),
                              // const Icon(
                              //   Icons.keyboard_arrow_down,
                              // ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text("To"),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<AppSelectedModel>(
                      isExpanded: true,
                      value: _setUpChannelController.appSelectedModel ?? null,
                      onChanged: (value) {
                        setState(() {
                          _setUpChannelController.appSelectedModel = value!;
                          print("_setUpChannelController.appSelectedModel ----- >>>> ${_setUpChannelController.appSelectedModel}");
                          if (_setUpChannelController.appSelectedModel == value) {
                            print("------=======00-------======");
                            AppPreference.setBoolean("slack", value: _setUpChannelController.selectSlack.value);
                            print("------=======11-------======");
                            _setUpChannelController.slackAppSelect(AppResponse.slack);
                            print("------=======22-------======");
                          } else {
                            print("------=======33-------======");
                            AppPreference.clearSharedPreferences("slack");
                            print("------=======44-------======");
                          }
                        });
                      },
                      hint: Text(
                        'Select Response App',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: _setUpChannelController.appSelectMenu.map<DropdownMenuItem<AppSelectedModel>>((AppSelectedModel value) {
                        return DropdownMenuItem<AppSelectedModel>(
                          value: value,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Image.asset(
                                value.image,
                                height: SizeUtils.verticalBlockSize * 5,
                              ),
                              SizedBox(width: SizeUtils.horizontalBlockSize * 5),
                              Text(value.name),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3,
                ),
                AppTextField(
                  // onChanged: () {
                  //   _setUpChannelController.showUrl();
                  // },
                  controller: _setUpChannelController.urlController,
                  hintText: AppString.url,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const CircleAvatar(
                        backgroundColor: AppColor.green38,
                        radius: 25,
                        child: Icon(
                          Icons.add,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 2,
                ),
                createButton(
                  onTap: () {
                    if (_setUpChannelController.dataModel!.name.isEmpty) {
                      AppToast.toastMessage(
                        AppString.selectYourApp,
                      );
                    } else if (_setUpChannelController.appSelectedModel!.name.isEmpty) {
                      AppToast.toastMessage(
                        AppString.selectYourResponseApp,
                      );
                    } else {
                      _setUpChannelController.urlController.text;
                      print("_setUpChannelController.urlController.text ---- >>>> ${_setUpChannelController.urlController.text}");
                      _setUpChannelController.showUrl();
                      print("-=-=-=-=-=-=-00-=-=-=-=-=-");
                      Navigation.pushNamed(Routes.homePage);
                      print("-=-=-=-=-=-=-11-=-=-=-=-=-");
                    }
                  },
                  text: AppString.addChannel,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
