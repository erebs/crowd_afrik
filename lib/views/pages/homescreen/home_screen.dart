import 'dart:io';
import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/contants/app_variables.dart';
import 'package:crowd_afrik/views/pages/homescreen/homefragments/home_fragment.dart';
import 'package:crowd_afrik/views/pages/homescreen/homefragments/notification_fragment.dart';
import 'package:crowd_afrik/views/pages/homescreen/homefragments/profile_fragment.dart';
import 'package:crowd_afrik/views/pages/webscreen/web_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/bottom_nav_icon.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
    required this.userName,
    required this.userMobile,
    required this.userEmail,
  });

  String userName, userMobile, userEmail;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver{
  PageController pageController = PageController();
  RxBool isLoading = RxBool(true);
  RxInt index = RxInt(1);
  int selectedIndex = 1;
  String? userName, userEmail, userMobile;
  String? userId;

  @override
  void initState() {
    super.initState();
    getUserData();
    pageController = PageController(initialPage: 1);
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      onItemTapped(selectedIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.white,
        child: Column(
          children: [

            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (indexVal) {
                  setState(() => selectedIndex = indexVal);
                  index.value = indexVal;
                },
                children: <Widget>[

                  // NotificationFragment(userId: '$userId',),
                  WebScreen(url: "${AppVariables.memberUrl}noti-ios/$userId"),
                  HomeFragment(),
                  ProfileFragment(userName: '$userName', userMobile: '$userMobile', userEmail: '$userEmail', userId: '$userId',)

                ],
              ),
            ),

            Container(
                decoration:   BoxDecoration(
                    color: AppColors.inputBackgroundColor,
                    border: Border.all(width: 0, color: AppColors.inputBackgroundColor),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                height: 60,
                child:
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    BottomNavIcon(
                      isSelected: index.value==0?true:false,
                      icon: Remix.notification_2_fill,
                      onTap: () {
                        index.value = 0;
                        onItemTapped(index.value);

                      },
                    ),

                    BottomNavIcon(
                      isSelected: index.value==1?true:false,
                      icon: Remix.home_2_fill,
                      onTap: () {
                        index.value = 1;
                        onItemTapped(index.value);
                      },
                    ),

                    BottomNavIcon(
                      isSelected: index.value==2?true:false,
                      icon: Remix.user_2_fill,
                      onTap: () {
                        index.value = 2;
                        onItemTapped(index.value);
                      },
                    ),

                  ],
                ))
            ),

            Container(
              height: Platform.isIOS?10:0,
              color: AppColors.inputBackgroundColor,
            )

          ],
        ),
      )
    );
  }


  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  Future<void> getUserData()
  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId    = prefs.getInt("user_id").toString()!;
    userName    = prefs.getString("user_name")!;
    userMobile  = prefs.getString("user_mobile");
    userEmail   = prefs.getString("user_email");
  }

}
