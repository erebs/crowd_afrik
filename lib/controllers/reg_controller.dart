import 'dart:convert';
import 'package:crowd_afrik/models/check_model.dart';
import 'package:crowd_afrik/models/login_model.dart';
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

class RegController extends GetxController {
  var isLoading = false.obs;
  RegModel regModel = RegModel();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  callApi(String password) async {
    try {
      isLoading(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}register')!, body:
      {
        'full_name':prefs.getString("reg_user_name"),
        'phone_number':prefs.getString("reg_user_mobile"),
        'email_id':prefs.getString("reg_user_email"),
        'password':password,
        'device_type':getPlatform(),
        'country':prefs.getString("reg_country_id"),
        'state':prefs.getString("reg_state_id"),
      });
      if (kDebugMode) {
        print(response.body+getPlatform());
      }if (response.statusCode == 200 || response.statusCode == 400) {
        regModel = RegModel.fromJson(jsonDecode(response.body));
        if(regModel.statusCode=="01")
        {

          Get.offAll(() => const LoginScreen());

        }
        else
        {
          Snack.show(regModel.message!);
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