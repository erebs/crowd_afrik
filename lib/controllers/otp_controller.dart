import 'dart:convert';
import 'package:crowd_afrik/models/check_model.dart';
import 'package:crowd_afrik/models/login_model.dart';
import 'package:crowd_afrik/models/otp_model.dart';
import 'package:crowd_afrik/models/reg_model.dart';
import 'package:crowd_afrik/views/pages/homescreen/home_screen.dart';
import 'package:crowd_afrik/views/pages/loginscreen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../contants/app_variables.dart';
import '../utils/snackbar.dart';
import 'dart:io';

import '../views/pages/passwordscreen/password_screen.dart';

class OtpController extends GetxController {
  var isLoading = false.obs;
  OtpModel otpModel = OtpModel();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  callApi(RxString OTP, String phone) async {
    try {
      isLoading(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}get-otp')!, body:
      {
        'phone_number':phone,
      });
      if (kDebugMode) {
        print(response.body+phone);
      }if (response.statusCode == 200 || response.statusCode == 400) {
        otpModel = OtpModel.fromJson(jsonDecode(response.body));
        if(otpModel.statusCode=="01")
        {

          OTP.value = otpModel.otp.toString();

        }
        else
        {
          Snack.show(otpModel.message!);
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