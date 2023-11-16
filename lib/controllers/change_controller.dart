import 'dart:convert';
import 'package:crowd_afrik/models/change_model.dart';
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

class ChangeController extends GetxController {
  var isLoading = false.obs;
  ChangeModel changeModel = ChangeModel();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  callApi(String password, String phone) async {
    try {
      isLoading(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}reset-password')!, body:
      {
        'phone_number':phone,
        'password':password,
      });
      if (kDebugMode) {
        print(response.body+phone);
      }if (response.statusCode == 200 || response.statusCode == 400) {
        changeModel = ChangeModel.fromJson(jsonDecode(response.body));
        if(changeModel.statusCode=="01")
        {

         Get.offAll(() => const LoginScreen());

        }
        else
        {
          Snack.show(changeModel.message!);
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