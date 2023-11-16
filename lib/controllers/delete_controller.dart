import 'dart:convert';
import 'package:crowd_afrik/models/check_model.dart';
import 'package:crowd_afrik/models/delete_model.dart';
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

import '../views/pages/loginscreen/login_screen.dart';
import '../views/pages/passwordscreen/password_screen.dart';

class DeleteController extends GetxController {
  var isLoading = false.obs;
  DeleteModel deleteModel = DeleteModel();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  callApi() async {
    try {
      isLoading(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String?   userToken    = prefs.getString("user_token");
      var headers = {
        'Authorization': 'Bearer Bearer $userToken'
      };
      http.Response response = await http.get(Uri.tryParse(
          '${AppVariables.apiUrl}delete-account')!,headers: headers);
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200 || response.statusCode == 400) {

        deleteModel = DeleteModel.fromJson(jsonDecode(response.body));
        if(deleteModel.statusCode=="01")
        {
          Snack.show(deleteModel.message!);
          clearUserData();
        }
        else
        {
          Snack.show("Something went wrong!");
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


  Future<void> clearUserData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("user_id", 0);
    await prefs.setString("user_name", "");
    await prefs.setString("user_mobile", "");
    await prefs.setString("user_email", "");
    await prefs.setString("user_token", "");
    await prefs.setBool("is_logged_in", false);

    Get.offAll(() => const LoginScreen());

  }


}