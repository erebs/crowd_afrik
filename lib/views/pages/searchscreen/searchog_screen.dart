import 'package:crowd_afrik/contants/app_variables.dart';
import 'package:crowd_afrik/models/search_model.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../../../contants/app_colors.dart';
import '../../../controllers/search_controller.dart';
import '../../widgets/inputs.dart';
import '../../widgets/shimmers/search_shimmer.dart';
import '../categoryscreen/category_screen.dart';


class SearchOgScreen extends StatefulWidget {
  const SearchOgScreen({super.key});


  @override
  State<SearchOgScreen> createState() => _SearchOgScreenState();
}


class _SearchOgScreenState extends State<SearchOgScreen> {

  final SearchOgController searchOgController = Get.put(SearchOgController());
  TextEditingController searchItemController = TextEditingController();

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

    searchOgController.callApi("");

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
                        controller: searchItemController,
                        onChanged: (value) => searchOgController.callApi(value),
                        hint: "Search here...",
                        type: TextInputType.text),
                  ),

                ],
              ),
            ),

            Expanded(
                child: Obx(
                    () => searchOgController.isLoading.value?SearchShimmer()
                        : ListView.builder(
                      itemCount: searchOgController.categories?.length ?? 0,
                        itemBuilder: (context, i)
                        {
                          Categories  categories = searchOgController.categories![i];
                          return TouchableOpacity(
                          onTap: (){
                            Get.to(() => CategoryScreen(
                                categoryId: categories.id!,
                                title: categories.title!,
                                photo: categories.photo!,
                                description: categories.description!));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                  bottom: BorderSide(width: 1, color: Colors.black.withOpacity(
                                      searchOgController.categories!.length==(i+1)?0.08:0.0)),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                              child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:20,
                                    height: 20,
                                    child: Image.network(AppVariables.baseUrl+categories.icon!, color: Colors.black.withOpacity(0.6),)),
                                SizedBox(width: 10,),
                                Text(categories.title!,
                                  style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),)
                              ],
                            )
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

