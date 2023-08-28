import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../contants/app_colors.dart';

class BottomNavIcon extends StatelessWidget {
  BottomNavIcon({
    super.key,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  });

  VoidCallback onTap;
  bool isSelected;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap:onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration:   BoxDecoration(
            color: isSelected?AppColors.primary:AppColors.inputBackgroundColor,
            border: Border.all(width: 0, color: isSelected?AppColors.primary:AppColors.inputBackgroundColor),
            borderRadius: BorderRadius.circular(50)
        ),
        padding: EdgeInsets.all(5),
        child: Icon(icon, size: 20, color: isSelected?AppColors.inputBackgroundColor:Colors.grey,),

      ),
    );
  }
}
