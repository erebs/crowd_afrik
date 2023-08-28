import 'dart:convert';
import 'package:crowd_afrik/models/login_model.dart';
import 'package:crowd_afrik/views/pages/homescreen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../contants/app_variables.dart';
import '../utils/snackbar.dart';
import 'dart:io';

class LoginController extends GetxController {
  var isLoading = false.obs;
  LoginModel loginModel = LoginModel();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  callApi(String userMobileNumber,String password) async {
    try {
      isLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}login')!, body:
      {
        'phone_number': userMobileNumber,
        'password': password,
        'device_type': getPlatform(),
      });
      if (kDebugMode) {
        print(response.body+getPlatform());
      }if (response.statusCode == 200 || response.statusCode == 400) {
        loginModel = LoginModel.fromJson(jsonDecode(response.body));
        if(loginModel.statusCode=="01")
        {
         setUserData(userMobileNumber);
        }
        else
        {
          Snack.show(loginModel.message!);
        }

      } else {
        Snack.show("Something went wrong! - ECA01");
      }
    } catch (error) {
      Snack.show("$error - ECC01");
      debugPrint(error.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> setUserData(String userMobileNumber) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("user_id", loginModel.userId!);
    await prefs.setString("user_name", loginModel.fullName!);
    await prefs.setString("user_mobile", userMobileNumber);
    await prefs.setString("user_email", loginModel.emailId!);
    await prefs.setString("user_token", loginModel.token!);
    await prefs.setBool("is_logged_in", true);

    Get.off(
        HomeScreen(
        userId: loginModel.userId!,
        userName: loginModel.fullName!,
        userMobile: userMobileNumber,
        userEmail: loginModel.emailId!));
  }

  String getPlatform() {
    String platform = "Known";
    bool isAndroid = Platform.isAndroid;
    bool isIOS = Platform.isIOS;
    if(isAndroid)
      {platform = "Android";}
    else if(isIOS)
      {platform = "iOS";}
    return platform;
  }


}