import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/helper/toast_helper.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/contact_list_controller.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/contact_service_controller.dart';
import 'package:whatsapp_auto/modules/contact_page/group_page/group_controller.dart';
import 'package:whatsapp_auto/modules/contact_page/group_page/group_modal.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class GroupsSettingsPage extends StatefulWidget {
  @override
  State<GroupsSettingsPage> createState() => _GroupsSettingsPageState();
}

class _GroupsSettingsPageState extends State<GroupsSettingsPage> {
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
          backgroundColor: themeController.isSwitched.value ? AppColor.darkThem.withOpacity(0.2) : AppColor.whiteColor,
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
          title: AppText(
            AppString.gropeSetting,
            fontSize: SizeUtils.fSize_18(),
            fontWeight: FontWeight.w600,
            color: themeController.isSwitched.value ? AppColor.whiteColor : AppColor.backIconColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeUtils.horizontalBlockSize * 4.5,
              right: SizeUtils.horizontalBlockSize * 4.5,
              top: SizeUtils.horizontalBlockSize * 5.5,
            ),
            child: Form(
              key: groupController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    AppString.autoReplyTo,
                    fontSize: SizeUtils.fSize_16(),
                    fontWeight: FontWeight.w500,
                    color: themeController.isSwitched.value ? AppColor.whiteColor : AppColor.textColor,
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 3.5,
                  ),
                  _autoReplyWidget(
                    title: AppString.allGroups,
                    description: AppString.allDescription,
                    value: groupController.isSwitchAllGroups.value,
                    onChanged: (value) {
                      if (groupController.isSwitchAllGroups.value == false) {
                        groupController.isSwitchAllGroups.value = true;
                        AppPreference.setBoolean("SwitchAllGroups", value: groupController.isSwitchAllGroups.value);
                        AppPreference.clearSharedPreferences("SwitchGroupsList");
                        AppPreference.clearSharedPreferences("ExpectList");
                        groupController.isSwitchGroupsList.value = false;
                        groupController.isSwitchExpectList.value = false;
                      } else {
                        groupController.isSwitchAllGroups.value = false;
                        AppPreference.clearSharedPreferences("SwitchAllGroups");
                      }
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
                      if (groupController.isSwitchGroupsList.value == false) {
                        groupController.isSwitchGroupsList.value = true;
                        AppPreference.setBoolean("SwitchGroupsList", value: groupController.isSwitchGroupsList.value);
                        AppPreference.clearSharedPreferences("SwitchAllGroups");
                        AppPreference.clearSharedPreferences("ExpectList");
                        groupController.isSwitchAllGroups.value = false;
                        groupController.isSwitchExpectList.value = false;
                      } else {
                        groupController.isSwitchGroupsList.value = false;
                        AppPreference.clearSharedPreferences("SwitchGroupsList");
                      }
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
                      if (groupController.isSwitchExpectList.value == false) {
                        groupController.isSwitchExpectList.value = true;
                        AppPreference.setBoolean("ExpectList", value: groupController.isSwitchExpectList.value);
                        AppPreference.clearSharedPreferences("SwitchAllGroups");
                        AppPreference.clearSharedPreferences("SwitchGroupsList");
                        groupController.isSwitchAllGroups.value = false;
                        groupController.isSwitchGroupsList.value = false;
                      } else {
                        groupController.isSwitchExpectList.value = false;
                        AppPreference.clearSharedPreferences("ExpectList");
                      }
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
                        color: themeController.isSwitched.value ? AppColor.whiteColor : AppColor.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                      InkWell(
                        onTap: () {
                          displayDialog(context);
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
                    itemCount: groupController.groupName.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        direction: Axis.horizontal,
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (value) {
                                setState(() {
                                  groupController.groupName.remove(groupController.groupName[index]);
                                  save();
                                });
                              },
                              backgroundColor: AppColor.primaryColor,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: SizeUtils.verticalBlockSize * 1,
                            bottom: SizeUtils.verticalBlockSize * 1,
                            right: SizeUtils.horizontalBlockSize * 1,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: SizeUtils.horizontalBlockSize * 7.6,
                                height: SizeUtils.verticalBlockSize * 4.5,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.primaryColor,
                                ),
                                child: Center(
                                  child: AppText(
                                    groupController.groupName[index].group.toString().substring(0, 1).toUpperCase(),
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeUtils.horizontalBlockSize * 5,
                              ),
                              AppText(
                                groupController.groupName[index].group ?? "",
                                fontWeight: FontWeight.w400,
                                color: themeController.isSwitched.value ? AppColor.whiteColor : AppColor.textColor,
                                fontSize: SizeUtils.fSize_14(),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  updateDisplayDialog(context,index);
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: AppColor.iconColor,
                                  size: SizeUtils.fSize_20(),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Future> displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Group List'),
          content: TextFormField(
            cursorColor: AppColor.primaryColor,
            cursorHeight: SizeUtils.verticalBlockSize * 3,
            style: TextStyle(
              fontSize: SizeUtils.fSize_14(),
            ),
            controller: groupController.textFieldController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                if (groupController.textFieldController.text.isNotEmpty) {
                  final GroupModal groupModal = GroupModal();
                  setState(() {
                    groupModal.group = groupController.textFieldController.text;
                    groupController.groupName.add(groupModal);
                    save();
                    Navigator.of(context).pop();
                    groupController.textFieldController.clear();

                  });
                } else {
                  AppToast.toastMessage("Enter Group Name");
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.verticalBlockSize * 1,
                    horizontal: SizeUtils.horizontalBlockSize * 6.5,
                  ),
                  child: const Text(
                    'ADD',
                    style: TextStyle(color: AppColor.whiteColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Future> updateDisplayDialog(BuildContext context,int? index) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Group Name'),
          content: TextFormField(
            cursorColor: AppColor.primaryColor,
            cursorHeight: SizeUtils.verticalBlockSize * 3,
            style: TextStyle(
              fontSize: SizeUtils.fSize_14(),
            ),
            controller: groupController.updateController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                if (groupController.updateController.text.isNotEmpty) {
                  print("index :- $index");
                  groupController.groupName[index??0].group = groupController.updateController.text;
                  groupController.groupName.refresh();
                  Navigation.pop();
                  groupController.updateController.clear();
                } else {
                  AppToast.toastMessage("Edit Group Name");
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.verticalBlockSize * 1,
                    horizontal: SizeUtils.horizontalBlockSize * 6.5,
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(color: AppColor.whiteColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigation.pop();
              },
            ),
          ],
        );
      },
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
                color: themeController.isSwitched.value ? AppColor.whiteColor : AppColor.textColor,
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 0.7,
              ),
              AppText(
                description!,
                fontWeight: FontWeight.w400,
                fontSize: SizeUtils.fSize_14(),
                color: themeController.isSwitched.value ? AppColor.whiteColor.withOpacity(0.6) : AppColor.textColor.withOpacity(0.6),
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
  void save() {
    AppPreference.setString("groupname", json.encode(groupController.groupName));
    final Iterable l = json.decode(AppPreference.getString("groupname"));
    final List<GroupModal> posts =
    List<GroupModal>.from(l.map((model) => GroupModal.fromJson(model)));

    groupController.groupName.clear();
    groupController.groupName.addAll(posts);
  }
}
