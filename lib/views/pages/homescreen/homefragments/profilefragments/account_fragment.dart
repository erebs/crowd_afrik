import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/contants/app_variables.dart';
import 'package:crowd_afrik/controllers/delete_controller.dart';
import 'package:crowd_afrik/views/pages/loginscreen/login_screen.dart';
import 'package:crowd_afrik/views/pages/webscreen/web_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../../contants/app_images.dart';
import '../../../../widgets/buttons.dart';

class AccountFragment extends StatelessWidget {
  AccountFragment({super.key,
    required  this.userId,
    required  this.userName,
    required  this.userMobile,
    required  this.userEmail,
  });

  String userName, userMobile, userEmail;
  String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:   BoxDecoration(
          border: Border.all(width: 0, color: Colors.white),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        SizedBox(
                            width:80,
                            height:80,
                            child: Image.asset(AppImages.profile)),

                        SizedBox(width: 15,),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userName, style: TextStyle(color: AppColors.fontOnWhite, fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(userMobile, style: TextStyle(color: AppColors.fontOnWhite.withOpacity(0.5), fontSize: 11, fontWeight: FontWeight.bold)),
                            Text(userEmail, style: TextStyle(color: AppColors.fontOnWhite.withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        )

                      ],
                    ),

                    TouchableOpacity(
                      onTap: () {
                        clearUserData();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("Logout", style: TextStyle(color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                    ),


                  ],
                ),
              ),

              SizedBox(height: 10,),

              AccountMenuButton(text: 'Personal Details', icon: Remix.user_3_line,
                onTap: () { Get.to(()=> WebScreen(url: "${AppVariables.memberUrl}personaldetails/$userId")); },),
              AccountMenuButton(text: 'Bank Details', icon: Remix.bank_line,
                onTap: () { Get.to(()=> WebScreen(url: "${AppVariables.memberUrl}bankdetail/$userId")); },),
              AccountMenuButton(text: 'Guarantors', icon: Remix.group_line,
                onTap: () { Get.to(()=> WebScreen(url: "${AppVariables.memberUrl}nominees/$userId")); },),

              AccountMenuButton(text: 'Delete account', icon: Remix.delete_bin_2_line,
                onTap: () { deleteUser(context); },),

              SizedBox(height: 5,),

              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: Text(
                  "Dashboard",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.fontOnWhite.withOpacity(0.4),
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),

              AccountMenuButton(text: 'About Us', icon: Remix.information_line,
                onTap: () { Get.to(()=> WebScreen(url: "${AppVariables.memberUrl}aboutus/$userId")); },),
              AccountMenuButton(text: 'Contact Us', icon: Remix.headphone_line,
                onTap: () { Get.to(()=> WebScreen(url: "${AppVariables.memberUrl}contact/$userId")); },),
              AccountMenuButton(text: 'Terms & Conditions', icon: Remix.book_2_line,
                onTap: () { Get.to(()=> WebScreen(url: "${AppVariables.memberUrl}terms/$userId")); },),
              AccountMenuButton(text: 'Privacy Policy', icon: Remix.eye_line,
                onTap: () { Get.to(()=> WebScreen(url: "${AppVariables.memberUrl}privacy_policy/$userId")); },),
              AccountMenuButton(text: 'FAQ', icon: Remix.question_line,
                onTap: () { Get.to(()=> WebScreen(url: "${AppVariables.memberUrl}faq/$userId")); },),


            ],
          ),
        ),
        ),
    );
  }

  Future<void> clearUserData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("user_id", 0);
    await prefs.setString("user_name", "");
    await prefs.setString("user_mobile", "");
    await prefs.setString("user_email", "");
    await prefs.setString("user_token", "");
    await prefs.setBool("is_logged_in", false);

    Get.offAll(() => const LoginScreen());

  }

  void deleteUser(BuildContext context)
  {

    final DeleteController deleteController = Get.put(DeleteController());

    showModalBottomSheet(
        backgroundColor: Colors.black.withOpacity(0.3),
        context: context,
        enableDrag: false,
        isScrollControlled: true,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        builder: (BuildContext context){
          return SafeArea(
            child: Center(
              child: Container(
                height: 200,
                decoration:   BoxDecoration(
                    color: AppColors.inputBackgroundColor,
                    border: Border.all(width: 0, color: AppColors.primary),
                    borderRadius: BorderRadius.circular(15)
                ),
                margin: EdgeInsets.all(50),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Icon(Remix.error_warning_line, color: AppColors.primary, size: 30,),

                    SizedBox(height: 5,),

                    Text("Deleting your account will permanently erase all your data and access. This action cannot be undone. Are you absolutely sure you want to proceed?", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.w600)),

                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TabButton(isSelected:true, onTap: () {
                          Navigator.pop(context);
                        }, text: 'No',),

                        Obx(() => deleteController.isLoading.value?
                        TabButtonDelete(onTap: () {  },):
                        TabButton(onTap: () { deleteController.callApi(); }, text: 'Yes',),)

                        //


                      ],
                    )

                  ],
                ),
              ),
            ),
          );
        }
    );
  }

}

class AccountMenuButton extends StatelessWidget {
  AccountMenuButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final String text;
  IconData icon;
  VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal:30),
        child:   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Container(
                    decoration:   BoxDecoration(
                        border: Border.all(width: 0, color: Colors.grey.withOpacity(0.2)),
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50)
                    ),
                    width:40,
                    height:40,
                    child: Icon(icon, size: 20,)),

                SizedBox(width: 15,),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text, style: TextStyle(color: AppColors.fontOnWhite, fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                )

              ],
            ),

            Container(
                decoration:   BoxDecoration(
                    border: Border.all(width: 0, color: AppColors.primary),
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(50)
                ),
                width:40,
                height:25,
                child: Icon(Remix.arrow_right_s_line, size: 20, color: Colors.white,)),


          ],
        ),
      ),
    );
  }






}
