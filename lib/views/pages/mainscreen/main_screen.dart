import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/contants/app_variables.dart';
import 'package:crowd_afrik/views/pages/sreachscreen/sreach_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import '../../widgets/bottom_nav_icon.dart';
import '../../widgets/shimmers/blur_loader.dart';
import '../../widgets/shimmers/search_shimmer.dart';
import '../loginscreen/login_screen.dart';
import '../splashscreen/splash_screen.dart';
import '../webscreen/web_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}



class _MainScreenState extends State<MainScreen> {
   late final WebViewController _controller;
  String titleJS = '...';
  bool isInstamojo = false;
  RxBool isLoading = RxBool(true);
  RxInt index = RxInt(1);

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            isLoading.value = true;
          },
          onPageFinished: (String url) {
            isLoading.value = false;
            if (url.contains('instamojo')) {
              isInstamojo = true;
            }
            // getHtmlPageTitle();
            // // hideScrollBars();
            // setMobileAndSendOtp();
            FocusManager.instance.primaryFocus?.unfocus();

          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('Main navigation to ${request.url}');
            if (request.url.contains("/notifications") || request.url.contains("/home") || request.url.contains("/profile")) {
              return NavigationDecision.navigate;
            }else
              {
                debugPrint('Main blocking navigation to ${request.url}');
                 if(request.url.contains("search"))
                   {
                     Get.to(() => SreachScreen(url: request.url));
                   }else
                     {
                       Get.to(() => WebScreen(url: request.url));
                     }
                return NavigationDecision.prevent;
              }


          },
          onUrlChange: (UrlChange change) {
            debugPrint('Main url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'AppInterface',
        onMessageReceived: (JavaScriptMessage message) {
          // Snack.show("AppInterface", message.message);
          if(message.message == "JSC_kill_n_goHome")
          {Get.offAll(MainScreen());}

          if(message.message == "JSC_kill_n_goLogin")
          {Get.offAll(const LoginScreen());}

          if(message.message == "JSC_kill_n_goSplash")
          {Get.offAll(const SplashScreen());}

          if(message.message == "JSC_kill_n_goBack")
          {
            //Snack.show("JSC_kill_n_goBack", "");
            Get.back();}

        },


      )
      ..loadRequest(Uri.parse("${AppVariables.memberUrl}home/1"));


    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor: AppColors.secondary,
              body: SafeArea(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [

                        Expanded(
                          child: Stack(
                          children: [
                            WebViewWidget(controller: _controller),
                            // Obx( ()=> isLoading.value?const BlurLoader():SizedBox()),
                          ],
                          ),
                        ),

                        Container(
                          decoration:   BoxDecoration(
                              color: AppColors.inputBackgroundColor,
                              border: Border.all(width: 0, color: AppColors.inputBackgroundColor),
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          height: 60,
                          child: Obx(() =>
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  BottomNavIcon(
                                    isSelected: index.value==0?true:false,
                                    icon: Remix.notification_2_fill,
                                    onTap: () {
                                      _controller.loadRequest(Uri.parse("${AppVariables.memberUrl}notifications/1"));
                                      index.value = 0;
                                    },
                                  ),

                                  BottomNavIcon(
                                    isSelected: index.value==1?true:false,
                                    icon: Remix.home_2_fill,
                                    onTap: () { _controller.loadRequest(Uri.parse("${AppVariables.memberUrl}home/1"));
                                    index.value = 1;
                                    },
                                  ),

                                  BottomNavIcon(
                                    isSelected: index.value==2?true:false,
                                    icon: Remix.user_2_fill,
                                    onTap: () { _controller.loadRequest(Uri.parse("${AppVariables.memberUrl}profile/1"));
                                    index.value = 2;
                                    },
                                  ),

                                ],
                              ),)
                        )
                      ],
                    ),
                  ))
      ,
    );
  }
}

