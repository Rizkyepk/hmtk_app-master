import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/template_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../drawer/drawer_user.dart';
import 'menu_detail_funTK.dart';

class MenuJadwalFunTK extends StatelessWidget {
  const MenuJadwalFunTK({super.key});
  Future<List<Map<String, dynamic>>> _fun_tks() async {
    try {
      final response = await fetchFunTks();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool success = data["success"];
        if (!success) {
          throw Exception("Not success");
        }

        return List<Map<String, dynamic>>.from(data["fun_tks"]);
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id');

    return Scaffold(
      drawer: const Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerUserScren(),
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Jadwal Fun TK'),
      ),
      body: MyPage(
        widget: FutureBuilder(
            future: _fun_tks(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final funTks = snapshot.data!;

                return ListView.builder(
                  padding: const EdgeInsets.all(40),
                  itemCount: funTks.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuDetailActivity(
                                funTkId: funTks[index]["id"]),
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                offset: const Offset(1, 4),
                                blurRadius: 5)
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, right: 20),
                            child: Text(
                              funTks[index]["title"],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    // 'assets/img-fun-tk.png',
                                    funTks[index]["img_url"],
                                    height: 230,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    height: 70,
                                    width: 70,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      // '12\nDes',
                                      DateFormat('dd\nMMM', 'id').format(
                                          DateTime.parse(
                                              funTks[index]["date"])),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${funTks[index]["time"].toString().substring(0, 5)} WIB',
                                  style: TextStyle(
                                      color: ColorPallete.blue,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/icon-lokasi.png'),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      // 'Lapangan Rajawali',
                                      funTks[index]["location"],
                                      style: TextStyle(
                                        color: ColorPallete.greenprim,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}

Future<Response> fetchFunTks() async {
  try {
    var response = await get(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/fun_tk',
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
        });

    return response;
  } catch (e) {
    throw Exception('Error: $e');
  }
}
