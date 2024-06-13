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
          // actions: [
          //   CircleAvatar(
          //     backgroundColor: Colors.grey.shade50.withOpacity(0.5),
          //     child: IconButton(
          //         onPressed: () {
          //           setState(() {
          //             tapFavorite = !tapFavorite;
          //           });
          //         },
          //         icon: tapFavorite
          //             ? const Icon(
          //                 Icons.favorite,
          //                 color: Colors.red,
          //                 size: 25,
          //               )
          //             : const Icon(
          //                 Icons.favorite,
          //                 color: Colors.white,
          //                 size: 25,
          //               )),
          //   ),
          //   const SizedBox(
          //     width: 10,
          //   )
          // ],
          ),
      body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.network(
                  widget.activity['img_url'],
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   'Watch a match!',
                  //   style: TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white),
                  // ),
                  Text(
                    widget.activity['title'],
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[400]),
                  ),
                  const SizedBox(
                    height: 150,
                  )
                ],
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          // child: Text(
                          //   'KBAA Champion',
                          //   style: TextStyle(
                          //       fontSize: 20, fontWeight: FontWeight.bold),
                          // ),
                        ),
                        const Text(
                          'Informasi',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.activity['content'],
                          style: const TextStyle(fontSize: 14, color: Colors.green),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Lokasi',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Image.asset(
                          'assets/maps.png',
                          height: 180,
                          fit: BoxFit.cover,
                        )
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
