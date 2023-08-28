import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationFragment extends StatelessWidget {
  const NotificationFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text("Notifications", style: const TextStyle(fontSize: 14),),
      ),
      backgroundColor: AppColors.secondary,
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Text("Notification")
            ],
          ),
        ),
        ),
    );
  }
}
