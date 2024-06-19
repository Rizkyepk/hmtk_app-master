import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/edit_lab.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:http/http.dart' as http;

class DaftarLaboratory extends StatefulWidget {
  const DaftarLaboratory({Key? key}) : super(key: key);

  @override
  State<DaftarLaboratory> createState() => _DaftarLaboratoryState();
}

class _DaftarLaboratoryState extends State<DaftarLaboratory> {
  late List<Map<String, dynamic>> _postDatalab = [];
  String? selectedLab;

  @override
  void initState() {
    super.initState();
    selectedLab = 'magics';
    _fetchDataLab(selectedLab);
  }

  Future<void> deleteDataLab(int labPostId) async {
    try {
      var response = await http.delete(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/lab_post/$labPostId',
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
            title: 'Berhasil menghapus post!',
            btnOkOnPress: () {
              _fetchDataLab(selectedLab);
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

  Future<void> _fetchDataLab(selectedLab) async {
    try {
      final response = await fetchData(selectedLab);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool success = data["success"];
        if (!success) {
          throw Exception("Not success");
        }

        final List<Map<String, dynamic>> datalab =
            List<Map<String, dynamic>>.from(data["lab_posts"]);

        setState(() {
          _postDatalab = datalab;
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
        centerTitle: true,
        toolbarHeight: 200,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const ActivityFrame(),
            //       ),
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
                'Laboratory',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        elevation: 0.00,
        backgroundColor: ColorPallete.greenprim,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Row(
              children: [
                const Text(
                  "Daftar Laboratory",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10), // Beri jarak antara teks dan dropdown
                DropdownButton<String>(
                  value: selectedLab,
                  items: [
                    'magics',
                    'sea',
                    'evconn',
                    'ismile',
                    'rnest',
                    'security',
                  ].map((lab) {
                    return DropdownMenuItem<String>(
                      value: lab,
                      child: Text(
                        '${lab[0].toUpperCase()}${lab.substring(1)} Lab',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.bold), // Atur ukuran dan warna teks
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLab = value;
                      _fetchDataLab(selectedLab);
                    });
                  },
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue), // Atur ukuran dan warna teks tombol dropdown
                  dropdownColor: Colors.grey[200], // Atur warna latar belakang dropdown
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Column(
            children: [
              // Drop-down menu for lab selection
              // DropdownButton<String>(
              //   value: selectedLab,
              //   items: [
              //     'magics',
              //     'sea',
              //     'evconn',
              //     'ismile',
              //     'rnest',
              //     'security',
              //   ].map((lab) {
              //     return DropdownMenuItem<String>(
              //       value: lab,
              //       child: Text(
              //         '${lab[0].toUpperCase()}${lab.substring(1)} Lab',
              //         style: const TextStyle(
              //             fontSize: 18,
              //             color: Colors.blue), // Atur ukuran dan warna teks
              //       ),
              //     );
              //   }).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       selectedLab = value;
              //       _fetchDataLab(selectedLab);
              //     });
              //   },
              //   style: const TextStyle(
              //       fontSize: 18,
              //       color: Colors
              //           .blue), // Atur ukuran dan warna teks tombol dropdown
              //   dropdownColor:
              //       Colors.grey[200], // Atur warna latar belakang dropdown
              // ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200),
                  child: DataTable(
                    dataRowMaxHeight: double.infinity,
                    columns: const [
                      DataColumn(label: Text('Judul')),
                      DataColumn(label: Text('File Foto')),
                      DataColumn(label: Text('Waktu Post')),
                      DataColumn(label: Text('Aksi')),
                    ],
                    rows: _postDatalab.map((labPost) {
                      return DataRow(
                        cells: [
                          DataCell(
                            SizedBox(
                              width: 250,
                              child: Text(
                                labPost["content"],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: labPost["img_url"] != null
                                  ? Image.network(
                                      labPost["img_url"],
                                      fit: BoxFit.fill,
                                    )
                                  : const Text(
                                      'Null',
                                      textAlign: TextAlign.center,
                                    ),
                            ),
                          ),
                          DataCell(
                              Text(formatDateTime(labPost["post_date"] ?? ''))),
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
                                                deleteDataLab(labPost[
                                                    'id']); // Panggil fungsi delete
                                              },
                                              child: const Text(
                                                'Hapus',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.delete,
                                      color: Colors.red),
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     deleteDataLab(labPost['id']);
                                //   },
                                //   child: const Icon(Icons.delete,
                                //       color: Colors.red),
                                // ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditLab(
                                          lab: labPost,
                                        ),
                                      ),
                                    );
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
        ],
      ),
    );
  }

  Future<http.Response> fetchData(String lab) async {
    try {
      Map<String, String> params = {'lab': lab};

      var response = await http.get(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/lab_post',
          queryParameters: params,
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
        },
      );

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
            //               'File Foto',
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.all(15),
            //             height: 50,
            //             width: 200,
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
            //             width: 200,
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
            //                               title: 'Yakin ingin menghapus data?',
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
            //                             builder: (context) => const EditLab(),
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

  
// }
