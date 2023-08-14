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
import '../../widgets/buttons.dart';
import '../../widgets/inputs.dart';
import '../searchscreen/con_search_screen.dart';
import '../searchscreen/search_screen.dart';
import '../searchscreen/state_search_screen.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  final SetCountyController setCountyController = Get.put(SetCountyController());
  final SetStateController setStateController = Get.put(SetStateController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
          child: Stack(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 80),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(
                          width: 200,
                          child: Image.asset(AppImages.longLogo)
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
                              "Sign Up",
                              style: TextStyle(
                                  color: AppColors.fontOnWhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            const SizedBox(height: 25),

                            EditableBox(
                                controller: nameController,
                                hint: "Enter your full name",
                                type: TextInputType.name,
                            ),

                            const SizedBox(height: 20),

                            Obx(() => EditableBoxMob(
                                controller: phoneController,
                                hint: "Enter your phone number",
                                prefix: "+${setCountyController.countryCode.value}",
                                type: TextInputType.phone,
                                onPressed: () {
                                  Get.to(const SearchScreen());
                                }
                            )),

                            const SizedBox(height: 20),

                            EditableBox(
                              controller: nameController,
                              hint: "Enter your email id",
                              type: TextInputType.name,
                            ),

                            const SizedBox(height: 20),

                            Row(
                              children: [
                                Expanded(
                                    child:
                                    Obx(() => DropBox(
                                      prefix: setCountyController.countryName.value,
                                      hint: "Country",
                                      onPressed: () {
                                        Get.to(const ConSearchScreen());
                                      }
                                    )),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child:
                                  Obx(() => DropBox(
                                    prefix: setStateController.stateName.value,
                                    hint: "State",
                                      onPressed: () {
                                        int.parse(setCountyController.countryId.value)>0?Get.to(const StateSearchScreen()):
                                        Get.snackbar(
                                          "",
                                          "Please choose your country to continue!",
                                          colorText: AppColors.fontOnSecondary,
                                          backgroundColor: AppColors.secondary,
                                        );
                                      }
                                  )),
                                ),
                              ],
                            ),

                            const SizedBox(height: 35),

                            PrimaryButton(
                              buttonText: 'Continue',
                                isContinue:true,
                              onTap: () {
                                Get.snackbar(
                                  "Ccode",
                                  setCountyController.countryCode.value,
                                  colorText: AppColors.fontOnSecondary,
                                  backgroundColor: AppColors.secondary,
                                );
                              },

                            ),

                            const SizedBox(height: 8),

                            Center(
                              child: TouchableOpacity(
                                onTap: () {
                                  Get.off(const LoginScreen());
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: "Already a member? "),
                                        TextSpan(
                                          text: 'Sign In',
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
