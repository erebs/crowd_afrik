import 'dart:convert';
import 'package:crowd_afrik/models/category_model.dart';
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

class CategoryController extends GetxController {
  var isLoading = false.obs;
  CategoryModel categoryModel = CategoryModel();
  List<Categories>? categories;
  int? activeCampaigns;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  callApi(RxInt activeCampaignsVal) async {
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
      if (response.statusCode == 200 || response.statusCode == 400) {
        categoryModel = CategoryModel.fromJson(jsonDecode(response.body));
        if(categoryModel.statusCode=="01")
        {
          categories = categoryModel.categories;
          activeCampaignsVal.value = categoryModel.activeCampaigns!;
        }
        else
        {
          Snack.show(categoryModel.message!);
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



}