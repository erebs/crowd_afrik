import 'dart:convert';
import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/contants/app_variables.dart';
import 'package:crowd_afrik/models/countries_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CountryController extends GetxController {
  var isLoading = false.obs;
  CountryModel? countryModel;
  var countryList = <Country>[].obs; // The observable list of countries
  var filteredCountries = <Country>[].obs; // The observable list of filtered countries

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    String msg ="";
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          '${AppVariables.apiUrl}get-countries')!);
      if (response.statusCode == 200) {
        ///data successfully
        List<dynamic> jsonData  = jsonDecode(response.body)['countries'];
        countryList.value = jsonData.map((item) => Country.fromJson(item)).toList();
        filteredCountries.value = countryList;

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
  void searchCountries(String query) {
    if (query.isEmpty) {
      filteredCountries.value = countryList;
    } else {
      // Use the 'where' method to filter countries based on the search query
      filteredCountries.value = countryList
          .where((country) => country.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

}