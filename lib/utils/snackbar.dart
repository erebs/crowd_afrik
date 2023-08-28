import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../contants/app_colors.dart';

class Snack{
   static void show(String message) {

    Get.rawSnackbar(
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(5),
      messageText:Text(message,
        style: TextStyle(
            fontWeight: FontWeight.bold,
                color: Colors.white,
        ),),
      borderColor: AppColors.secondary,
      borderRadius: 10,
      borderWidth: 0,
      backgroundColor: AppColors.secondary,

    );
  }

}