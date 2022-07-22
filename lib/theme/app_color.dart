import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {
  static const appBarColors = Color(0Xff2C2C2C);
  static const primaryColor = Color(0xff2BB895);
  static const green38 = Color.fromRGBO(43, 184, 149, 0.38);
  static const appBackgroundColor = Color(0xffF5F5F5);
  static const whiteColor = Color(0xffFFFFFF);
  static const textColor = Color(0xff3B4744);
  static const iconColor = Color(0xff838383);
  static const Color primaryColor10 = Color.fromRGBO(43, 184, 149, 0.1);
  static const backIconColor = Color(0xff2C2C2C);
  static const darkThem = Color(0xff3B4744);
  static const lightThem = Color(0xffFFFFFF);
  static const homeScreen = Color(0xffE9E9E9);
}

class ColorRes {
  static Color backgroundColor(BuildContext context) =>
      context.theme.backgroundColor;
  // static Color? appBarBackground(BuildContext context) =>
  //     context.theme.appBarTheme.backgroundColor;
  static Color appBarBackground(BuildContext context) =>
      context.theme.hoverColor;

  static Color textColor(BuildContext context) => context.theme.shadowColor;

  static Color itemColor(BuildContext context) =>
      context.theme.secondaryHeaderColor;
//
// static Color BottomBarUnselectedIconColor(BuildContext context) =>
//     context.theme.unselectedWidgetColor;
//
// static Color BottomBarSelectedIconColor(BuildContext context) =>
//     context.theme.bottomAppBarColor;
//
// static Color titleDateColor(BuildContext context) =>
//     context.theme.indicatorColor;
//
// static Color tabPageSelectorColor(BuildContext context) =>
//     context.theme.hintColor;
//
// static Color articleTitleColor(BuildContext context) =>
//     context.theme.hoverColor;
//
// static Color articlePhotoOnLoadColor(BuildContext context) =>
//     context.theme.canvasColor;
//
// static Color shadowColor(BuildContext context) => context.theme.focusColor;
//
// static Color itemTimeColorWithoutCommentColor(BuildContext context) =>
//     context.theme.cardColor;
//
// static Color itemTimeColorWithCommentColor(BuildContext context) =>
//     context.theme.toggleableActiveColor;
//
// static Color newItemAddColor(BuildContext context) =>
//     context.theme.selectedRowColor;
//
// static Color atTimeOfNewItemAddContainerColor(BuildContext context) =>
//     context.theme.highlightColor;
//
// static Color commentTextColorColor(BuildContext context) =>
//     context.theme.disabledColor;
//
// static Color detailScreenTwoContainerColor(BuildContext context) =>
//     context.theme.dividerColor;
//
// static Color updateScreenPhotoOnLoadColor(BuildContext context) =>
//     context.theme.splashColor;
//
// static Color updateScreenBackContainerColor(BuildContext context) =>
//     context.theme.errorColor;
}

class Themes {
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: ColorCollection.backGroundColorDark,
    // primaryColor: ColorCollection.mainTextColorDark,
    shadowColor: ColorCollection.dartTextColor,
    hoverColor: ColorCollection.darkAppBarColor,

    secondaryHeaderColor: ColorCollection.backGroundColorDark,
    // unselectedWidgetColor: ColorCollection.BottomBarUnselectedIconColorDark,
    // bottomAppBarColor: ColorCollection.BottomBarSelectedIconColorDark,
    // indicatorColor: ColorCollection.titleDateColorDark,
    // hintColor: ColorCollection.tabPageSelectorColorDark,
    // canvasColor: ColorCollection.articlePhotoOnLoadColorDark,
    // focusColor: ColorCollection.shadowColorDark,
    // cardColor: ColorCollection.itemTimeColorWithoutCommentDark,
    // toggleableActiveColor: ColorCollection.itemTimeColorWithCommentDark,
    // selectedRowColor: ColorCollection.newItemAddColorDark,
    // highlightColor: ColorCollection.atTimeOfNewItemAddContainerColorDark,
    // disabledColor: ColorCollection.commentTextColorDark,
    // dividerColor: ColorCollection.detailScreenTwoContainerColorDark,
    // splashColor: ColorCollection.updateScreenPhotoOnLoadColorDark,
    // errorColor: ColorCollection.updateScreenBackContainerColorDark,
  );
  static final light = ThemeData.light().copyWith(
    backgroundColor: ColorCollection.backGroundColorLight,
    // primaryColor: ColorCollection.mainTextColorLight,
    hoverColor: ColorCollection.lightAppBarColor,

    shadowColor: ColorCollection.lightTextColor,
    secondaryHeaderColor: ColorCollection.backGroundColorLight,
    // unselectedWidgetColor: ColorCollection.BottomBarUnselectedIconColorLight,
    // bottomAppBarColor: ColorCollection.BottomBarSelectedIconColorLight,
    // indicatorColor: ColorCollection.titleDateColorLight,
    // hintColor: ColorCollection.tabPageSelectorColorLight,
    // hoverColor: ColorCollection.articleTitleColorLight,
    // canvasColor: ColorCollection.articlePhotoOnLoadColorLight,
    // focusColor: ColorCollection.shadowColorLight,
    // cardColor: ColorCollection.itemTimeColorWithoutCommentLight,
    // toggleableActiveColor: ColorCollection.itemTimeColorWithCommentLight,
    // selectedRowColor: ColorCollection.newItemAddColorLight,
    // highlightColor: ColorCollection.atTimeOfNewItemAddContainerColorLight,
    // disabledColor: ColorCollection.commentTextColorLight,
    // dividerColor: ColorCollection.detailScreenTwoContainerColorLight,
    // splashColor: ColorCollection.updateScreenPhotoOnLoadColorLight,
    // errorColor: ColorCollection.updateScreenBackContainerColorLight,
  );
}

