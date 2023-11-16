import 'package:crowd_afrik/views/pages/homescreen/home_screen.dart';
import 'package:crowd_afrik/views/pages/loginscreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../contants/app_colors.dart';
import '../../../contants/app_images.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screenNavigation();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
          child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Center(
                  child: SizedBox(
                      child: Image.asset(AppImages.longLogo)
                  )
              )
          )
      ),
    );
  }

  screenNavigation () async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = (prefs.getBool('is_logged_in') == null || prefs.getBool('is_logged_in') == false ? false : true);

    String?   userName    = prefs.getString("user_name");
    int?      userId      = prefs.getInt("user_id");
    String?   userMobile  = prefs.getString("user_mobile");
    String?   userEmail   = prefs.getString("user_email");

    Future.delayed(const Duration (seconds: 3),(){
      Get.off(()=>isLoggedIn ? HomeScreen(
        userName: userName!,
        userMobile: userMobile!,
        userEmail: userEmail!,
      ) :  const LoginScreen(),
          transition: Transition.native,
          duration: const Duration(microseconds: 1200));
    });

  }


}
