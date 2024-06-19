import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:http/http.dart';

class DetailActivity extends StatefulWidget {
  final Map<String, dynamic> activity;
  const DetailActivity({super.key, required this.activity});

  @override
  State<DetailActivity> createState() => _DetailActivityState();
}

class _DetailActivityState extends State<DetailActivity> {
  bool tapFavorite = false;
  List<dynamic> activities = []; // Variabel untuk menyimpan daftar aktivitas

  @override
  void initState() {
    super.initState();
    fetchData(); // Panggil method fetchData saat widget dibuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aktivitas Terkini"),
      ),
      body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: const EdgeInsets.only(
                  left: 20, top: 20, right: 20, bottom: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                    ),
                    Text(
                      // 'Informasi',
                      widget.activity["title"],
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Admin"),
                        Text(
                          timeAgoFromIso(widget.activity["post_date"]),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Image.network(
                            widget.activity["img_url"],
                            height: 200,
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return SizedBox(
                                  height: 200,
                                  width: double.maxFinite,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.activity['content'],
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const Text(
                    //   'Lokasi',
                    //   style: TextStyle(
                    //       fontSize: 16, fontWeight: FontWeight.bold),
                    // ),
                    // Image.asset(
                    //   'assets/maps.png',
                    //   height: 180,
                    //   fit: BoxFit.cover,
                    // )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Future<Response> fetchData() async {
    try {
      var response = await get(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/activity',
          ),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          });

      return response;
    } catch (e) {
      throw Exception('Failed to load: $e');
    }
  }
}