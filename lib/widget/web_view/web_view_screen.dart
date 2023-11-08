import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:get/get.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    Key? key,
    this.url,
    this.html,
    required this.callbackUrl,
    this.title,
    this.isCallback = true,
    this.isShowButtonBack = true,
  }) : super(key: key);

  final String? url;
  final String? html;
  final String? title;
  final bool isCallback;
  final bool isShowButtonBack;
  final Function(Map<String, dynamic>) callbackUrl;

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool isLoading = false;
  bool canRedirect = true;

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
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (!isLoading) {
              const CircularProgressIndicator();
              // EasyLoading.show(dismissOnTap: false);
            }
          },
          onPageStarted: (String url) {
            // if (!isLoading) {
            //   EasyLoading.show(dismissOnTap: false);
            // }
            // debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            isLoading = true;
            // EasyLoading.dismiss();
            // debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            //   debugPrint('''
            //     Page resource error:
            //       code: ${error.errorCode}
            //       description: ${error.description}
            //       errorType: ${error.errorType}
            //       isForMainFrame: ${error.isForMainFrame}
            // ''');
          },
          onNavigationRequest: (NavigationRequest request) async {
            if (widget.isCallback && canRedirect) {
              if (request.url.startsWith("http://localhost") ||
                  request.url.startsWith("https://localhost")) {
                const CircularProgressIndicator();
                //  EasyLoading.show(dismissOnTap: false);
                Future.delayed(const Duration(seconds: 1), () {
                  isLoading = true;
                  // EasyLoading.dismiss();
                  var split = request.url.split("?");
                  var response = Uri.splitQueryString(split[split.length - 1]);
                  widget.callbackUrl(response);
                });
                return NavigationDecision.prevent;
              }
            }

            if (request.url.startsWith('tel:') ||
                request.url.startsWith('fb:') ||
                request.url.startsWith('mailto:')) {
              // Allow navigation to tel: links
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            // debugPrint('url change to ${change.url}');
          },
        ),
      )
    // ..addJavaScriptChannel(
    //   'Toaster',
    //   onMessageReceived: (JavaScriptMessage message) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text(message.message)),
    //     );
    //   },
    // )
      ..loadRequest(widget.url != null
          ? Uri.parse(widget.url!)
          : Uri.dataFromString(setHTML(),
          mimeType: 'text/html', encoding: Encoding.getByName('utf-8')));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  String setHTML() {
    return ('''
    <html>
      <head>
        <script>
          if(!document.__defineGetter__) {
             Object.defineProperty(document, 'cookie', {
                get: function(){return ''},
                set: function(){return true},
              });
          } else {
            document.__defineGetter__("cookie", function() { return '';} );
            document.__defineSetter__("cookie", function() {} );
          }
        </script>
      </head>
        <body>
          ${widget.html!}
        </body>
      </html>
    ''');
  }

  // _loadHTML() async {
  //   _con!.loadUrl(Uri.dataFromString(setHTML(),
  //           mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
  //       .toString());
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return Future.value(false);
        } else {
          isLoading = true;
          canRedirect = false;
          //  EasyLoading.dismiss();
          Get.back(result: true);
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(widget.title ?? 'Transaction Verification'.tr),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: WebViewWidget(
          controller: _controller,
        ),
      ),
    );
  }

  @override
  void dispose() {
    isLoading = true;
    super.dispose();
  }
}
