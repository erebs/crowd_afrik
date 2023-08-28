import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/views/widgets/shimmers/blur_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:get/get.dart';
import '../../../contants/app_variables.dart';
import '../../widgets/shimmers/search_shimmer.dart';
import '../loginscreen/login_screen.dart';
import '../mainscreen/main_screen.dart';
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
            getHtmlPageTitle();
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

            debugPrint('allowing navigation to ${request.url}');
            if (request.url==widget.url) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.navigate;
            }else
              {
                Get.to(WebScreen(url: request.url));
                return NavigationDecision.prevent;
              }

          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
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
      ..loadRequest(Uri.parse(widget.url));


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
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(titleJS, style: const TextStyle(fontSize: 14),),
      ),
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child:
        Stack(
          children: [
            WebViewWidget(controller: _controller),
            Obx( ()=> isLoading.value?const BlurLoader():SizedBox()),
          ],
        )
      ),
    );
  }


  Future<void>  getHtmlPageTitle() async {
    if (_controller != null) {
      Object pageTitle = await _controller.runJavaScriptReturningResult('document.title');
      setState(() {
        titleJS = isInstamojo?"Instamojo":pageTitle.toString().replaceAll('"', '');
      });
    }
  }

}
