import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hmtk_app/presentation/admin/daftar_material_bank.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class EditMaterialBank extends StatefulWidget {
  final Map<String, dynamic> materi;
  const EditMaterialBank({super.key, required this.materi});

  @override
  State<EditMaterialBank> createState() => _EditMaterialBankState();
}

class _EditMaterialBankState extends State<EditMaterialBank> {
  var titleController = TextEditingController();
  var levelController = TextEditingController();
  var linkController = TextEditingController();

  Future<void> _uploadData(int id) async {
    String title = titleController.text;
    int level = int.parse(levelController.text);
    String link = linkController.text;
    try {
      var response = await editDataMateri(id, title, level, link);

      if (response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Success',
          desc: 'Activity successfully edited!',
          btnOkOnPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DaftarMaterialBank()),
            );
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Failed',
          desc: 'Failed to edit activity. Please try again later.',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed',
        desc: 'Failed to edit activity: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.materi["subject"];
    levelController.text = widget.materi["level"].toString();
    linkController.text = widget.materi["link"];

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
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: ColorPallete.greenprim,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Edit Material Bank',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                child: const Text(
                  'Kosongkan jika tidak ingiin mengubah data',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Colors.green.withOpacity(0.1))
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Form Edit Halaman Bank Materi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const Column(
                  children: [
                    Divider(
                      color: Color.fromARGB(255, 219, 219, 219),
                      height: 15,
                      thickness: 2,
                      indent: 0.2,
                      endIndent: 0.2,
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    "Tingkat Mata Kuliah",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(left: 10),
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                        width: 2.0,
                      ),
                    ),
                    child: TextFormField(
                      controller: levelController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  const Text(
                    "Nama Mata Kuliah",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(left: 10),
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                        width: 2.0,
                      ),
                    ),
                    child: TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  const Text(
                    "Link Bank Materi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(left: 10),
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                        width: 2.0,
                      ),
                    ),
                    child: TextFormField(
                      controller: linkController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 1, 122, 5),
                        ),
                        // onPressed: () {
                        //   Navigator.push(
                        //     context,
                        //     // DetailPage adalah halaman yang dituju
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             const DaftarMaterialBank()),
                        //   );
                        // },
                        onPressed: () => _uploadData(widget.materi["id"]),
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Response> editDataMateri(
      int materiId, String title, int level, String url) async {
    try {
      Map<String, String> params = {
        // 'material_bank_id': materiId,
        'subject': title,
        'level': level.toString(),
        'link': url,
      };

      var response = await http.put(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/bank_material/$materiId',
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
