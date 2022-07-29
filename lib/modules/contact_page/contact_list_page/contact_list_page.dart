import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/contact_list_controller.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/data_source/group_contact_select_screen.dart';
import 'package:whatsapp_auto/modules/contact_page/contact_list_page/demo_controller.dart';
import 'package:whatsapp_auto/modules/contact_page/group_page/group_controller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';

class ContactListPage extends StatelessWidget {
  ContactListPage({Key? key}) : super(key: key);

  final ThemeController themeController = Get.find();
  final ContactListController contactListController = Get.find();
  final ContactServiceController demoController = Get.find();
  final GroupController groupController = Get.find();
  RxBool val = false.obs;

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
                color: ColorRes.appBarBackground(context),
              ),
            ),
          ),
          title: AppText(
            AppString.contacts,
            fontSize: SizeUtils.fSize_18(),
            fontWeight: FontWeight.w600,
            color: ColorRes.textColor(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: SizeUtils.horizontalBlockSize * 4.5,
            right: SizeUtils.horizontalBlockSize * 4.5,
            top: SizeUtils.horizontalBlockSize * 5.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                AppString.availableContactsList,
                fontSize: SizeUtils.fSize_16(),
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 2,
              ),
              Obx(
                () => demoController.isLoader.value == true
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorCollection.greenColor,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: demoController.contactModel.length,
                          itemBuilder: (context, index) {
                            final contact = demoController.contactModel[index];
                            print('=====${demoController.contactModel[index].avatar}=====');
                            return Padding(
                              padding: EdgeInsets.only(
                                top: SizeUtils.verticalBlockSize * 1,
                                bottom: SizeUtils.verticalBlockSize * 1,
                                right: SizeUtils.horizontalBlockSize * 1,
                              ),
                              child: Row(
                                children: [
                                  if (contact.avatar != null)
                                    Container(
                                      width: SizeUtils.horizontalBlockSize * 7.6,
                                      height: SizeUtils.verticalBlockSize * 4.5,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: MemoryImage(
                                            contact.avatar!,
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
                                          contact.displayName![0],
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                    ),
                                  // if (contact.avatar == null)
                                  //   const CircleAvatar(child: Icon(Icons.person))
                                  // else
                                  //   CircleAvatar(
                                  //     backgroundImage: MemoryImage(contact.avatar!),
                                  //   ),
                                  SizedBox(
                                    width: SizeUtils.horizontalBlockSize * 5,
                                  ),
                                  AppText(
                                    contact.displayName.toString(),
                                    fontWeight: FontWeight.w400,
                                    color: themeController.isSwitched.value ? AppColor.whiteColor : AppColor.textColor,
                                    fontSize: SizeUtils.fSize_14(),
                                  ),
                                  const Spacer(),
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
                                        child: Obx(
                                          () => Checkbox(
                                            value: contact.isCheck?.value,
                                            activeColor: ColorCollection.greenColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            onChanged: (value) async {
                                              if (contact.isCheck?.value == false) {
                                                contact.isCheck?.value = true;
                                                final groupSelectedModel selectedContactModels = groupSelectedModel(
                                                  displayName: contact.displayName,
                                                  mobileNumber: contact.mobileNumber,
                                                  avatar: contact.avatar,
                                                );
                                                demoController.selectedContactModel.add(
                                                  selectedContactModels,
                                                );
                                                await demoController.contactStoreModel();
                                                demoController.selectedContactModel.refresh();
                                              } else {
                                                contact.isCheck?.value = false;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
