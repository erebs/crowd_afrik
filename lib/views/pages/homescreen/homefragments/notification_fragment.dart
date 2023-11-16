import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../contants/app_variables.dart';
import '../../webscreen/sec_screen.dart';

class NotificationFragment extends StatelessWidget {

  NotificationFragment({
    super.key,
    required this.userId,
  });
  var userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text("Notifications", style: const TextStyle(fontSize: 14),),
      ),
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        bottom: false,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration:   BoxDecoration(
            border: Border.all(width: 0, color: Colors.white),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child:SizedBox()

          ),
          ),
      ),
    );
  }
}