class ColorCollection {
  ///dark theme color
  static const Color backGroundColorDark = Color(0xff3B4744);
  static const Color dartTextColor = Color(0xffFFFFFF);
  static const Color darkAppBarColor = Color(0xffF5F5F5);

  // static const Color mainTextColorDark = Color(0xFFdad6d6);
  // static const Color itemBackGroundColorDark = Color(0xff241F1C);
  // static const Color bottomBarContainerColorDark = Color(0xffa09d9d);
  // static const Color BottomBarUnselectedIconColorDark = Color(0xff8C8C8C);
  // static const Color BottomBarSelectedIconColorDark = Color(0xff241F1C);
  // static const Color titleDateColorDark = Color(0xffFFFFFF);
  // static const Color tabPageSelectorColorDark = Color(0xffcfcccc);
  // static const Color articleTitleColorDark = Color(0xffFFFFFF);
  // static const Color articlePhotoOnLoadColorDark = Color(0xff0F0E0F);
  // static const Color shadowColorDark = Colors.transparent;
  // static const Color itemTimeColorWithoutCommentDark = Color(0xffc0baba);
  // static const Color itemTimeColorWithCommentDark = Color(0xffc0baba);
  // static const Color newItemAddColorDark = Colors.white30;
  // static const Color atTimeOfNewItemAddContainerColorDark = Color(0xff241F1C);
  // static const Color commentTextColorDark = Color(0xffdad6d6);
  // static const Color detailScreenTwoContainerColorDark = Color(0xff343637);
  // static const Color updateScreenPhotoOnLoadColorDark = Color(0xff241F1C);
  // static const Color updateScreenBackContainerColorDark = Color(0xff0F0E0F);

  ///light theme color
  static const Color backGroundColorLight = Color(0xffFFFFFF);
  static const Color lightTextColor = Color(0xff3B4744);
  static const Color lightAppBarColor = Color(0Xff2C2C2C);

// static const Color mainTextColorLight = Color(0xff2596be);
// static const Color itemBackGroundColorLight = Color(0xffFFFFFF);
// static const Color bottomBarContainerColorLight = Color(0xffd2e4fc);
// static const Color BottomBarUnselectedIconColorLight = Color(0xff759caf);
// static const Color BottomBarSelectedIconColorLight = Color(0xff2596be);
// static const Color titleDateColorLight = Color(0xff0F0E0F);
// static const Color tabPageSelectorColorLight = Color(0xff2596be);
// static const Color articleTitleColorLight = Color(0xff2596be);
// static const Color articlePhotoOnLoadColorLight = Color(0xffFFFFFF);
// static const Color shadowColorLight = Color(0xffBDBDBD);
// static const Color itemTimeColorWithoutCommentLight = Color(0xff495464);
// static const Color itemTimeColorWithCommentLight = Color(0xff2596be);
// static const Color newItemAddColorLight = Color(0xffdaf5ff);
// static const Color atTimeOfNewItemAddContainerColorLight = Color(0xffdaf5ff);
// static const Color commentTextColorLight = Color(0xff495464);
// static const Color detailScreenTwoContainerColorLight = Color(0xffd2e4fc);
// static const Color updateScreenPhotoOnLoadColorLight = Color(0xffF2F7FF);
// static const Color updateScreenBackContainerColorLight = Color(0xffFFFFFF);
  static const greenColor = Color(0xff2BB895);
  static const homePageThem = Color(0xffE9E9E9);
}
