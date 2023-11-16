import 'package:crowd_afrik/controllers/change_controller.dart';
import 'package:crowd_afrik/controllers/otp_controller.dart';
import 'package:crowd_afrik/controllers/reg_controller.dart';
import 'package:crowd_afrik/views/pages/loginscreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:crowd_afrik/controllers/set_country_controller.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:get/get.dart';
import '../../../contants/app_colors.dart';
import '../../../contants/app_images.dart';
import '../../../controllers/set_set_controller.dart';
import '../../../utils/snackbar.dart';
import '../../widgets/buttons.dart';
import '../../widgets/inputs.dart';
import '../searchscreen/con_search_screen.dart';
import '../searchscreen/search_screen.dart';
import '../searchscreen/state_search_screen.dart';

class ResetScreen extends StatefulWidget {
  ResetScreen({
    super.key,
    required this.phone,

  });

  String phone;

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {

  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool isPassword = true;
  bool iscPassword = true;
  RxString otpVal = RxString("");
  ChangeController changeController = Get.put(ChangeController());
  OtpController otpOgController = Get.put(OtpController());

  @override
  void initState(){
    super.initState();
    otpOgController.callApi(otpVal, widget.phone);

  }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
      ),
      backgroundColor: AppColors.fontOnSecondary,
      body: SafeArea(
          child: Stack(
            children: [
              Container(
                color: AppColors.secondary,
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [

                      SizedBox(
                          width: 200,
                          child: Image.asset(AppImages.longLogo)
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:10, bottom: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reset your\npassword",
                              style: TextStyle(
                                  color: AppColors.fontOnSecondary,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              "We have sent the\nverification code",
                              style: TextStyle(
                                  color: AppColors.fontOnSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),
                            )

                          ],
                        ),
                      ),

                    ],
                  )
              ),

              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container (
                    decoration:  const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    padding: const EdgeInsets.all(30),
                    width: double.infinity,
                    child: Wrap(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Reset Password",
                              style: TextStyle(
                                  color: AppColors.fontOnWhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            const SizedBox(height: 25),

                            EditableBox(
                                controller: otpController,
                                hint: "Enter your OTP",
                                type: TextInputType.number,
                            ),

                            const SizedBox(height: 10),

                            Align(
                              alignment: Alignment.topRight,
                              child:

                                  Obx(() => otpOgController.isLoading.value?

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(0),
                                      margin: EdgeInsets.only(right: 5),
                                      width:15,
                                      height:15,
                                      child: CircularProgressIndicator(
                                        color: AppColors.secondary, strokeWidth: 2,
                                      )),

                                   Text("Please wait...",
                                      style: TextStyle(
                                          color:Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13
                                      )),

                                ],
                              ):TouchableOpacity(
                                      onTap: (){
                            otpOgController.callApi(otpVal, widget.phone);
                            },
                              child: const Text("Resend OTP",
                                  style: TextStyle(
                                      color:AppColors.fontOnWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13
                                  )),
                            )
                                  )
                            ),

                            const SizedBox(height: 20),

                            EditableBoxPass(
                                controller: passwordController,
                                isPassword: isPassword,
                                hint: "Enter your password",
                                onPressed: () {
                                  setState(() {isPassword = !isPassword;},);
                                },
                                type: TextInputType.visiblePassword),

                            const SizedBox(height: 20),

                            EditableBoxPass(
                                controller: cPasswordController,
                                isPassword: iscPassword,
                                hint: "Confirm your password",
                                onPressed: () {
                                  setState(() {iscPassword = !iscPassword;},);
                                },
                                type: TextInputType.visiblePassword),


                            const SizedBox(height: 35),

                            PrimaryButton(
                              buttonText: 'Reset',
                              onTap: () {

                                if(otpVal.value == otpController.text)
                                  {
                                    if(passwordController.text == cPasswordController.text && passwordController.text.length>5)
                                      {
                                        changeController.callApi(cPasswordController.text, widget.phone);

                                      }else
                                        {
                                          Snack.show("Password is empty or not matching!");
                                        }
                                  }else
                                    {
                                      Snack.show("Invalid OTP!");
                                    }

                              },

                            ),

                            const SizedBox(height: 8),

                          ],
                        )],
                    ),
                  )
              )
            ],

          )),
    );
  }

}
