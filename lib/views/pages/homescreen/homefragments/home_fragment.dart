import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/contants/app_images.dart';
import 'package:crowd_afrik/controllers/category_controller.dart';
import 'package:crowd_afrik/views/pages/categoryscreen/category_screen.dart';
import 'package:crowd_afrik/views/pages/webscreen/sec_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../../../../contants/app_variables.dart';
import '../../../../models/category_model.dart';
import '../../../widgets/category_card.dart';
import '../../../widgets/shimmers/category_card_shimmer.dart';
import '../../searchscreen/searchog_screen.dart';
class HomeFragment extends StatelessWidget {
   HomeFragment({super.key});

  final CategoryController categoryController = Get.put(CategoryController());
   RxInt activeCampaignsVal = RxInt(19);


  @override
  Widget build(BuildContext context) {

    categoryController.callApi(activeCampaignsVal);

    return Scaffold(
      backgroundColor: AppColors.fontOnSecondary,
      body: SafeArea(
        bottom: false,
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  height:90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                          Image.asset(AppImages.logo),

                      TouchableOpacity(
                        onTap: (){

                          Get.to(() => const SearchOgScreen());

                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration:   BoxDecoration(
                              border: Border.all(width: 1, color: AppColors.primary),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: const Icon(Remix.search_2_line, size: 20, color: AppColors.primary,),
                        ),
                      ),

                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(20),
                  height: 200,
                  width: double.infinity,
                  decoration:   BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.primary),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment(0.8, 1),
                        colors: <Color>[
                          AppColors.primary,
                          Color(0xffaa0000),
                        ],
                        tileMode: TileMode.clamp,
                      ),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(
                        "Sectors we fund",
                        style: TextStyle(
                            color: AppColors.fontOnSecondary,
                            fontSize: 23,
                            fontWeight: FontWeight.w500
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        "We fund diverse sectors, driving African economic growth and opportunity.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.fontOnSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                        ),
                      ),

                      SizedBox(height: 15),

                      Obx(() => Text(
                        "There are ${activeCampaignsVal.value} ongoing campaigns.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.fontOnSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                        ),
                      ),),

                      SizedBox(height: 10),

                      TouchableOpacity(
                        onTap: (){

                          showModalBottomSheet(
                              backgroundColor: Colors.black.withOpacity(0.7),
                              context: context,
                              enableDrag: false,
                              isScrollControlled: true,
                              isDismissible: false,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.0),
                                ),
                              ),
                              builder: (BuildContext context){
                                return SafeArea(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 50),
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                    child: Column(
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Text(
                                              "Choose your category",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColors.fontOnSecondary,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),

                                            TouchableOpacity(
                                              onTap: (){
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration:   BoxDecoration(
                                                    border: Border.all(width: 1, color: AppColors.primary),
                                                    color: AppColors.primary,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: const Icon(Remix.close_fill, size: 25, color: AppColors.fontOnSecondary,),
                                              ),
                                            ),

                                          ],
                                        ),

                                        SizedBox(height: 25,),

                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: categoryController.categoryModel.categories?.length ?? 0,
                                          itemBuilder: (context, i)
                                          {
                                            Categories categories = categoryController.categoryModel.categories![i];

                                            return TouchableOpacity(
                                              onTap: () {
                                                Navigator.pop(context);
                                               Get.to(() => CategoryScreen(
                                                   categoryId: categories.id!,
                                                   title: categories.title!,
                                                   photo: categories.photo!,
                                                   description: categories.description!));

                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.all(15),
                                                width: double.infinity,
                                                decoration:   BoxDecoration(
                                                    border: Border.all(width: 0, color: AppColors.primary),
                                                    color: AppColors.primary,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width:35,
                                                        child: Image.network(AppVariables.baseUrl+categories.icon!, color: Colors.white,)),
                                                    SizedBox(height: 3,),
                                                    Text(
                                                      categories.title!,
                                                      textAlign: TextAlign.center,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color: AppColors.fontOnSecondary,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: 15,
                                            mainAxisSpacing: 15,
                                            crossAxisCount: 3,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                          decoration:   BoxDecoration(
                              border: Border.all(width: 1, color: AppColors.inputBackgroundColor),
                              color: AppColors.inputBackgroundColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                            "Apply",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.secondary,
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),



                    ],
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                  child: Text(
                    "Categories",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.fontOnWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),


            Obx(
                    () => categoryController.isLoading.value?
                    Column(
                      children: [
                        CategoryCardShimmer(),
                        CategoryCardShimmer(),
                        CategoryCardShimmer(),
                        CategoryCardShimmer(),
                      ],
                    )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                    itemCount: categoryController.categoryModel.categories?.length ?? 0,
                    itemBuilder: (context, i)
                    {
                      Categories categories = categoryController.categoryModel.categories![i];
                      return CategoryCard(
                        categoryId: categories.id!,
                        image: categories.photo!,
                        title: categories.title!,
                        content: categories.description!,);
                    }
                )
            ),
                SizedBox(height: 20,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

