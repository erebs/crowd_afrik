import 'package:crowd_afrik/views/pages/categoryscreen/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../contants/app_colors.dart';
import '../../contants/app_variables.dart';
import '../../utils/helpers.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
    super.key,
    required this.categoryId,
    required this.image,
    required this.title,
    required this.content,

  });
  int categoryId;
  String title, content, image;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        Get.to(() => CategoryScreen(
            categoryId: categoryId,
            title: title,
            photo: image,
            description: content));
      },
      child: Container(
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
                  child: image.length>2?Image.network(AppVariables.baseUrl+image, fit: BoxFit.cover,):
                  Icon(Remix.image_2_line, size: 50, color: Colors.white.withOpacity(0.5),)
              ),
            ),

            SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.fontOnWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 4),


            Text(
              Helpers.parseHtmlString(Helpers.truncateString(content, 47)),
              textAlign: TextAlign.justify,
              maxLines: 1,
              style: TextStyle(
                  color: AppColors.fontOnWhite.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),
            ),





          ],
        ),
      ),
    );
  }
}
