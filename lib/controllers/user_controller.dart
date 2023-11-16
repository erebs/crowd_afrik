import 'dart:convert';
import 'package:crowd_afrik/models/category_model.dart';
import 'package:crowd_afrik/models/login_model.dart';
import 'package:crowd_afrik/models/user_model.dart';
import 'package:crowd_afrik/views/pages/homescreen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../contants/app_variables.dart';
import '../utils/snackbar.dart';
import 'dart:io';

class UserController extends GetxController {
  var isLoading = false.obs;
  UserModel userModel = UserModel();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  callApi() async {
    try {
      isLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String?   userToken    = prefs.getString("user_token");
      var headers = {
        'Authorization': 'Bearer Bearer $userToken'
      };
      http.Response response = await http.get(Uri.tryParse(
          '${AppVariables.apiUrl}campaign-categories')!,headers: headers);
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(jsonDecode(response.body));

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
    await prefs.setString("user_name", userModel.fullName!);
    await prefs.setString("user_mobile", userModel.phoneNumber!);
    await prefs.setString("user_email", userModel.emailId!);

  }



}