import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/edit_material_bank.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:http/http.dart' as http;

class DaftarMaterialBank extends StatefulWidget {
  const DaftarMaterialBank({Key? key}) : super(key: key);

  @override
  State<DaftarMaterialBank> createState() => _DaftarMaterialBankState();
}

class _DaftarMaterialBankState extends State<DaftarMaterialBank> {
  List<Map<String, dynamic>> _postDataMaterial = [];
  String selectedLevel = '1';

  @override
  void initState() {
    super.initState();
    _fetchDataMaterial(selectedLevel);
  }

  Future<void> _fetchDataMaterial(String level) async {
    try {
      final response = await fetchData();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool success = data["success"];
        if (!success) {
          throw Exception("Request failed");
        }

        final List<dynamic> materials = data["bank_materials"];
        setState(() {
          _postDataMaterial = materials.cast<Map<String, dynamic>>();
        });
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error, show dialog, etc.
    }
  }

  Future<void> deleteMaterial(int materialId) async {
    try {
      var response = await http.delete(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/bank_material/$materialId',
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          // Show success dialog if successful
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Successfully deleted material!',
            btnOkOnPress: () {
              _fetchDataMaterial(selectedLevel);
            },
          ).show();
        } else {
          throw data["message"];
        }
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      // Show error dialog if failed
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed: $e',
        btnOkOnPress: () {},
      ).show();
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
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Materi Bank',
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
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Row(
                    children: [
                      const Text(
                        "Daftar Materi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // DropdownButton<String>(
                      //   value: selectedLevel,
                      //   items: [
                      //     '1',
                      //     '2',
                      //     '3',
                      //     '4',
                      //   ].map((level) {
                      //     return DropdownMenuItem<String>(
                      //       value: level,
                      //       child: Text(
                      //         'Tingkat $level',
                      //         style: const TextStyle(
                      //           fontSize: 18,
                      //           color: Colors.green,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     );
                      //   }).toList(),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       selectedLevel = value!;
                      //       _fetchDataMaterial(selectedLevel);
                      //     });
                      //   },
                      //   dropdownColor: Colors.grey[200],
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        child: DataTable(
                          dataRowHeight: 100,
                          columns: const [
                            DataColumn(label: Text('Nama Mata Kuliah')),
                            DataColumn(label: Text('Link')),
                            DataColumn(label: Text('Aksi')),
                          ],
                          rows: _postDataMaterial.map((material) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      material["subject"] ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      material["link"] ?? '',
                                      maxLines: 2,
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
                                                  'Apakah Anda yakin ingin menghapus materi ini?',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Batal'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      deleteMaterial(
                                                          material['id']);
                                                    },
                                                    child: const Text(
                                                      'Hapus',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditMaterialBank(
                                                materi: material,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Icon(Icons.edit),
                                      ),
                                    ],
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }

  Future<http.Response> fetchData() async {
    try {
      var response = await http.get(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/bank_material',
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
