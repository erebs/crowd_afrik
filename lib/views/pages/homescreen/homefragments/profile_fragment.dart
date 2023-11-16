import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/views/pages/homescreen/homefragments/profilefragments/account_fragment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contants/app_variables.dart';
import '../../../widgets/buttons.dart';
import '../../webscreen/sec_screen.dart';
import 'home_fragment.dart';
import 'notification_fragment.dart';

class ProfileFragment extends StatefulWidget {
  ProfileFragment({
    super.key,
    required this.userName,
    required this.userId,
    required this.userMobile,
    required this.userEmail,
  });

  String userName, userMobile, userEmail;
  String userId;

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {

  RxInt index = RxInt(0);
  int selectedIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title:  Text("Profile", style: TextStyle(fontSize: 14),),
      ),
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration:   BoxDecoration(
              border: Border.all(width: 0, color: Colors.white),
              color: Colors.white,
          ),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [

              Obx(() => Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    TabButton(
                      isSelected: index.value==0?true:false, text: 'Account',
                      onTap: () {
                        index.value = 0;
                        onItemTapped(0);
                      },),
                    TabButton(
                      isSelected: index.value==1?true:false, text: 'Funding',
                      onTap: () {
                        index.value = 1;
                        onItemTapped(1);
                      },),
                    TabButton(
                      isSelected: index.value==2?true:false, text: 'Repayment',
                      onTap: () {
                        index.value = 2;
                        onItemTapped(2);
                      },),

                  ],
                ),
              )),


              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (indexVal) {
                    setState(() => selectedIndex = indexVal);
                    index.value = indexVal;
                  },
                  children: <Widget>[

                    AccountFragment(userName:widget.userName, userMobile: widget.userMobile, userEmail: widget.userEmail, userId: widget.userId,),
                    SecScreen(url: "${AppVariables.memberUrl}funding-campaigns/${widget.userId}"),
                    SecScreen(url: "${AppVariables.memberUrl}repayment-campaigns/${widget.userId}"),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOutCubic);
    });
  }

}

