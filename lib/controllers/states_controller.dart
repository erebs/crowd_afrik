import 'dart:convert';
import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/contants/app_variables.dart';
import 'package:crowd_afrik/controllers/set_country_controller.dart';
import 'package:crowd_afrik/models/countries_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/states_model.dart';

class StateController extends GetxController {
  var isLoading = false.obs;
  States? states;
  var stateList = <StateModel>[].obs; // The observable list of countries
  var filteredStates = <StateModel>[].obs; // The observable list of filtered countries

  @override
  Future<void> onInit() async {
    final SetCountyController setCountyController = Get.put(SetCountyController());
    super.onInit();
    fetchData(setCountyController.countryId.value);
  }

  fetchData(String conId) async {
    String msg ="";
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          '${AppVariables.apiUrl}get-states/$conId')!);
      if (response.statusCode == 200) {
        ///data successfully
        List<dynamic> jsonData  = jsonDecode(response.body)['states'];
        stateList.value = jsonData.map((item) => StateModel.fromJson(item)).toList();
        filteredStates.value = stateList;

      } else {
        Get.snackbar(
          "Error1",
          "Something went wrong!",
          colorText: AppColors.fontOnSecondary,
          backgroundColor: AppColors.secondary,
        );

      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        colorText: AppColors.fontOnSecondary,
        backgroundColor: AppColors.secondary,
      );
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Filter countries based on a search query
  void searchStates(String query) {
    if (query.isEmpty) {
      filteredStates.value = stateList;
    } else {
      // Use the 'where' method to filter countries based on the search query
      filteredStates.value = stateList
          .where((states) => states.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

}