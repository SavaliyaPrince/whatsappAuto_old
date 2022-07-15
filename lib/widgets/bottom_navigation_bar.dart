import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_auto/Utils/assets_path.dart';
import 'package:whatsapp_auto/Utils/size_utils.dart';
import 'package:whatsapp_auto/modules/homePageCantroller.dart';
import 'package:whatsapp_auto/modules/homepage/home_page.dart';
import 'package:whatsapp_auto/modules/messages.dart';
import 'package:whatsapp_auto/theme/app_color.dart';

class Bottom extends StatefulWidget {
  static const routeName = '/BottomNavigationBar_screen';

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  HomePageController homePageController = Get.find();

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePageScreen(),
    Meassages(),
    Meassagess(),
    Meassagess(),
    Meassagess(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index != 2) {
        _selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 0
                  ? AssetsPath.homeBottomNavigationBarItem1
                  : AssetsPath.homeBottomNavigationBarItem,
              width: SizeUtils.horizontalBlockSize * 8,
              color:
                  _selectedIndex == 0 ? AppColor.textColor : AppColor.iconColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 1
                  ? AssetsPath.messageBottomNavigationBarItem1
                  : AssetsPath.messageBottomNavigationBarItem,
              width: SizeUtils.horizontalBlockSize * 8,
              color:
                  _selectedIndex == 1 ? AppColor.textColor : AppColor.iconColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.splashScreenBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  AssetsPath.upBottomNavigationBarItem,
                  width: SizeUtils.horizontalBlockSize * 14,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 3
                  ? AssetsPath.userBottomNavigationBarItem1
                  : AssetsPath.userBottomNavigationBarItem,
              width: SizeUtils.horizontalBlockSize * 8,
              color:
                  _selectedIndex == 3 ? AppColor.textColor : AppColor.iconColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 4
                  ? AssetsPath.settingBottomNavigationBarItem1
                  : AssetsPath.settingBottomNavigationBarItem,
              width: SizeUtils.horizontalBlockSize * 8,
              color:
                  _selectedIndex == 4 ? AppColor.textColor : AppColor.iconColor,
            ),
            label: '',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        fixedColor: Colors.transparent,
      ),
    );
  }
}
