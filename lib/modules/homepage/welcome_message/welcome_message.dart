import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/homepage/welcome_message/welcome_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/button.dart';

class WelcomeMessage extends StatelessWidget {
  static const routeName = '/WelcomeMessage_screen';
  final WelcomeController _welcomeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back),
            ),
            SizedBox(
              width: SizeUtils.horizontalBlockSize * 4,
            ),
            const Text(
              AppString.welcomeMessageTitle,
              style: TextStyle(color: AppColor.textColor),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 4),
            child: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.horizontalBlockSize * 5,
              vertical: SizeUtils.verticalBlockSize * 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Box(),
                SizedBox(
                  height: SizeUtils.horizontalBlockSize * 5,
                ),
                Text(
                  AppString.selectWelcomeMessage,
                  style: TextStyle(
                    fontSize: SizeUtils.fSize_16(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: SizeUtils.horizontalBlockSize * 2,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, i) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColor.iconColor.withOpacity(0.2),
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SizeUtils.horizontalBlockSize * 3,
                          ),
                          child: ListTile(
                            leading: Transform.scale(
                              scale: 1.4,
                              child: Radio(
                                value: i,
                                groupValue: i,
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  return (_welcomeController
                                              .isMessageSelection.value ==
                                          i)
                                      ? AppColor.primaryColor
                                      : AppColor.iconColor.withOpacity(0.2);
                                }),
                                onChanged: (value) {
                                  _welcomeController.isMessageSelection.value =
                                      int.parse(value.toString());
                                  print("value :- $value}");
                                },
                              ),
                            ),
                            title: const Text(
                                "Welcome, thank you for contacting me, I will get back to you shortly."),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: SizeUtils.verticalBlockSize * 2),
            child: createButton(
              text: AppString.createWelcomeMessage,
              onTap: () {
                welcomeMessageDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Object?> welcomeMessageDialog(BuildContext context) {
    return showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Container(
                height: SizeUtils.horizontalBlockSize * 55,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SizedBox.expand(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 7,
                      vertical: SizeUtils.horizontalBlockSize * 7,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.welcomeMessage,
                          style: TextStyle(
                            fontSize: SizeUtils.fSize_16(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.textColor,
                          ),
                        ),
                        SizedBox(
                          height: SizeUtils.horizontalBlockSize * 5,
                        ),
                        TextField(
                          controller: _welcomeController.messageController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            hintText: AppString.inputNewWelcomeMessage,
                            hintStyle: TextStyle(
                              color: AppColor.textColor.withOpacity(0.4),
                              fontSize: SizeUtils.fSize_16(),
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: SizeUtils.horizontalBlockSize * 4,
                              vertical: SizeUtils.horizontalBlockSize * 4,
                            ),
                          ),
                          onChanged: (text) {
                            //fullName = text;
                            //you can access nameController in its scope to get
                            // the value of text entered as shown below
                            //fullName = nameController.text;
                          },
                        ),
                        SizedBox(
                          height: SizeUtils.horizontalBlockSize * 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: SizeUtils.horizontalBlockSize * 12,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColor.primaryColor,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 3.0,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    AppString.cancel,
                                    style: TextStyle(
                                      fontSize: SizeUtils.fSize_16(),
                                      fontWeight: FontWeight.w600,
                                      color:
                                          AppColor.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: SizeUtils.horizontalBlockSize * 5,
                            ),
                            Expanded(
                              child: Container(
                                height: SizeUtils.horizontalBlockSize * 12,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColor.primaryColor,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 3.0,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    AppString.save,
                                    style: TextStyle(
                                      fontSize: SizeUtils.fSize_16(),
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
            ],
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  Widget Box() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.primaryColor10,
        borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.horizontalBlockSize * 5,
          vertical: SizeUtils.verticalBlockSize * 1.5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppString.sendWelcomeMessage,
                  style: TextStyle(
                    fontSize: SizeUtils.fSize_14(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Obx(
                  () => Transform.scale(
                    scale: 1.2,
                    child: Switch(
                      onChanged: (value) {
                        _welcomeController.isWelcomeMessage.value =
                            !_welcomeController.isWelcomeMessage.value;
                      },
                      value: _welcomeController.isWelcomeMessage.value,
                      activeColor: AppColor.primaryColor,
                      activeTrackColor: AppColor.green38,
                      inactiveThumbColor: AppColor.whiteColor,
                      inactiveTrackColor: AppColor.textColor.withOpacity(0.2),
                    ),
                  ),
                )
              ],
            ),
            Text(
              AppString.sendAWelcome,
              style: TextStyle(
                fontSize: SizeUtils.fSize_14(),
                fontWeight: FontWeight.w400,
                color: AppColor.iconColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
