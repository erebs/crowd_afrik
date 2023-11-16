import 'package:crowd_afrik/controllers/set_country_controller.dart';
import 'package:crowd_afrik/views/pages/passwordscreen/password_screen.dart';
import 'package:crowd_afrik/views/pages/registrationscreen/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:get/get.dart';
import '../../../contants/app_colors.dart';
import '../../../contants/app_images.dart';
import '../../../controllers/login_controller.dart';
import '../../../utils/snackbar.dart';
import '../../widgets/buttons.dart';
import '../../widgets/inputs.dart';
import '../passwordscreen/reset_screen.dart';
import '../searchscreen/search_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver{
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   bool isPassword = true;
  final SetCountyController setCountyController = Get.put(SetCountyController());
  final LoginController loginController = Get.put(LoginController());


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {

    }
  }

  @override
  void initState(){
    super.initState();
    isPassword = true;
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
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(
                        width: 200,
                        child: Image.asset(AppImages.longLogo)
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:20),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome\nback to",
                            style: TextStyle(
                              color: AppColors.fontOnSecondary,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            "CrowdAfrik",
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
                        Text(
                          "Sign In",
                          style: TextStyle(
                              color: AppColors.fontOnWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        const SizedBox(height: 25),

                        Obx(() => EditableBoxMob(
                                controller: mobileController,
                                hint: "Enter your phone number",
                                prefix: "+${setCountyController.countryCode.value}",
                                type: TextInputType.phone,
                                onPressed: () {
                                  Get.to(const SearchScreen());
                                }
                        )),

                        const SizedBox(height: 20),

                        EditableBoxPass(
                            controller: passwordController,
                            isPassword: isPassword,
                            hint: "Enter your password",
                            onPressed: () {
                              setState(() {isPassword = !isPassword;},);
                            },
                            type: TextInputType.visiblePassword),

                        const SizedBox(height: 15),

                        Align(
                          alignment: Alignment.topRight,
                          child: TouchableOpacity(
                            onTap: (){
                              if(mobileController.text.isNotEmpty)
                                {
                                  if(setCountyController.countryCode.value!="00")
                                    {
                                      Get.to(()=> ResetScreen(phone: setCountyController.countryCode.value+mobileController.text,));
                                    }
                                  else
                                  {
                                    Snack.show("Please choose your country code!");
                                  }

                                }else
                                  {
                                    Snack.show("Please enter your mobile number!");
                                  }
                            },
                            child: const Text("Forgot Password?",
                                style: TextStyle(
                                    color:AppColors.fontOnWhite,
                                    fontWeight: FontWeight.bold,
                                  fontSize: 13
                                )),
                          ),
                        ),

                        const SizedBox(height: 25),

                        Obx(() => loginController.isLoading.value?const PrimaryButtonLoader():
                        PrimaryButton(
                          buttonText: 'Login',
                          onTap: () {
                            if(mobileController.text.length>5 && passwordController.text.length>2)
                              {
                                if(setCountyController.countryCode.value == "00")
                                  {
                                    Snack.show("Please choose your country code!");
                                  }else
                                    {
                                      loginController.callApi(
                                        setCountyController.countryCode.value+mobileController.text,
                                        passwordController.text,);
                                    }
                              }
                            else
                              {
                                Snack.show("Some required fields are empty!");
                              }
                          },
                        ),
                        ),

                        const SizedBox(height: 8),

                        Center(
                          child: TouchableOpacity(
                            onTap: () {
                              Get.off(const RegistrationScreen());
                              // Get.to(const PasswordScreen());
                        },
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Don't have an account yet? "),
                                    TextSpan(
                                      text: 'Sign Up',
                                      style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),

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




