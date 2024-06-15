import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/sso/sso_checking.dart';
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
  int loginSeconds = 0;

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
                      // var i = 0;
                      while (!localStorage.containsKey("profile_situ")) {
                        await Future.delayed(const Duration(seconds: 1));
                        localStorage = await getLocalStorage();
                        loginSeconds += 1;

                        if (loginSeconds == 60) {
                          setState(() {
                            showLoginLoading = false;
                          });

                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title:
                                'Login Gagal: SSO Error, silahkan coba beberapa saat lagi',
                            btnOkOnPress: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Start(),
                                  ));
                            },
                          ).show();
                        }
                      }

                      setState(() {
                        showLoginLoading = false;
                      });

                      Map<String, dynamic> profile =
                          jsonDecode(localStorage["profile_situ"]);
                      print(profile);
                      print(profile["fullname"]);

                      print(
                          "--------------------------- GOT DATA ----------------");

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SsoChecking(ssoData: profile),
                          ));
                      // AwesomeDialog(
                      //   context: context,
                      //   dialogType: DialogType.info,
                      //   animType: AnimType.rightSlide,
                      //   title: 'SSO Login Info: ${profile.toString()}',
                      //   btnOkOnPress: () {
                      //     Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => const Start(),
                      //         ));
                      //   },
                      // ).show();

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
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: ColorPallete.greensec),
              child: loginSeconds < 30
                  ? const Row(
                      children: [
                        Text("Getting SSO Login Information...",
                            style: TextStyle(color: Colors.white)),
                        CircularProgressIndicator()
                      ],
                    )
                  : const Row(
                      children: [
                        Text(
                            "Getting SSO Login Information... Telkom's server might have a meltdown, might take longer..",
                            style: TextStyle(color: Colors.white)),
                        CircularProgressIndicator()
                      ],
                    ),
            )
        ],
      ),
    );
  }
}
