import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewMaps extends StatefulWidget {
  final String url;
  const WebviewMaps({super.key, required this.url});

  @override
  State<WebviewMaps> createState() => _WebviewMapsState();
}

class _WebviewMapsState extends State<WebviewMaps> {
  WebViewController? _controller;

  @override
  void initState() {
    // TODO: implement activate
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('url'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget.new(controller: _controller!),
    );
  }
}
