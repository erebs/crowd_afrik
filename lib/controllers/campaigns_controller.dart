import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../contants/app_variables.dart';
import '../models/campaigns_model.dart';
import '../utils/snackbar.dart';
import 'dart:io';

class CampaignsController extends GetxController {
  var isLoading = false.obs;
  CampaignsModel campaignsModel = CampaignsModel();
  List<Campaigns>? campaigns;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  callApi(int categoryId) async {
    try {
      isLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String?   userToken    = prefs.getString("user_token");
      var headers = {
        'Authorization': 'Bearer Bearer $userToken'
      };
      http.Response response = await http.get(Uri.tryParse(
          '${AppVariables.apiUrl}campaigns/$categoryId')!,headers: headers);
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200 || response.statusCode == 400) {
        campaignsModel = CampaignsModel.fromJson(jsonDecode(response.body));
        if(campaignsModel.statusCode=="01")
        {
          campaigns = campaignsModel.campaigns;
        }
        else
        {
          Snack.show(campaignsModel.message!);
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