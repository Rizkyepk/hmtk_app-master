import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/aspiration/menu_aspiration.dart';
import 'package:hmtk_app/utils/snapping_data.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/template_page.dart';
import 'package:http/http.dart';

import '../drawer/drawer_user.dart';

class MenuRiwayatAspirasi extends StatelessWidget {
  const MenuRiwayatAspirasi({super.key});

  @override
  Widget build(BuildContext context) {
    return snap((user) {
      final nim = user['nim'].toString();

      return FutureBuilder<Response>(
        future: fetchData(nim), // Call fetchData with the obtained NIM
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Parse the JSON response
            final Map<String, dynamic> data = json.decode(snapshot.data!.body);
            final List<dynamic> aspirations = data['aspirations'];

            return Scaffold(
              drawer: const Drawer(
                width: 200,
                backgroundColor: Colors.transparent,
                child: DrawerUserScren(),
              ),
              appBar: AppBar(
                elevation: 0,
              ),
              body: MyPage(
                widget: ListView(
                  padding: const EdgeInsets.all(25),
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MenuAspiration(),
                              ),
                            );
                          },
                          child: const MyButton(
                            txt: 'Input Aspirasi',
                            width: 150,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(0, 5),
                              )
                            ],
                          ),
                          child: const MyButton(
                            txt: 'Riwayat Aspirasi',
                            width: 150,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Table(
                        columnWidths: const {
                          0: FixedColumnWidth(20),
                          1: FixedColumnWidth(80),
                          2: FixedColumnWidth(80),
                          3: FixedColumnWidth(80),
                        },
                        border: const TableBorder.symmetric(
                          outside: BorderSide.none,
                          inside: BorderSide(),
                        ),
                        children: [
                          const TableRow(children: [
                            Text(
                              'No',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Tanggal',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Judul',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Isi',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                          // Map
                          for (var i = 0; i < aspirations.length; i++)
                            TableRow(children: [
                              Text(
                                (i + 1).toString(),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                formatDateTime(aspirations[i]['datetime']),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                aspirations[i]['title'],
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                aspirations[i]['content'],
                                textAlign: TextAlign.center,
                              ),
                            ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      );
    });
  }

  Future<Response> fetchData(String nim) async {
    try {
      Map<String, dynamic> params = {
        'mahasiswa_nim': nim,
      };
      var response = await get(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/aspiration',
            queryParameters: params,
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
