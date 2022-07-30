import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/navigation.dart';
import 'package:whatsapp_auto/Utils/navigation_utils/routes.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/create_reply_page/create_reply_controller.dart';
import 'package:whatsapp_auto/modules/theme_controller.dart';
import 'package:whatsapp_auto/theme/app_color.dart';
import 'package:whatsapp_auto/theme/app_string.dart';
import 'package:whatsapp_auto/widgets/app_text.dart';
import 'package:whatsapp_auto/widgets/button.dart';

class CreateReply extends StatefulWidget {
  CreateReply({Key? key}) : super(key: key);

  @override
  State<CreateReply> createState() => _CreateReplyState();
}

class _CreateReplyState extends State<CreateReply> {
  final ThemeController themeController = Get.find();

  final CreateReplyController _createReplyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorRes.backgroundColor(context),
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: themeController.isSwitched.value
              ? AppColor.darkThem.withOpacity(0.2)
              : AppColor.whiteColor,
          leadingWidth: SizeUtils.fSize_40(),
          leading: GestureDetector(
            onTap: () {
              Navigation.pushNamed(Routes.homePage);
            },
            child: Padding(
              padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 3),
              child: Image.asset(
                AppIcons.backIcon,
                color: ColorRes.appBarBackground(context),
              ),
            ),
          ),
          title: AppText(
            AppString.createReply,
            fontSize: SizeUtils.fSize_17(),
            fontWeight: FontWeight.w600,
            color: ColorRes.textColor(context),
          ),
          // actions: [
          //   Padding(
          //     padding:
          //         EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 4),
          //     child: GestureDetector(
          //       onTap: () {},
          //       child: Image.asset(
          //         AppIcons.more,
          //         width: SizeUtils.fSize_24(),
          //         color: ColorRes.appBarBackground(context),
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                if (_createReplyController.createModal.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _createReplyController.createModal.length,
                      padding: EdgeInsets.symmetric(
                          vertical: SizeUtils.verticalBlockSize * 2),
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
                                    _createReplyController.createModal
                                        .removeAt(index);
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
                              left: SizeUtils.horizontalBlockSize * 4,
                              right: SizeUtils.horizontalBlockSize * 4,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        AppColor.primaryColor.withOpacity(0.2),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: SizeUtils.verticalBlockSize * 1,
                                      horizontal:
                                          SizeUtils.horizontalBlockSize * 3,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        AppText(
                                          "${_createReplyController.createModal[index].inComingKeyword}",
                                          color: ColorRes.textColor(context),
                                          fontSize: SizeUtils.fSize_16(),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        SizedBox(
                                          height:
                                              SizeUtils.verticalBlockSize * 0.5,
                                        ),
                                        AppText(
                                          DateFormat("hh:mm a").format(
                                              _createReplyController
                                                      .createModal[index]
                                                      .time ??
                                                  DateTime.now()),
                                          textAlign: TextAlign.end,
                                          fontSize: SizeUtils.fSize_10(),
                                          fontWeight: FontWeight.w500,
                                          color: ColorRes.textColor(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeUtils.verticalBlockSize * 1,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColor.primaryColor
                                            .withOpacity(0.2)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeUtils.verticalBlockSize * 1,
                                          horizontal:
                                              SizeUtils.horizontalBlockSize *
                                                  3),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          AppText(
                                            "${_createReplyController.createModal[index].replyMassage}",
                                            color: ColorRes.textColor(context),
                                            fontSize: SizeUtils.fSize_16(),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeUtils.verticalBlockSize *
                                                    0.5,
                                          ),
                                          AppText(
                                            DateFormat("hh:mm a").format(
                                                _createReplyController
                                                        .createModal[index]
                                                        .time ??
                                                    DateTime.now()),
                                            textAlign: TextAlign.end,
                                            fontSize: SizeUtils.fSize_10(),
                                            fontWeight: FontWeight.w500,
                                            color: ColorRes.textColor(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: SizeUtils.verticalBlockSize * 1),
                                // Divider(
                                //   thickness: 0.2,
                                //   color: ColorRes.textColor(context),
                                // )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  Column(
                    children: [
                      SizedBox(height: SizeUtils.verticalBlockSize * 30),
                      Image.asset(
                        AssetsPath.edit,
                        // width: SizeUtils.horizontalBlockSize * 48,
                        color: AppColor.primaryColor,
                      ),
                      SizedBox(
                        height: SizeUtils.fSize_14(),
                      ),
                      AppText(
                        AppString.customReply,
                        fontSize: SizeUtils.fSize_18(),
                        fontWeight: FontWeight.w600,
                        color: ColorRes.textColor(context),
                      ),
                      SizedBox(
                        height: SizeUtils.fSize_10(),
                      ),
                      AppText(
                        AppString.tapToBelow,
                        textAlign: TextAlign.center,
                        fontSize: SizeUtils.fSize_14(),
                        fontWeight: FontWeight.w400,
                        color: ColorRes.textColor(context),
                      ),
                    ],
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeUtils.horizontalBlockSize * 5,
                left: SizeUtils.horizontalBlockSize * 4,
                right: SizeUtils.horizontalBlockSize * 4,
              ),
              child: createButton(
                onTap: () {
                  Navigation.pushNamed(Routes.createCustomReply);
                  _createReplyController.inComingKeywordController.clear();
                  _createReplyController.replyMassageController.clear();
                },
                text: AppString.create,
              ),
            )
          ],
        ),
      ),
    );
  }

  // InkWell(
  // onTap: () {
  // setState(() {
  // _createReplyController.createModal
  //     .removeAt(index);
  // });
  // },
  // child: Icon(
  // Icons.close,
  // color: ColorRes.textColor(context)
  //     .withOpacity(0.5),
  // ),
  // ),

}
