import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/start.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SsoLogin extends StatefulWidget {
  const SsoLogin({super.key});

  @override
  _SsoLoginState createState() => _SsoLoginState();
}

class _SsoLoginState extends State<SsoLogin> {
  WebViewController? _webViewController;
  var loadingPercentage = 0;
  bool showLoginLoading = false;

  Future<String> getUrl() async {
    var response = await post(Uri.parse(
        "https://api-gateway.telkomuniversity.ac.id/microsoft/issueauth"));
    var data = jsonDecode(response.body);

    return data["auth_url"];
  }

  @override
  void initState() {
    super.initState();

    getUrl().then((authUrl) => {
          setState(() {
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
                  onUrlChange: (change) async {
                    // print(change.url);
                    if (change.url != null &&
                        change.url!.startsWith(
                            "https://satu.telkomuniversity.ac.id/redirect")) {
                      setState(() {
                        showLoginLoading = true;
                      });

                      Future<Map> getLocalStorage() async {
                        final localStorageData = await _webViewController!
                            .runJavaScriptReturningResult('''
                              (function() {
                                var storageData = {};
                                for (var i = 0; i < localStorage.length; i++) {
                                  var key = localStorage.key(i);
                                  storageData[key] = localStorage.getItem(key);
                                }
                                // return JSON.stringify(storageData);
                                return storageData;
                              })();
                            ''');

                        print(
                            '------- LocalStorage Data: ${localStorageData.toString()}');
                        Map json = jsonDecode(localStorageData.toString());
                        return json;
                      }

                      var localStorage = await getLocalStorage();
                      var i = 0;
                      while (!localStorage.containsKey("profile_situ")) {
                        await Future.delayed(const Duration(seconds: 1));
                        localStorage = await getLocalStorage();
                        i += 1;

                        if (i == 20) {
                          setState(() {
                            showLoginLoading = false;
                          });

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Start(),
                              ));
                        }
                      }

                      setState(() {
                        showLoginLoading = false;
                      });

                      Map<String, dynamic> profile =
                          jsonDecode(localStorage["profile_situ"]);
                      print(profile);
                      print(profile["fullname"]);

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'SSO Login Info: ${profile.toString()}',
                        btnOkOnPress: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Start(),
                              ));
                        },
                      ).show();

                      // jsonDecode(Map<String, dynamic>.from(localStorageData)["profile_situ"]);
                    }
                  },
                ),
              );
            // ..loadRequest(Uri.parse(authUrl));

            var cookieManager = WebViewCookieManager();
            cookieManager.clearCookies();

            _webViewController!.clearCache();
            _webViewController!.clearLocalStorage();
            _webViewController!.loadRequest(Uri.parse(authUrl));
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login SSO'),
      ),
      body: Column(
        children: [
          if (loadingPercentage < 100)
            LinearProgressIndicator(value: loadingPercentage / 100),
          Expanded(
            child: _webViewController == null
                ? Container()
                : WebViewWidget(
                    controller: _webViewController!,
                  ),
          ),
          if (showLoginLoading)
            Container(
              height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: ColorPallete.greensec),
              child: const Text("Getting SSO Login Information...",
                  style: TextStyle(color: Colors.white)),
            )
        ],
      ),
    );
  }
}
