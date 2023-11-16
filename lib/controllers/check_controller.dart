import 'dart:convert';
import 'package:crowd_afrik/models/check_model.dart';
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

import '../views/pages/passwordscreen/password_screen.dart';

class CheckController extends GetxController {
  var isLoading = false.obs;
  CheckModel checkModel = CheckModel();
  Result result = Result();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  callApi(String mobile,String name,String email, String countryId, String countryCode, String stateId) async {
    try {
      isLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}check')!, body:
      {
      'phone_number':countryCode+mobile,
      'email_id':email,
      });
      if (kDebugMode) {
        print(response.body+getPlatform());
      }if (response.statusCode == 200 || response.statusCode == 400) {
        checkModel = CheckModel.fromJson(jsonDecode(response.body));
        if(checkModel.statusCode=="01")
        {

          Snack.show(checkModel.message!);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("reg_user_name", name);
          await prefs.setString("reg_user_mobile", countryCode+mobile);
          await prefs.setString("reg_user_email", email);
          await prefs.setString("reg_country_id", countryId);
          await prefs.setString("reg_state_id", stateId);

          Get.to(() => PasswordScreen(name: name, phone: countryCode+mobile, email: email,
            stateId: stateId, conId: countryId, otp: checkModel.otp.toString(),));

        }
        else
        {
          Snack.show(checkModel.message!);
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