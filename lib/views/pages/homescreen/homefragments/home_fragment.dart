import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/contants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../contants/app_variables.dart';
class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [

              Container(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                height:100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                        Image.asset(AppImages.logo),

                    TouchableOpacity(
                      onTap: (){},
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

                    Text(
                      "There are 19 ongoing campaigns.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.fontOnSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                      ),
                    ),

                    SizedBox(height: 10),

                    TouchableOpacity(
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
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),



                  ],
                ),
              ),

              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
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


              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration:   BoxDecoration(
                    border: Border.all(width: 0, color: Colors.grey.withOpacity(0.8)),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Colors.grey.withOpacity(0.6),
                          height: 150,
                          width: double.infinity,
                          child:
                          // image.isNotEmpty?Image.network(
                          //     fit: BoxFit.cover,
                          //     "${AppVariables.baseUrl}uploads/frauds/$image"):
                          Icon(Remix.image_2_line, size: 50, color: Colors.white.withOpacity(0.5),)
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Agriculture",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: AppColors.fontOnWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    SizedBox(height: 4),
                    

                    Text(
                      "Funding for agricultural projects, including small-scale farming, agribusiness, ",
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: TextStyle(
                          color: AppColors.fontOnWhite.withOpacity(0.4),
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                      ),
                    ),



                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
