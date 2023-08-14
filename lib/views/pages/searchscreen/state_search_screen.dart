import 'package:crowd_afrik/controllers/set_set_controller.dart';
import 'package:crowd_afrik/controllers/states_controller.dart';
import 'package:crowd_afrik/models/states_model.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../../../contants/app_colors.dart';
import '../../../controllers/countries_controller.dart';
import '../../../controllers/set_country_controller.dart';
import '../../../models/countries_model.dart';
import '../../widgets/inputs.dart';
import '../../widgets/shimmers/search_shimmer.dart';


class StateSearchScreen extends StatefulWidget {
  const StateSearchScreen({super.key});


  @override
  State<StateSearchScreen> createState() => _StateSearchScreen();
}


class _StateSearchScreen extends State<StateSearchScreen> {

  final SetStateController setStateController = Get.put(SetStateController());
  StateController stateController = Get.put(StateController());
  TextEditingController searchController = TextEditingController();



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
                        onChanged: (value) => stateController.searchStates(value),
                        hint: "Search here...",
                        type: TextInputType.text),
                  ),

                ],
              ),
            ),

            Expanded(
                child: Obx(
                    () => stateController.isLoading.value?SearchShimmer()
                        : ListView.builder(
                      itemCount: stateController.filteredStates?.length ?? 0,
                        itemBuilder: (context, i)
                        {
                          StateModel state = stateController.filteredStates[i];
                          return TouchableOpacity(
                          onTap: (){
                            setStateController.updateData(state.name, state.id.toString());
                            Get.back();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                  bottom: BorderSide(width: 1, color: Colors.black.withOpacity(
                                      stateController.filteredStates!.length==(i+1)?0.08:0.0)),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                              child:
                            Text("${state.name}"??"",
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

