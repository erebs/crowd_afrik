import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/contants/app_variables.dart';
import 'package:crowd_afrik/controllers/delete_controller.dart';
import 'package:crowd_afrik/views/pages/loginscreen/login_screen.dart';
import 'package:crowd_afrik/views/pages/rechargescreen/recharge_screen.dart';
import 'package:crowd_afrik/views/pages/sendscreen/send_screen.dart';
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
  AccountFragment({
    super.key,
    required this.userId,
    required this.userName,
    required this.userMobile,
    required this.userEmail,
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
        decoration: BoxDecoration(
          border: Border.all(width: 0, color: Colors.white),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 23),
              creditBalance(),
              /* Container(
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
              ), */

              const SizedBox(
                height: 50,
              ),
              AccountMenuButton(
                text: 'Personal Details',
                icon: Remix.user_3_line,
                onTap: () {
                  Get.to(() => WebScreen(
                      url: "${AppVariables.memberUrl}personaldetails/$userId"));
                },
              ),
              AccountMenuButton(
                text: 'Bank Details',
                icon: Remix.bank_line,
                onTap: () {
                  Get.to(() => WebScreen(
                      url: "${AppVariables.memberUrl}bankdetail/$userId"));
                },
              ),
              AccountMenuButton(
                text: 'Guarantors',
                icon: Remix.group_line,
                onTap: () {
                  Get.to(() => WebScreen(
                      url: "${AppVariables.memberUrl}nominees/$userId"));
                },
              ),
              AccountMenuButton(
                text: 'Delete account',
                icon: Remix.delete_bin_2_line,
                onTap: () {
                  deleteUser(context);
                },
              ),
              AccountMenuButton(
                text: 'Referral your Friends',
                icon: Remix.gift_line,
                onTap: () {},
                suffixIcon: const Icon(
                  Remix.share_line,
                  size: 18,
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Text('Share your code yyywiwdjjjksf',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(width: 3),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Remix.file_copy_line,
                        size: 16,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: Text(
                  "Dashboard",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.fontOnWhite.withOpacity(0.4),
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              AccountMenuButton(
                text: 'About Us',
                icon: Remix.information_line,
                onTap: () {
                  Get.to(() => WebScreen(
                      url: "${AppVariables.memberUrl}aboutus/$userId"));
                },
              ),
              AccountMenuButton(
                text: 'Contact Us',
                icon: Remix.headphone_line,
                onTap: () {
                  Get.to(() => WebScreen(
                      url: "${AppVariables.memberUrl}contact/$userId"));
                },
              ),
              AccountMenuButton(
                text: 'Terms & Conditions',
                icon: Remix.book_2_line,
                onTap: () {
                  Get.to(() =>
                      WebScreen(url: "${AppVariables.memberUrl}terms/$userId"));
                },
              ),
              AccountMenuButton(
                text: 'Privacy Policy',
                icon: Remix.eye_line,
                onTap: () {
                  Get.to(() => WebScreen(
                      url: "${AppVariables.memberUrl}privacy_policy/$userId"));
                },
              ),
              AccountMenuButton(
                text: 'FAQ',
                icon: Remix.question_line,
                onTap: () {
                  Get.to(() =>
                      WebScreen(url: "${AppVariables.memberUrl}faq/$userId"));
                },
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              AppColors.logoutButtonColor.withOpacity(.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 11, horizontal: 130)),
                      onPressed: () {},
                      child: const Text("Logout",
                          style: TextStyle(
                              color: AppColors.fontOnSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w400))),
                ),
              )
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

  void deleteUser(BuildContext context) {
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
        builder: (BuildContext context) {
          return SafeArea(
            child: Center(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    color: AppColors.inputBackgroundColor,
                    border: Border.all(width: 0, color: AppColors.primary),
                    borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.all(50),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Remix.error_warning_line,
                      color: AppColors.primary,
                      size: 30,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                        "Deleting your account will permanently erase all your data and access. This action cannot be undone. Are you absolutely sure you want to proceed?",
                        style: TextStyle(
                            color: AppColors.fontOnWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TabButton(
                          isSelected: true,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          text: 'No',
                        ),

                        Obx(
                          () => deleteController.isLoading.value
                              ? TabButtonDelete(
                                  onTap: () {},
                                )
                              : TabButton(
                                  onTap: () {
                                    deleteController.callApi();
                                  },
                                  text: 'Yes',
                                ),
                        )

                        //
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget creditBalance() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            height: 130,
            width: double.infinity,
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.only(left: 39, top: 25, bottom: 23),
            decoration: const BoxDecoration(
                color: AppColors.creditBalanceBg,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(9), topRight: Radius.circular(9))),
            alignment: Alignment.center,
            child: const Row(children: [
              CircleAvatar(
                backgroundColor: AppColors.fontOnSecondary,
                radius: 32,
                child: Icon(Remix.wallet_fill, size: 36, color: Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Credits balance",
                    style: TextStyle(
                        color: AppColors.creditBalanceFontColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "50.0",
                    style: TextStyle(
                        color: AppColors.creditBalanceFontColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w500),
                  )
                ],
              )
            ]),
          ),
        ),
        Positioned(
          bottom: -44,
          left: 25,
          right: 25,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                creditButton(
                    label: 'Send',
                    onTap: () {
                      Get.to(() => const SendScreen());
                    }),
                creditButton(label: 'History', onTap: () {}),
                creditButton(
                    label: 'Recharge',
                    onTap: () {
                      Get.to(() => const RechargeScreen());
                    }),
              ]),
        ),
      ],
    );
  }

  Widget creditButton({required VoidCallback onTap, required String label}) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        decoration: const BoxDecoration(
            color: AppColors.creditBalanceButtonColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5))),
        child: Text(
          label,
          style: const TextStyle(
              color: AppColors.fontOnSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500),
        ),
      ),
    ); /* TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
          backgroundColor: AppColors.creditBalanceButtonColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5))),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6)),
      child: Text(
        label,
        style: const TextStyle(
            color: AppColors.fontOnSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w500),
      ),
    ); */
  }
}

class AccountMenuButton extends StatelessWidget {
  AccountMenuButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.onTap,
      this.child,
      this.suffixIcon});

  final String text;
  IconData icon;
  VoidCallback onTap;
  final Icon? suffixIcon;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0, color: Colors.grey.withOpacity(0.2)),
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50)),
                    width: 40,
                    height: 40,
                    child: Icon(
                      icon,
                      size: 20,
                    )),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text,
                        style: const TextStyle(
                            color: AppColors.fontOnWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    child ?? const SizedBox(),
                  ],
                )
              ],
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: AppColors.primary),
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(50)),
                width: 40,
                height: 25,
                child: suffixIcon ??
                    const Icon(
                      Remix.arrow_right_s_line,
                      size: 20,
                      color: Colors.white,
                    )),
          ],
        ),
      ),
    );
  }
}
