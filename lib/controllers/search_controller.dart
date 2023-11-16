import 'dart:convert';
import 'package:crowd_afrik/models/search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../contants/app_variables.dart';
import '../utils/snackbar.dart';
import 'dart:io';

class SearchOgController extends GetxController {
  var isLoading = false.obs;
  SearchModel searchModel = SearchModel();
  List<Categories>? categories;
  List<Campaigns>? campaigns;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  callApi(String item) async {
    try {
      isLoading(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String?   userToken    = prefs.getString("user_token");
      var headers = {
        'Authorization': 'Bearer Bearer $userToken'
      };
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}search-items')!,headers: headers, body: {
        "item":item,
      });
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200 || response.statusCode == 400) {
        searchModel = SearchModel.fromJson(jsonDecode(response.body));
        if(searchModel.statusCode=="01")
        {
          categories = searchModel.categories;
          campaigns = searchModel.campaigns;
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



}