import 'dart:async';

import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/views/pages/webscreen/web_screen.dart';
import 'package:crowd_afrik/views/widgets/shimmers/blur_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:flutter_webview_pro/platform_interface.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../contants/app_variables.dart';
import '../../widgets/shimmers/search_shimmer.dart';
import '../homescreen/home_screen.dart';
import '../loginscreen/login_screen.dart';

import '../splashscreen/splash_screen.dart';

class SecScreen extends StatefulWidget {
  SecScreen({
    super.key,
    required this.url,
  });

  String url;

  @override
  State<SecScreen> createState() => _SecScreenState();
}

class _SecScreenState extends State<SecScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  bool isInstamojo = false;
  RxBool isLoading = RxBool(true);
  RxInt index = RxInt(1);

  @override
  void initState() {
    super.initState();



//     final WebViewController controller =
//     WebViewController.fromPlatformCreationParams(params);
//     // #enddocregion platform_features
//
//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.white)
//       ..enableZoom(false)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             debugPrint('WebView is loading (progress : $progress%)');
//           },
//           onPageStarted: (String url) {
//             debugPrint('Page started loading: $url');
//             isLoading.value = true;
//           },
//           onPageFinished: (String url) {
//             isLoading.value = false;
//             if (url.contains('instamojo')) {
//               isInstamojo = true;
//             }
//             FocusManager.instance.primaryFocus?.unfocus();
//
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('''
// Page resource error:
//   code: ${error.errorCode}
//   description: ${error.description}
//   errorType: ${error.errorType}
//   isForMainFrame: ${error.isForMainFrame}
//           ''');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//
//             debugPrint('allowing navigation to ${request.url}');
//             if (request.url==widget.url) {
//               debugPrint('blocking navigation to ${request.url}');
//               return NavigationDecision.navigate;
//             }else
//               {
//                 Get.to(WebScreen(url: request.url));
//                 return NavigationDecision.prevent;
//               }
//
//           },
//           onUrlChange: (UrlChange change) {
//             debugPrint('url change to ${change.url}');
//           },
//         ),
//       )
//       ..addJavaScriptChannel(
//         'AppInterface',
//         onMessageReceived: (JavaScriptMessage message) {
//           // Snack.show("AppInterface", message.message);
//           if(message.message == "JSC_kill_n_goHome")
//           {Get.offAll(MainScreen());}
//
//           if(message.message == "JSC_kill_n_goLogin")
//           {Get.offAll(const LoginScreen());}
//
//           if(message.message == "JSC_kill_n_goSplash")
//           {Get.offAll(const SplashScreen());}
//
//           if(message.message == "JSC_kill_n_goBack")
//           {
//             //Snack.show("JSC_kill_n_goBack", "");
//             Get.back();}
//
//         },
//
//
//       )
//       ..loadRequest(Uri.parse(widget.url));
//
//
//     // #docregion platform_features
//     if (controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(true);
//       (controller.platform as AndroidWebViewController)
//           .setMediaPlaybackRequiresUserGesture(false);
//     }
//
//     _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fontOnSecondary,
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print("WebView is loading (progress : $progress%)");
              if(progress<100)
                isLoading.value = true;
              else
                isLoading.value = false;
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              String userName    = prefs.getString("user_name")!;
              String userMobile  = prefs.getString("user_mobile")!;
              String userEmail   = prefs.getString("user_email")!;

              if (request.url==widget.url) {
                debugPrint('blocking navigation to ${request.url}');
                return NavigationDecision.navigate;
              }else
              {
                Get.to(WebScreen(url: request.url));
                return NavigationDecision.prevent;
              }
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) async {
              print('Page finished loading: $url');

            },
            gestureNavigationEnabled: true,
            geolocationEnabled: false,//support geolocation or not
          ),
          Obx( ()=> isLoading.value? Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SearchShimmer(),
          ):SizedBox()),
        ],
      ),
    );
  }



  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'AppInterface',
        onMessageReceived: (JavascriptMessage message) async {

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          String userName    = prefs.getString("user_name")!;
          String userMobile  = prefs.getString("user_mobile")!;
          String userEmail   = prefs.getString("user_email")!;

          if(message.message == "JSC_kill_n_goHome")
          {Get.offAll(HomeScreen(userName: userName, userMobile: userMobile, userEmail: userEmail));}

          if(message.message == "JSC_kill_n_goLogin")
          {Get.offAll(const LoginScreen());}

          if(message.message == "JSC_kill_n_goSplash")
          {Get.offAll(const SplashScreen());}

          if(message.message == "JSC_kill_n_goBack")
          {
            //Snack.show("JSC_kill_n_goBack", "");
            Get.back();}

        });
  }


}
