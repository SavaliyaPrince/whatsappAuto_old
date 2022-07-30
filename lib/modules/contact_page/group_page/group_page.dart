import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/contact_list_controller.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/demo_controller.dart';
import 'package:whatsapp_auto/modules/contact_page/group_page/group_controller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class GroupsSettingsPage extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final GroupController groupController = Get.find();
  final ContactListController contactListController = Get.find();
  final ContactServiceController demoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorRes.backgroundColor(context),
        appBar: AppBar(
          elevation: 0.2,
          backgroundColor: themeController.isSwitched.value
              ? AppColor.darkThem.withOpacity(0.2)
              : AppColor.whiteColor,
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
                color: themeController.isSwitched.value
                    ? AppColor.whiteColor
                    : AppColor.backIconColor,
              ),
            ),
          ),
          title: AppText(
            AppString.gropeSetting,
            fontSize: SizeUtils.fSize_18(),
            fontWeight: FontWeight.w600,
            color: themeController.isSwitched.value
                ? AppColor.whiteColor
                : AppColor.backIconColor,
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
                  color: themeController.isSwitched.value
                      ? AppColor.whiteColor
                      : AppColor.textColor,
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3.5,
                ),
                _autoReplyWidget(
                  title: AppString.allGroups,
                  description: AppString.allDescription,
                  value: groupController.isSwitchAllGroups.value,
                  onChanged: (value) {
                    groupController.isSwitchAllGroups.value = value;
                    groupController.isSwitchGroupsList.value = false;
                    groupController.isSwitchExpectList.value= false;
                  },
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3.5,
                ),
                _autoReplyWidget(
                  title: AppString.myGroupList,
                  description: AppString.groupListDescription,
                  value: groupController.isSwitchGroupsList.value,
                  onChanged: (value) {
                    groupController.isSwitchGroupsList.value = value;
                    groupController.isSwitchAllGroups.value = false;
                    groupController.isSwitchExpectList.value = false;
                  },
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3.5,
                ),
                _autoReplyWidget(
                  title: AppString.expectList,
                  description: AppString.expectDescription,
                  value: groupController.isSwitchExpectList.value,
                  onChanged: (value) {
                    groupController.isSwitchExpectList.value = value;
                    groupController.isSwitchGroupsList.value = false;
                    groupController.isSwitchAllGroups.value = false;
                  },
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      AppString.groupList,
                      fontSize: SizeUtils.fSize_16(),
                      color: themeController.isSwitched.value
                          ? AppColor.whiteColor
                          : AppColor.textColor,
                      fontWeight: FontWeight.w500,
                    ),
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
                  ],
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 2,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: demoController.selectedContactModel.length,
                  itemBuilder: (context, index) {
                    final selectedContact = demoController
                        .selectedContactModel[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        top: SizeUtils.verticalBlockSize * 1,
                        bottom: SizeUtils.verticalBlockSize * 1,
                        right: SizeUtils.horizontalBlockSize * 1,
                      ),
                      child: Row(
                        children: [
                            Container(
                              width:
                              SizeUtils.horizontalBlockSize * 7.6,
                              height: SizeUtils.verticalBlockSize * 4.5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.primaryColor,
                              ),
                              child: Center(
                                child: AppText(
                                  selectedContact.displayName![0],
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          SizedBox(
                            width: SizeUtils.horizontalBlockSize * 5,
                          ),
                          AppText(
                            selectedContact.displayName.toString(),
                            fontWeight: FontWeight.w400,
                            color: themeController.isSwitched.value
                                ? AppColor.whiteColor
                                : AppColor.textColor,
                            fontSize: SizeUtils.fSize_14(),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                                   demoController.selectedContactModel.removeAt(index);
                            },
                            child: Icon(
                              Icons.close,
                              color: themeController.isSwitched.value
                                  ? AppColor.whiteColor.withOpacity(0.5)
                                  : AppColor.textColor.withOpacity(0.5),
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

  Widget _autoReplyWidget({
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
                color: themeController.isSwitched.value
                    ? AppColor.whiteColor
                    : AppColor.textColor,
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 0.7,
              ),
              AppText(
                description!,
                fontWeight: FontWeight.w400,
                fontSize: SizeUtils.fSize_14(),
                color: themeController.isSwitched.value
                    ? AppColor.whiteColor.withOpacity(0.6)
                    : AppColor.textColor.withOpacity(0.6),
              ),
            ],
          ),
        ),
        SizedBox(
          width: SizeUtils.horizontalBlockSize * 9.8,
          height: SizeUtils.verticalBlockSize * 2.7,
          child: Switch(
            value: value!,
            activeColor: ColorCollection.greenColor,
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}
