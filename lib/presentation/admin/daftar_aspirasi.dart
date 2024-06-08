import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:http/http.dart';

class DaftarAspirasi extends StatefulWidget {
  const DaftarAspirasi({super.key});

  @override
  State<DaftarAspirasi> createState() => _DaftarAspirasiState();
}

class _DaftarAspirasiState extends State<DaftarAspirasi> {
  late List<Map<String, dynamic>> _aspirationData = [];

  @override
  void initState() {
    super.initState();
    _fetchAspirationData();
  }

  Future<void> _fetchAspirationData() async {
    try {
      final response = await fetchData();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool success = data["success"];
        if (!success) {
          throw Exception("Not success");
        }

        final List<Map<String, dynamic>> aspirationss =
            List<Map<String, dynamic>>.from(data["aspirations"]);

        setState(() {
          _aspirationData = aspirationss;
        });
      } else {
        throw Exception("error");
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerScren(),
      ),
      appBar: AppBar(
        // title: const Text("GeeksforGeeks"),
        // titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 200,
        // toolbarOpacity: 0.8,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ActivityFrame()),
                );
              },
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(38), // Image radius
                  child: Image.asset('assets/ftprofil.png', fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Hello, Ivan'))
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: ColorPallete.greenprim,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: const Text(
              "Daftar Aspiration",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            height: 55,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              child: DataTable(
                dataRowMaxHeight: double.infinity,
                columns: const [
                  DataColumn(label: Text('Judul')),
                  DataColumn(label: Text('Aspirasi')),
                  DataColumn(label: Text('Tanggal')),
                  // DataColumn(label: Text('File Foto')),
                ],
                rows: _aspirationData.map((aspirations) {
                  return DataRow(
                    cells: [
                      DataCell(Text(aspirations["title"] ?? '')),
                      DataCell(
                        SizedBox(
                          width: 250,
                          child: Text(
                            aspirations["content"],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(Text(aspirations["datetime"] ?? '')),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Response> fetchData() async {
    try {
      var response = await get(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/aspiration',
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
            // child: Column(
            //   children: [
            //     Container(
            //       margin: const EdgeInsets.fromLTRB(10, 10, 10, 2),
            //       child: Row(
            //         children: [
            //           Container(
            //             padding: const EdgeInsets.all(15),
            //             height: 50,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(10))),
            //             child: const Text(
            //               'Nama',
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.all(15),
            //             height: 50,
            //             width: 100,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //             child: const Text(
            //               'NIM',
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.all(15),
            //             height: 50,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //             child: const Text(
            //               'Tanggal',
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.all(15),
            //             height: 50,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //             child: const Text(
            //               'Aspirasi',
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.all(15),
            //             height: 50,
            //             width: 100,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topRight: Radius.circular(10))),
            //             child: const Text(
            //               'Aksi',
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            //       child: Row(
            //         children: [
            //           Container(
            //             height: 100,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //           ),
            //           Container(
            //             height: 100,
            //             width: 100,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //           ),
            //           Container(
            //             height: 100,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //           ),
            //           Container(
            //             height: 100,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //           ),
            //           Container(
            //             height: 100,
            //             width: 100,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topRight: Radius.circular(0))),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 InkWell(
            //                     onTap: () {
            //                       AwesomeDialog(
            //                               context: context,
            //                               dialogType: DialogType.question,
            //                               animType: AnimType.rightSlide,
            //                               title:
            //                                   'Yakin ingin menghapus data?',
            //                               btnOkOnPress: () {},
            //                               btnCancelOnPress: () {})
            //                           .show();
            //                     },
            //                     child: const Image(
            //                         image: AssetImage('assets/Vector.png'))),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
//           ),
//         ],
//       ),
//     );
//   }
// }
