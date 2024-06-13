import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../controller/user_controller.dart';
import '../../../helper/notification_helper.dart';
import '../../../main.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;

  DashboardScreen({required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  List<Widget> _screens = [];
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();
    setState(() {});
    getUserProfile();
    // _pageIndex = widget.pageIndex;
    // _pageController = PageController(initialPage: widget.pageIndex);
    // _screens = [
    //   ProfileScreen(onButtonPressed: () => _setPage(1)), // update by thin
    //   LotteryMainPage(),
    //   ContactUsView(),
    // ];

    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    // Getting the token makes everything work as expected
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        Logger().i("onMessage=== : ${message.data}");
      }

      NotificationHelper.showNotification(
        message,
        flutterLocalNotificationsPlugin,
      );
    });
  }

  Future<void> getUserProfile() async {
    await Get.find<UserController>().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (_canExit) {
            return true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text('back_press_again_to_exit'.tr, style: robotoRegular),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            _canExit = true;
            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.red.shade900,
        key: _scaffoldKey,
        // bottomNavigationBar: ResponsiveHelper.isDesktop(context)
        //     ? SizedBox()
        //     : BottomAppBar(
        //         elevation: 5,
        //         notchMargin: 5,
        //         clipBehavior: Clip.antiAlias,
        //         shape: CircularNotchedRectangle(),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             image: DecorationImage(
        //               image: AssetImage(Images.bottomBg),
        //               fit: BoxFit.fill,
        //             ),
        //           ),
        //           child: Padding(
        //             padding:
        //                 EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //             child: Row(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   BottomNavItem(
        //                     iconDataUnClick: Images.profileBIUnClick,
        //                     iconDataClick: Images.profileBIClick,
        //                     isSelected: _pageIndex == 0,
        //                     onTap: () => _setPage(0),
        //                     title: 'profile',
        //                   ),
        //                   SizedBox(width: 20),
        //                   BottomNavItem(
        //                     iconDataUnClick: Images.mainBIUnClick,
        //                     iconDataClick: Images.mainBIClick,
        //                     isSelected: _pageIndex == 1,
        //                     onTap: () => _setPage(1),
        //                     title: 'menu',
        //                   ),
        //                   SizedBox(width: 20),
        //                   BottomNavItem(
        //                     iconDataUnClick: Images.contactUsBIUnClick,
        //                     iconDataClick: Images.contactUsBIClick,
        //                     isSelected: _pageIndex == 2,
        //                     onTap: () => _setPage(2),
        //                     title: 'contactUs',
        //                   ),
        //                 ]),
        //           ),
        //         ),
        //       ),
        body: SafeArea(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _screens.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _screens[index];
            },
          ),
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
