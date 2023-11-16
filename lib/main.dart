import 'package:crowd_afrik/views/pages/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'CrowdAfrik',
      home: SplashScreen(),
    );
  }
}

