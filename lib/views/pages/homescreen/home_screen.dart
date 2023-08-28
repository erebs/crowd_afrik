import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/views/pages/homescreen/homefragments/home_fragment.dart';
import 'package:crowd_afrik/views/pages/homescreen/homefragments/notification_fragment.dart';
import 'package:crowd_afrik/views/pages/homescreen/homefragments/profile_fragment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:remixicon/remixicon.dart';

import '../../widgets/bottom_nav_icon.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userMobile,
    required this.userEmail,
  });

  String userName, userMobile, userEmail;
  int userId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver{
  PageController pageController = PageController();
  RxBool isLoading = RxBool(true);
  RxInt index = RxInt(1);
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
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
      backgroundColor: AppColors.secondary,
      body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [

                Expanded(
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (indexVal) {
                      setState(() => selectedIndex = indexVal);
                      index.value = indexVal;
                    },
                    children: <Widget>[

                      NotificationFragment(),
                      HomeFragment(),
                      ProfileFragment()

                    ],
                  ),
                ),

                Container(
                    decoration:   BoxDecoration(
                        color: AppColors.inputBackgroundColor,
                        border: Border.all(width: 0, color: AppColors.inputBackgroundColor),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                )
              ],
            ),
          ))
    );
  }


  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

}
