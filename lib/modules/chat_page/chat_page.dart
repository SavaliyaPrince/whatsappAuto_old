import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/helper/shared_preference.dart';
import 'package:whatsapp_auto/modules/chat_page/data_source/chat_modal.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';
import 'package:whatsapp_auto/widgets/app_textfield.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ThemeController themeController = Get.find();

  TextEditingController chatController = TextEditingController();
  final List<ChatModel> chatModel = <ChatModel>[];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    final Iterable l = json.decode(AppPreference.getString("chatModal"));
    final List<ChatModel> posts =
        List<ChatModel>.from(l.map((model) => ChatModel.fromJson(model)));

    chatModel.clear();
    chatModel.addAll(posts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: themeController.isSwitched.value
            ? ColorCollection.backGroundColorDark
            : AppColor.homeScreen,
        appBar: AppBar(
          elevation: 0.2,
          backgroundColor: AppColor.whiteColor,
          leadingWidth: SizeUtils.fSize_40(),
          leading: GestureDetector(
            onTap: () {
              Navigation.pop();
            },
            child: Padding(
              padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 3),
              child: Image.asset(
                AppIcons.backIcon,
                color: AppColor.backIconColor,
              ),
            ),
          ),
          title: Row(
            children: [
              AppText(
                AppString.whatsAuto,
                fontSize: SizeUtils.fSize_17(),
                fontWeight: FontWeight.w600,
                color: AppColor.textColor,
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
              padding:
                  EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 4),
              child: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  AppIcons.more,
                  width: SizeUtils.fSize_24(),
                  color: AppColor.backIconColor,
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
                              color: AppColor.whiteColor),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeUtils.verticalBlockSize * 1,
                                horizontal: SizeUtils.horizontalBlockSize * 3),
                            child: AppText(
                              "Today",
                              fontWeight: FontWeight.w600,
                              fontSize: SizeUtils.fSize_14(),
                              color: ColorRes.textColor(context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeUtils.verticalBlockSize * 1.5),
                      SizedBox(
                        child: ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount: chatModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            log("--------->>>>${chatModel[index].message}");
                            return chatModel[index].istype == "Left"
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColor.primaryColor
                                                .withOpacity(0.2)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical:
                                                SizeUtils.verticalBlockSize * 1,
                                            horizontal:
                                                SizeUtils.horizontalBlockSize *
                                                    3,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              AppText(
                                                "${chatModel[index].message}",
                                                fontSize: SizeUtils.fSize_14(),
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorRes.textColor(context),
                                              ),
                                              SizedBox(
                                                  height: SizeUtils
                                                          .verticalBlockSize *
                                                      1),
                                              AppText(
                                                DateFormat("hh:mm a").format(
                                                    chatModel[index].time!),
                                                textAlign: TextAlign.end,
                                                fontSize: SizeUtils.fSize_12(),
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    ColorRes.textColor(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: SizeUtils.verticalBlockSize *
                                              1.5),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColor.primaryColor,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical:
                                                SizeUtils.verticalBlockSize * 1,
                                            horizontal:
                                                SizeUtils.horizontalBlockSize *
                                                    3,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              AppText(
                                                "${chatModel[index].message}",
                                                fontSize: SizeUtils.fSize_14(),
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.whiteColor,
                                              ),
                                              SizedBox(
                                                  height: SizeUtils
                                                          .verticalBlockSize *
                                                      1),
                                              AppText(
                                                DateFormat("hh:mm a").format(
                                                    chatModel[index].time!),
                                                fontSize: SizeUtils.fSize_12(),
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.whiteColor
                                                    .withOpacity(0.5),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: SizeUtils.verticalBlockSize *
                                              1.5),
                                    ],
                                  );
                          },
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
                    color: AppColor.whiteColor,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (chatController.text.trim() == "") {
                              chatController.clear();
                              return;
                            }
                            final ChatModel _chatModelLeft = ChatModel();
                            _chatModelLeft.istype = "Left";
                            _chatModelLeft.message = chatController.text;
                            _chatModelLeft.time = DateTime.now();
                            chatModel.add(_chatModelLeft);
                            chatController.clear();
                            setState(() {
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: const Duration(microseconds: 0),
                                curve: Curves.fastOutSlowIn,
                              );
                            });

                            save();
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: SizeUtils.horizontalBlockSize * 7,
                            backgroundColor: AppColor.primaryColor,
                            child: Image.asset(AppIcons.send,
                                width: SizeUtils.horizontalBlockSize * 6),
                          ),
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 65,
                          child: AppTextField(
                            controller: chatController,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: SizeUtils.horizontalBlockSize * 4),
                            hintText: "Good Morning",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (chatController.text.trim() == "") {
                              chatController.clear();
                              return;
                            }

                            final ChatModel _chatModelLeft = ChatModel();
                            _chatModelLeft.istype = "Right";
                            _chatModelLeft.message = chatController.text;
                            _chatModelLeft.time = DateTime.now();

                            chatModel.add(_chatModelLeft);
                            chatController.clear();

                            setState(() {
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: const Duration(microseconds: 0),
                                curve: Curves.fastOutSlowIn,
                              );
                            });

                            save();
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: SizeUtils.horizontalBlockSize * 7,
                            backgroundColor: AppColor.primaryColor,
                            child: Image.asset(AppIcons.send,
                                width: SizeUtils.horizontalBlockSize * 6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void save() {
    AppPreference.setString("chatModal", json.encode(chatModel));
    final Iterable l = json.decode(AppPreference.getString("chatModal"));
    final List<ChatModel> posts =
        List<ChatModel>.from(l.map((model) => ChatModel.fromJson(model)));

    chatModel.clear();
    chatModel.addAll(posts);
  }
}
