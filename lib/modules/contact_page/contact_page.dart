import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_controller.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/contact_list_controller.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/demo_controller.dart';
import 'package:whatsapp_auto/modules/contact_page/group_page/group_controller.dart';
import 'package:whatsapp_auto/modules/homepage/homePageCantroller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class ContactPage extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final ContactController contactController = Get.put(ContactController());
  final ContactListController contactListController = Get.put(ContactListController());
  final ContactServiceController demoController = Get.put(ContactServiceController());
  final GroupController groupController = Get.put(GroupController());
  final HomePageController homePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorRes.backgroundColor(context),
        appBar: AppBar(
          elevation: 0.2,
          backgroundColor: themeController.isSwitched.value ? AppColor.darkThem.withOpacity(0.2) : AppColor.whiteColor,
          title: AppText(
            AppString.contact,
            fontSize: SizeUtils.fSize_18(),
            fontWeight: FontWeight.w600,
            color: ColorRes.textColor(context),
          ),
          leadingWidth: SizeUtils.fSize_40(),
          leading: GestureDetector(
            onTap: () {
              Navigation.pop();
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeUtils.horizontalBlockSize * 3,
              ),
              child: Image.asset(
                AppIcons.backIcon,
                color: themeController.isSwitched.value ? AppColor.whiteColor : AppColor.backIconColor,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeUtils.horizontalBlockSize * 4.5,
              right: SizeUtils.horizontalBlockSize * 4.5,
              top: SizeUtils.horizontalBlockSize * 5.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  AppString.autoReplyTo,
                  fontSize: SizeUtils.fSize_16(),
                  fontWeight: FontWeight.w500,
                  color: ColorRes.textColor(context),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3.5,
                ),
                _autoReplyWidget(
                  context,
                  title: AppString.everyone,
                  description: AppString.everyoneDescription,
                  value: contactController.isSwitchEveryone.value,
                  onChanged: (value) {
                    if (contactController.isSwitchEveryone.value == false) {
                      contactController.isSwitchEveryone.value = true;
                      AppPreference.setBoolean("everyone", value: contactController.isSwitchEveryone.value);
                      contactController.nativeCode();
                      print("everyone  ----->:${AppPreference.getBoolean("everyone")}");
                      AppPreference.clearSharedPreferences("contactList");
                      AppPreference.clearSharedPreferences("expectContact");
                      AppPreference.clearSharedPreferences("phoneContact");
                      contactController.isSwitchMyContact.value = false;
                      contactController.isSwitchExpectContact.value = false;
                      contactController.isSwitchPhoneContact.value = false;
                    } else {
                      contactController.isSwitchEveryone.value = false;
                      AppPreference.clearSharedPreferences("everyone");
                    }
                  },
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3,
                ),
                _autoReplyWidget(
                  context,
                  title: AppString.myContactList,
                  description: AppString.contactListDescription,
                  value: contactController.isSwitchMyContact.value,
                  onChanged: (value) {
                    if (contactController.isSwitchMyContact.value == false) {
                      contactController.isSwitchMyContact.value = true;
                      AppPreference.setBoolean("contactList", value: contactController.isSwitchMyContact.value);
                      contactController.nativeCode();
                      print("contactList  ----->:${AppPreference.getBoolean("contactList")}");
                      AppPreference.clearSharedPreferences("everyone");
                      AppPreference.clearSharedPreferences("expectContact");
                      AppPreference.clearSharedPreferences("phoneContact");
                      contactController.isSwitchExpectContact.value = false;
                      contactController.isSwitchEveryone.value = false;
                      contactController.isSwitchPhoneContact.value = false;
                    } else {
                      contactController.isSwitchMyContact.value = false;
                      AppPreference.clearSharedPreferences("contactList");
                    }
                  },
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3,
                ),
                _autoReplyWidget(
                  context,
                  title: AppString.exceptMyContactList,
                  description: AppString.exceptContactDescription,
                  value: contactController.isSwitchExpectContact.value,
                  onChanged: (value) {
                    if (contactController.isSwitchExpectContact.value == false) {
                      contactController.isSwitchExpectContact.value = true;
                      AppPreference.setBoolean("expectContact", value: contactController.isSwitchExpectContact.value);
                      contactController.nativeCode();
                      print("expectContact  ----->:${AppPreference.getBoolean("expectContact")}");
                      AppPreference.clearSharedPreferences("everyone");
                      AppPreference.clearSharedPreferences("contactList");
                      AppPreference.clearSharedPreferences("phoneContact");
                      contactController.isSwitchPhoneContact.value = false;
                      contactController.isSwitchMyContact.value = false;
                      contactController.isSwitchEveryone.value = false;
                    } else {
                      print("isSwitchExpectContact  4----->:${contactController.isSwitchExpectContact.value}");
                      contactController.isSwitchExpectContact.value = false;
                      AppPreference.clearSharedPreferences("expectContact");
                    }
                  },
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3,
                ),
                _autoReplyWidget(
                  context,
                  title: AppString.exceptMyPhoneContacts,
                  description: AppString.exceptMyPhoneDescription,
                  value: contactController.isSwitchPhoneContact.value,
                  onChanged: (value) {
                    if (contactController.isSwitchPhoneContact.value == false) {
                      contactController.isSwitchPhoneContact.value = true;
                      AppPreference.setBoolean("phoneContact", value: contactController.isSwitchPhoneContact.value);
                      contactController.nativeCode();
                      print("phoneContact  ---ff-->:${AppPreference.getBoolean("phoneContact")}");
                      AppPreference.clearSharedPreferences("everyone");
                      AppPreference.clearSharedPreferences("contactList");
                      AppPreference.clearSharedPreferences("expectContact");
                      contactController.isSwitchExpectContact.value = false;
                      contactController.isSwitchMyContact.value = false;
                      contactController.isSwitchEveryone.value = false;
                    } else {
                      contactController.isSwitchPhoneContact.value = false;
                      AppPreference.clearSharedPreferences("phoneContact");
                    }
                  },
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3,
                ),
                Row(
                  children: [
                    Container(
                      width: SizeUtils.horizontalBlockSize * 4.8,
                      height: SizeUtils.verticalBlockSize * 2.8,
                      color: Colors.transparent,
                      child: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: ColorRes.textColor(context).withOpacity(0.3),
                        ),
                        child: Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            value: contactController.checkEnable.value,
                            activeColor: ColorCollection.greenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onChanged: (value) {
                              contactController.checkEnable.value = value!;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeUtils.horizontalBlockSize * 2.5,
                    ),
                    AppText(
                      AppString.enableGroups,
                      fontSize: SizeUtils.fSize_14(),
                      fontWeight: FontWeight.w500,
                      color: ColorRes.textColor(context),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigation.pushNamed(Routes.groupsSettingPage);
                      },
                      child: SizedBox(
                        width: SizeUtils.horizontalBlockSize * 4.8,
                        height: SizeUtils.verticalBlockSize * 2.4,
                        child: Image.asset(
                          AppIcons.setting_bold,
                          width: SizeUtils.horizontalBlockSize * 3,
                          height: SizeUtils.verticalBlockSize * 3,
                          color: ColorRes.textColor(context),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                Row(
                  children: [
                    AppText(
                      AppString.contactList,
                      fontSize: SizeUtils.fSize_16(),
                      fontWeight: FontWeight.w500,
                      color: ColorRes.textColor(context),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        demoController.getContacts1();
                      },
                      child: Container(
                        width: SizeUtils.horizontalBlockSize * 13.3,
                        height: SizeUtils.verticalBlockSize * 4.7,
                        decoration: BoxDecoration(
                          color: ColorCollection.greenColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.textColor.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(1, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeUtils.horizontalBlockSize * 0.8,
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 2.7,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: demoController.contactModel.length,
                  itemBuilder: (context, index) {
                    print("contactListController.contacts.length -=-=-==-==-=-=-=- ${demoController.contactModel.length}");
                    return Padding(
                      padding: EdgeInsets.only(
                        top: SizeUtils.verticalBlockSize * 1.3,
                        bottom: SizeUtils.verticalBlockSize * 1,
                        right: SizeUtils.horizontalBlockSize * 1,
                      ),
                      child: Row(
                        children: [
                          if (demoController.contactModel[index].avatar != null)
                            Container(
                              width: SizeUtils.horizontalBlockSize * 7.6,
                              height: SizeUtils.verticalBlockSize * 4.5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: MemoryImage(
                                    demoController.contactModel[index].avatar!,
                                  ),
                                ),
                                color: Colors.red,
                              ),
                            )
                          else
                            Container(
                              width: SizeUtils.horizontalBlockSize * 7.6,
                              height: SizeUtils.verticalBlockSize * 4.5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.primaryColor,
                              ),
                              child: Center(
                                child: AppText(
                                  demoController.contactModel[index].displayName![0].toUpperCase(),
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          SizedBox(
                            width: SizeUtils.horizontalBlockSize * 5,
                          ),
                          AppText(
                            demoController.contactModel[index].displayName.toString().toLowerCase(),
                            fontWeight: FontWeight.w400,
                            color: ColorRes.textColor(context),
                            fontSize: SizeUtils.fSize_14(),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              demoController.contactModel.removeAt(index);
                            },
                            child: Icon(
                              Icons.close,
                              color: ColorRes.textColor(context).withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _autoReplyWidget(
    BuildContext context, {
    final VoidCallback? onTap,
    final String? title,
    final String? description,
    final bool? value,
    final ValueChanged<bool>? onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title!,
                fontSize: SizeUtils.fSize_14(),
                fontWeight: FontWeight.w500,
                color: ColorRes.textColor(context),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 0.7,
              ),
              AppText(
                description!,
                fontWeight: FontWeight.w400,
                fontSize: SizeUtils.fSize_14(),
                color: ColorRes.textColor(context).withOpacity(0.6),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onTap,
          child: SizedBox(
            width: SizeUtils.horizontalBlockSize * 9.8,
            height: SizeUtils.verticalBlockSize * 2.7,
            child: Switch(
              value: value!,
              activeColor: ColorCollection.greenColor,
              onChanged: onChanged,
            ),
          ),
        )
      ],
    );
  }
}
