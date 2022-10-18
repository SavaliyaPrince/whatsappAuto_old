import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/chat_page/data_source/chat_modal.dart';
import 'package:whatsapp_auto/modules/chat_test_reply_page/chat_test_controller.dart';
import 'package:whatsapp_auto/modules/create_reply_page/create_reply_controller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';
import 'package:whatsapp_auto/widgets/app_textfield.dart';

class ChatTestReplyPage extends StatefulWidget {
  ChatTestReplyPage({Key? key}) : super(key: key);

  @override
  State<ChatTestReplyPage> createState() => _ChatTestReplyPageState();
}

class _ChatTestReplyPageState extends State<ChatTestReplyPage> {
  final ThemeController themeController = Get.find();

  TextEditingController chatController = TextEditingController();

  final ScrollController scrollController = ScrollController();
  final CreateReplyController _createReplyController = Get.find();
  final ChatTestController chatTestController = Get.put(ChatTestController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: themeController.isSwitched.value ? ColorCollection.backGroundColorDark : AppColor.homeScreen,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: themeController.isSwitched.value ? AppColor.darkThem.withOpacity(0.2) : AppColor.whiteColor,
          leadingWidth: SizeUtils.horizontalBlockSize * 11.5,
          leading: GestureDetector(
            onTap: () {
              Navigation.pop();
            },
            child: Padding(
              padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 3),
              child: Image.asset(
                AppIcons.backIcon,
                color: ColorRes.appBarBackground(context),
              ),
            ),
          ),
          title: Row(
            children: [
              AppText(
                AppString.whatsAuto,
                fontSize: SizeUtils.fSize_17(),
                fontWeight: FontWeight.w600,
                color: ColorRes.textColor(context),
              ),
              SizedBox(width: SizeUtils.horizontalBlockSize * 1),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  AppIcons.verify,
                  width: SizeUtils.fSize_16(),
                  // color: AppColor.backIconColor,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 4),
              child: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  AppIcons.more,
                  width: SizeUtils.fSize_24(),
                  color: ColorRes.appBarBackground(context),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            SizedBox(
              height: SizeUtils.verticalBlockSize * 78.5,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.horizontalBlockSize * 3,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: SizeUtils.verticalBlockSize * 3),
                      Center(
                        child: Container(
                          // alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorRes.textColor(context),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1, horizontal: SizeUtils.horizontalBlockSize * 3),
                            child: AppText(
                              "Today",
                              fontWeight: FontWeight.w600,
                              fontSize: SizeUtils.fSize_14(),
                              color: themeController.isSwitched.value ? AppColor.textColor : AppColor.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeUtils.verticalBlockSize * 1.5),
                      SizedBox(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: SizeUtils.verticalBlockSize * 0,
                              ),
                              child: Container(
                                color: Colors.red,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: chatTestController.chatModal.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    // final current = _homeController.currentMatch
                                    //     .value.matches?.notstarted?[index];
                                    // final backTime = index == 0
                                    //     ? chatTestController.chatModal[index].time
                                    //     : chatTestController
                                    //         .chatModal[index].time?[(index - 1)];

                                    return chatTestController.chatModal[index].istype == "Left"
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Container(
                                                  // alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: ColorRes.textColor(context),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: SizeUtils.verticalBlockSize * 1, horizontal: SizeUtils.horizontalBlockSize * 3),
                                                    child: AppText(
                                                      // "${chatTestController.chatModal[index].time ?? DateTime.now()}",
                                                      DateFormat("yyyy-MM-dd").format(chatTestController.chatModal[index].time ?? DateTime.now()),
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: SizeUtils.fSize_14(),
                                                      color: themeController.isSwitched.value ? AppColor.textColor : AppColor.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8), color: AppColor.primaryColor.withOpacity(0.2)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: SizeUtils.verticalBlockSize * 1,
                                                    horizontal: SizeUtils.horizontalBlockSize * 3,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      AppText(
                                                        "${chatTestController.chatModal[index].message}",
                                                        fontSize: SizeUtils.fSize_14(),
                                                        fontWeight: FontWeight.w400,
                                                        color: ColorRes.textColor(context),
                                                      ),
                                                      SizedBox(height: SizeUtils.verticalBlockSize * 1),
                                                      AppText(
                                                        DateFormat("hh:mm a").format(chatTestController.chatModal[index].time!),
                                                        textAlign: TextAlign.end,
                                                        fontSize: SizeUtils.fSize_12(),
                                                        fontWeight: FontWeight.w500,
                                                        color: ColorRes.textColor(context),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: SizeUtils.verticalBlockSize * 1.5),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: AppColor.primaryColor,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: SizeUtils.verticalBlockSize * 1,
                                                    horizontal: SizeUtils.horizontalBlockSize * 3,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      AppText(
                                                        "${chatTestController.chatModal[index].message}",
                                                        fontSize: SizeUtils.fSize_14(),
                                                        fontWeight: FontWeight.w400,
                                                        color: AppColor.whiteColor,
                                                      ),
                                                      SizedBox(height: SizeUtils.verticalBlockSize * 1),
                                                      AppText(
                                                        DateFormat("hh:mm a").format(chatTestController.chatModal[index].time!),
                                                        fontSize: SizeUtils.fSize_12(),
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColor.whiteColor.withOpacity(0.5),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: SizeUtils.verticalBlockSize * 2),
                                            ],
                                          );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Divider(
                    height: SizeUtils.verticalBlockSize * 0,
                    thickness: SizeUtils.fSize_1(),
                    color: ColorRes.textColor(context).withOpacity(0.2),
                  ),
                  Container(
                    height: SizeUtils.verticalBlockSize * 10,
                    color: themeController.isSwitched.value ? AppColor.darkThem.withOpacity(0.2) : AppColor.whiteColor,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     if (chatController.text.trim() == "") {
                          //       chatController.clear();
                          //       return;
                          //     }
                          //     final ChatModel _chatModelLeft = ChatModel();
                          //     _chatModelLeft.istype = "Left";
                          //     _chatModelLeft.message = chatController.text;
                          //     _chatModelLeft.time = DateTime.now();
                          //     chatModel.add(_chatModelLeft);
                          //     chatController.clear();
                          //
                          //     save();
                          //     scrollUp();
                          //     setState(() {});
                          //   },
                          //   child: CircleAvatar(
                          //     radius: SizeUtils.horizontalBlockSize * 7,
                          //     backgroundColor: AppColor.primaryColor,
                          //     child: Image.asset(AppIcons.send,
                          //         width: SizeUtils.horizontalBlockSize * 6),
                          //   ),
                          // ),
                          SizedBox(
                            width: SizeUtils.horizontalBlockSize * 75,
                            child: AppTextField(
                              controller: chatController,
                              contentPadding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 4),
                              hintText: "Good Morning",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 2),
                            child: GestureDetector(
                              onTap: () {
                                if (chatController.text == "") {
                                  chatController.clear();
                                  return;
                                }

                                final ChatModel chatModelLeft = ChatModel();
                                chatModelLeft.istype = "Right";
                                chatModelLeft.message = chatController.text;
                                chatModelLeft.time = DateTime.now();

                                chatTestController.chatModal.add(chatModelLeft);

                                final int index = _createReplyController.createModal.indexWhere((element) {
                                  return chatController.text == element.inComingKeyword;
                                });

                                final ChatModel chatModelLeft1 = ChatModel();
                                chatModelLeft1.istype = "Left";
                                chatModelLeft1.message = _createReplyController.createModal[index].replyMassage;
                                chatModelLeft1.time = DateTime.now();
                                chatTestController.chatModal.add(chatModelLeft1);
                                chatController.clear();

                                save();
                                scrollUp();
                              },
                              child: CircleAvatar(
                                radius: SizeUtils.horizontalBlockSize * 7,
                                backgroundColor: AppColor.primaryColor,
                                child: Image.asset(AppIcons.send, width: SizeUtils.horizontalBlockSize * 6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void save() {
    AppPreference.setString(
      "chatModal",
      json.encode(chatTestController.chatModal),
    );
    final Iterable l = json.decode(AppPreference.getString("chatModal"));
    final List<ChatModel> posts = List<ChatModel>.from(l.map((model) => ChatModel.fromJson(model)));

    chatTestController.chatModal.clear();
    chatTestController.chatModal.addAll(posts);
  }

  void scrollUp() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    print("aniation ------${scrollController.position.maxScrollExtent}");
    // setState(() {});
  }
}
