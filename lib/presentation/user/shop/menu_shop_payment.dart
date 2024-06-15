import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/shop/menu_shop_history.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final String paymentUrl;

  const PaymentPage({super.key, required this.paymentUrl});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WebViewController _webViewController;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    print(widget.paymentUrl);

    // Initialize the WebViewController
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            loadingPercentage = 100;
          },
          onUrlChange: (change) {
            print(change.url);
            if (change.url != null &&
                (change.url == "https://myhmtk.jeyy.xyz/transaction/success" ||
                    change.url ==
                        "https://myhmtk.jeyy.xyz/transaction/pending" || change.url!.startsWith("https://gwa.sandbox.gopayapi.com"))) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MenuShopHistory()));
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Payment'),
      ),
      body: Column(
        children: [
          if (loadingPercentage < 100)
            LinearProgressIndicator(value: loadingPercentage / 100),
          Expanded(
            child: WebViewWidget(
              controller: _webViewController,
            ),
          ),
        ],
      ),
    );
  }
}
