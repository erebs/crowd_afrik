import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text("Profile", style: TextStyle(fontSize: 14),),
      ),
      backgroundColor: AppColors.secondary,
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Text("Profile")
            ],
          ),
        ),
      ),
    );
  }
}

