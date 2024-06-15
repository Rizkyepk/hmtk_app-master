import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/webview.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuDetailActivity extends StatefulWidget {
  final int funTkId;

  const MenuDetailActivity({super.key, required this.funTkId});

  @override
  State<MenuDetailActivity> createState() => _MenuDetailActivityState();
}

class _MenuDetailActivityState extends State<MenuDetailActivity> {
  bool tapFavorite = false;
  void _openGoogleMaps(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> funTks(int funTkId) async {
      try {
        final response = await fetchFunTks(funTkId);

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final bool success = data["success"];
          if (!success) {
            throw Exception("Not success");
          }

          return Map<String, dynamic>.from(data["fun_tk"]);
        } else {
        throw "Status code: ${response.statusCode}";
      }
      } catch (e) {
        throw Exception('Error: $e');
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Kegiatan Fun TK"),
        ),
        body: FutureBuilder(
            future: funTks(widget.funTkId),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading data...');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final funTk = snapshot.data!;

                return SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.network(
                            // 'assets/img-futsal.png',
                            funTk["img_url"],
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // 'FUN FUTSAL',
                                funTk["title"],
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                          blurRadius: 20,
                                          color: Colors.black.withOpacity(0.7))
                                    ],
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 150,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.45,
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(
                                left: 20, top: 20, right: 20, bottom: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    // 'Lapangan Rajawali',
                                    funTk["location"],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Text(
                                  'Informasi',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  funTk["description"],
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.green),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (!funTk["map_url"].isEmpty)
                                const Text(
                                  'Lokasi',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                if (!funTk["map_url"].isEmpty)
                                //test display and button
                                // SizedBox(height: 20),
                                // ElevatedButton(
                                //   onPressed: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             WebviewMaps(url: funTk['map_url']),
                                //       ),
                                //     );
                                //   },
                                //   child: Text('Open Google Maps'),
                                // ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _openGoogleMaps(funTk['map_url']);
                                    },
                                    child: const Text('Open Google Maps'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
              }
            }));
  }
}

Future<Response> fetchFunTks(int funTkId) async {
  try {
    var response = await get(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/fun_tk/$funTkId',
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
        });

    return response;
  } catch (e) {
    throw Exception('Error: $e');
  }
}
