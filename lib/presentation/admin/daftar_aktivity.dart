import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/edit_aktivity.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:http/http.dart';

class DaftarAktivity extends StatefulWidget {
  const DaftarAktivity({super.key});

  @override
  State<DaftarAktivity> createState() => _DaftarAktivityState();
}

class _DaftarAktivityState extends State<DaftarAktivity> {
  late List<Map<String, dynamic>> _activityData = [];

  @override
  void initState() {
    super.initState();
    _fetchActivity();
  }

  Future<void> deleteActivity(int activityId) async {
    try {
      var response = await delete(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/activity/$activityId',
          ),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          // Tampilkan dialog sukses jika berhasil
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Berhasil menghapus Activity!',
            btnOkOnPress: () {
              _fetchActivity();
            },
          ).show();
        } else {
          throw data["message"];
        }
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      // Tampilkan dialog error jika gagal
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  Future<void> _fetchActivity() async {
    try {
      final response = await fetchData();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool success = data["success"];
        if (!success) {
          throw Exception("Not success");
        }

        final List<Map<String, dynamic>> activitiess =
            List<Map<String, dynamic>>.from(data["activities"]);

        setState(() {
          _activityData = activitiess;
        });
      } else {
        throw Exception("error");
      }
    } catch (e) {
      print('Error fetching Activity: $e');
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
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const ActivityFrame()),
            //     );
            //   },
            //   child: ClipOval(
            //     child: SizedBox.fromSize(
            //       size: const Size.fromRadius(38), // Image radius
            //       child: Image.asset('assets/ftprofil.png', fit: BoxFit.cover),
            //     ),
            //   ),
            // ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Activity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ))
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
            height: 55,
            child: const Text(
              "Daftar Activity",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200),
              child: DataTable(
                dataRowMaxHeight: double.infinity,
                // headingRowColor: MaterialStateColor.resolveWith(
                //   (states) => Color.fromARGB(255, 118, 216, 122),
                // ),
                columns: const <DataColumn>[
                  DataColumn(label: Text('Judul')),
                  DataColumn(label: Text('File Foto')),
                  // DataColumn(label: Text('Lokasi')),
                  DataColumn(label: Text('Descripsi')),
                  DataColumn(label: Text('Aksi')),
                ],
                rows: _activityData.map((activities) {
                  print(activities.toString());
                  return DataRow(
                    cells: [
                      DataCell(Text(activities["title"] ?? '')),
                      DataCell(
                        SizedBox(
                          width: 100, // Lebar gambar
                          height: 100, // Tinggi gambar
                          child: activities["img_url"] != null
                              ? Image.network(
                                  activities["img_url"],
                                  fit: BoxFit
                                      .contain, // Mengatur agar gambar pas ke dalam kontainer
                                )
                              : const Text(
                                  'Null',
                                  textAlign: TextAlign.center,
                                ), // Placeholder text for null image
                        ),
                      ),
                      // DataCell(Text(activities["location"] ?? '')),
                      // DataCell(Text(activities["content"] ?? '')),
                      DataCell(
                        SizedBox(
                          width: 250,
                          child: Text(
                            activities['content'],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Konfirmasi'),
                                      content: const Text(
                                          'Apakah Anda yakin ingin menghapus aktivitas ini?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Tutup dialog
                                          },
                                          child: const Text('Batal'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Tutup dialog
                                            deleteActivity(activities[
                                                'id']); // Panggil fungsi delete
                                          },
                                          child: const Text(
                                            'Hapus',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child:
                                  const Icon(Icons.delete, color: Colors.red),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     AwesomeDialog(
                            //       context: context,
                            //       dialogType: DialogType.question,
                            //       animType: AnimType.rightSlide,
                            //       title: 'Yakin akan menghapus Activity ini?',
                            //       btnCancelOnPress: () {},
                            //       btnOkOnPress: () {
                            //         deleteActivity(activities['id']);
                            //       },
                            //     ).show();
                            //     // Implementasi untuk menghapus barang
                            //   },
                            //   child:
                            //       const Icon(Icons.delete, color: Colors.red),
                            // ),

                            const SizedBox(
                                width: 8), // Jarak antara ikon delete dan edit
                            InkWell(
                              onTap: () {
                                // Implementasi untuk mengedit barang
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditAktivity(
                                        activity: activities,
                                      ),
                                    ));
                              },
                              child: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                      )
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
            //               'Judul',
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
            //               'File Foto',
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
            //               'Link Lokasi',
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
            //               'Deskripsi',
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
            //                 InkWell(
            //                     onTap: () {
            //                       Navigator.pushReplacement(
            //                           context,
            //                           MaterialPageRoute(
            //                             builder: (context) => const EditAktivity(),
            //                           ));
            //                     },
            //                     child: const Image(
            //                         image: AssetImage('assets/icon.png'))),
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
//   Future<Response> fetchData() async {
//     try {
//       var response = await get(
//           Uri(
//             scheme: 'https',
//             host: 'myhmtk.jeyy.xyz',
//             path: '/fun_tk',
//           ),
//           headers: {
//             HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
//           });

//       return response;
//     } catch (e) {
//       throw Exception('Failed to load: $e');
//     }
//   }
// }
