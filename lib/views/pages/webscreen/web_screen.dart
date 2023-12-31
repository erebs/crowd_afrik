import 'dart:async';

import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/views/pages/homescreen/home_screen.dart';
import 'package:crowd_afrik/views/widgets/shimmers/blur_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_webview_pro/platform_interface.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';
import '../../../contants/app_variables.dart';
import '../../widgets/shimmers/search_shimmer.dart';
import '../loginscreen/login_screen.dart';
import '../splashscreen/splash_screen.dart';

class WebScreen extends StatefulWidget {
  WebScreen({
    super.key,
    required this.url,
  });

  String url;

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  RxString titleJS = RxString('...');
  bool isInstamojo = false;
  RxBool isLoading = RxBool(true);
  RxInt index = RxInt(1);

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  void initState() {
    super.initState();


//
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
//             getHtmlPageTitle();
//             // // hideScrollBars();
//             // setMobileAndSendOtp();
//             FocusManager.instance.primaryFocus?.unfocus();
//
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('''
// Page resource error:
//   code: ${error.errorCode}
//   description: ${error.description}
//   errorType: ${error.errorType}
//           ''');
//           },
//           onNavigationRequest: (NavigationRequest request) async {
//
//             final SharedPreferences prefs = await SharedPreferences.getInstance();
//             String userName    = prefs.getString("user_name")!;
//             String userMobile  = prefs.getString("user_mobile")!;
//             String userEmail   = prefs.getString("user_email")!;
//
//             if (request.url.contains("/member/home/")) {
//               Get.offAll(HomeScreen(userName: userName, userMobile: userMobile, userEmail: userEmail));
//               debugPrint('blocking navigation to ${request.url}');
//               return NavigationDecision.prevent;
//
//             }
//               return NavigationDecision.navigate;
//
//           },
//
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



  }

  late final Future<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Obx(() => Text(titleJS.value, style: const TextStyle(fontSize: 14)),),
      ),
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        bottom: false,
        child:
        Stack(
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
            _getTitle(context),
          },
          navigationDelegate: (NavigationRequest request) async {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            String userName    = prefs.getString("user_name")!;
            String userMobile  = prefs.getString("user_mobile")!;
            String userEmail   = prefs.getString("user_email")!;

            if (request.url.contains("/member/home/")) {
              Get.offAll(HomeScreen(userName: userName, userMobile: userMobile, userEmail: userEmail));
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;

            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
          geolocationEnabled: false,//support geolocation or not
        ),
            Obx( ()=> isLoading.value?const BlurLoader():SizedBox()),
          ],
        )
      ),
    );
  }

  // Future<WebViewController> setTitleByUser(
  //     WebViewController controller, BuildContext context) async {
  //   final String title =
  //   await _controller.runJavascriptReturningResult('window.document.title');
  //   titleJS = title;
  // }

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

  JavascriptChannel _getTitle(BuildContext context) {
    return JavascriptChannel(
        name: 'JavaScriptTitle',
        onMessageReceived: (JavascriptMessage message) async {
          titleJS.value = message.message;
        });
  }


}
