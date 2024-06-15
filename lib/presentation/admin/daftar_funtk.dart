import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/edit_fun_tk.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:http/http.dart';

class DaftarFuntk extends StatefulWidget {
  const DaftarFuntk({super.key});

  @override
  State<DaftarFuntk> createState() => _DaftarFuntkState();
}

class _DaftarFuntkState extends State<DaftarFuntk> {
  late List<Map<String, dynamic>> _funData = [];

  @override
  void initState() {
    super.initState();
    _fetchFun();
  }

  Future<void> deleteProduct(int funTkId) async {
    try {
      var response = await delete(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/fun_tk/$funTkId',
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
            title: 'Berhasil menghapus FunTK!',
            btnOkOnPress: () {
              _fetchFun();
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

  Future<void> _fetchFun() async {
    try {
      final response = await fetchData();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool success = data["success"];
        if (!success) {
          throw Exception("Not success");
        }

        final List<Map<String, dynamic>> products =
            List<Map<String, dynamic>>.from(data["fun_tks"]);

        setState(() {
          _funData = products;
        });
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw 'Error fetching products: $e';
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
              //       child:
              //           Image.asset('assets/ftprofil.png', fit: BoxFit.cover),
              //     ),
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Fun TK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              )
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
        body: ListView(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            height: 55,
            child: const Text(
              "Daftar Fun TK",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: DataTable(
                  dataRowMaxHeight: double.infinity,
                  columns: const [
                    DataColumn(label: Text('Tanggal Pelaksanaan')),
                    DataColumn(label: Text('Waktu Peraksanaan')),
                    DataColumn(label: Text('File Foto')),
                    DataColumn(label: Text('Lokasi')),
                    DataColumn(label: Text('Informasi')),
                    DataColumn(label: Text('Aksi')),
                  ],
                  rows: _funData.map((funTks) {
                    return DataRow(
                      cells: [
                        DataCell(Text(funTks["date"] ?? '')),
                        DataCell(Text(funTks["time"] ?? '')),
                        DataCell(
                          SizedBox(
                            width: 100, // Lebar gambar
                            height: 100, // Tinggi gambar
                            child: funTks["img_url"] != null
                                ? Image.network(
                                    funTks["img_url"],
                                    fit: BoxFit
                                        .contain, // Mengatur agar gambar pas ke dalam kontainer
                                  )
                                : const Text(
                                    'Null'), // Placeholder text for null image
                          ),
                        ),
                        DataCell(Text(funTks["location"] ?? '')),
                        // DataCell(Text(fun_tks["description"] ?? '')),
                        DataCell(
                          SizedBox(
                            width: 250,
                            child: Text(
                              funTks["description"],
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
                                              deleteProduct(funTks[
                                                  'id']); // Panggil fungsi delete
                                            },
                                            child: const Text(
                                              'Hapus',
                                              style:
                                                  TextStyle(color: Colors.red),
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
                              //     // Implementasi untuk menghapus barang
                              //     deleteProduct(funTks['id']);
                              //   },
                              //   child:
                              //       const Icon(Icons.delete, color: Colors.red),
                              // ),
                              const SizedBox(
                                  width:
                                      8), // Jarak antara ikon delete dan edit
                              InkWell(
                                onTap: () {
                                  // Implementasi untuk mengedit barang
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditFunTk(
                                          fun_tk: funTks,
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
            // ))
          ),
        ]));
  }

  Future<Response> fetchData() async {
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
            //             padding: const EdgeInsets.all(3),
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
            //             child: const Column(
            //               children: [
            //                 Text(
            //                   'Tanggal',
            //                   textAlign: TextAlign.center,
            //                 ),
            //                 Text(
            //                   'Pelaksanaan',
            //                   textAlign: TextAlign.center,
            //                 ),
            //               ],
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
            //             padding: const EdgeInsets.all(3),
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
            //             child: const Column(
            //               children: [
            //                 Text(
            //                   'Waktu',
            //                   textAlign: TextAlign.center,
            //                 ),
            //                 Text(
            //                   'Pelaksanaan',
            //                   textAlign: TextAlign.center,
            //                 ),
            //               ],
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
            //               'Lokasi',
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
            //               'Informasi',
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
            //                             builder: (context) => const EditFunTk(),
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
              // ],
            // ),
//           ),
//         ],
//       ),
//     );
//   }
// }
