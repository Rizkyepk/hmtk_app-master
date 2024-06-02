import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final String paymentUrl;

  const PaymentPage({super.key, required this.paymentUrl});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    print(widget.paymentUrl);

    // Initialize the WebViewController
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            // Detect when the payment is completed or failed
            if (url.contains('https://yourdomain.com/payment-success')) {
              Navigator.of(context).pop(true);
            } else if (url.contains('https://yourdomain.com/payment-failed')) {
              Navigator.of(context).pop(false);
            }
          },
          onUrlChange: (change) {
            print("URL TO: ${change.url}");
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
      body: 
      WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
