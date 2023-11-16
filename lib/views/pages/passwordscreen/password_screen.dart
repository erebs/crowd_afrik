import 'package:crowd_afrik/controllers/check_controller.dart';
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
class PasswordScreen extends StatefulWidget {
  PasswordScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.stateId,
    required this.conId,
    required this.otp,

  });

  String name, phone, email, stateId, conId, otp;

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {

  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool isPassword = true;
  bool iscPassword = true;
  RxString otpVal = RxString("");
  RegController regController = Get.put(RegController());
  CheckController checkController = Get.put(CheckController());


  @override
  Widget build(BuildContext context) {

    otpVal.value = widget.otp;

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
                              "Verify your\nphone",
                              style: TextStyle(
                                  color: AppColors.fontOnSecondary,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              "We have send the\nverification code",
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
                              "Verify Phone",
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
                              child: TouchableOpacity(
                                onTap: (){
                                  // otpOgController.callApi(otpVal);
                                },
                                child: const Text("Resent OTP",
                                    style: TextStyle(
                                        color:AppColors.fontOnWhite,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13
                                    )),
                              ),
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
                              buttonText: 'Sign Up',
                              onTap: () {

                                if(otpVal.value == otpController.text)
                                  {
                                    if(passwordController.text == cPasswordController.text && passwordController.text.length>5)
                                      {

                                        regController.callApi(cPasswordController.text);

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
