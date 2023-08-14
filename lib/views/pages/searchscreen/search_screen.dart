import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../../../contants/app_colors.dart';
import '../../../controllers/countries_controller.dart';
import '../../../controllers/set_country_controller.dart';
import '../../../controllers/set_set_controller.dart';
import '../../../models/countries_model.dart';
import '../../widgets/inputs.dart';
import '../../widgets/shimmers/search_shimmer.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});


  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {

  final SetCountyController setCountyController = Get.put(SetCountyController());
  final SetStateController setStateController = Get.put(SetStateController());
  CountryController countryController = Get.put(CountryController());
  TextEditingController searchController = TextEditingController();

  Future<void> setConCode(String cCode, bool Refresh) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("ccode", cCode);
    await prefs.setBool("refresh", Refresh);
    Get.back();
  }


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.inputBackgroundColor,
    body: SafeArea(
      child: Container(
        height: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              color: AppColors.inputBackgroundColor,
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              child: Row (
                children: [
                  IconButton(
                      onPressed: () { Get.back(); },
                      icon: const Icon(Remix.close_line ,size: 30, color: AppColors.primary,)),
                  SizedBox( width: 5,),
                  Expanded(
                    child: SearchBox(
                        controller: searchController,
                        onChanged: (value) => countryController.searchCountries(value),
                        hint: "Search here...",
                        type: TextInputType.text),
                  ),

                ],
              ),
            ),

            Expanded(
                child: Obx(
                    () => countryController.isLoading.value?SearchShimmer()
                        : ListView.builder(
                      itemCount: countryController.filteredCountries?.length ?? 0,
                        itemBuilder: (context, i)
                        {
                          Country country = countryController.filteredCountries[i];
                          return TouchableOpacity(
                          onTap: (){
                            setCountyController.updateCode(
                              country.mobileCode.toString(),
                              country.name.toString(),
                              country.id.toString(),
                            );
                            setStateController.updateData("", "0",);
                            Get.back();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                  bottom: BorderSide(width: 1, color: Colors.black.withOpacity(
                                      countryController.filteredCountries!.length==(i+1)?0.08:0.0)),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                              child:
                            Text("( +${country.mobileCode} ) "
                                " - ${country.name}"??"",
                            style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),)
                            ),
                        );
                        }
                    )
                ))

          ],
        )
      ),
    )
);
  }


}

