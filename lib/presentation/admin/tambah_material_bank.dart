import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/daftar_material_bank.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:http/http.dart';

class TambahmaterialBank extends StatefulWidget {
  const TambahmaterialBank({Key? key}) : super(key: key);

  @override
  State<TambahmaterialBank> createState() => _TambahmaterialBankState();
}

class _TambahmaterialBankState extends State<TambahmaterialBank> {
  var namaController = TextEditingController();
  var urlController = TextEditingController();
  int? valTingkat = 1; // Initial value for the dropdown

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Tambah Material Bank',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                child: const Text(
                  'Form yang diunggah akan ditampilkan di halaman Material Bank',
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
                  'Form Unggah Halaman Bank Materi',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.3),
                          width: 2.0,
                        ),
                      ),
                      child: DropdownButton<int>(
                        value: valTingkat, // make sure to define this variable
                        isExpanded: true,
                        isDense: true,
                        items: const [
                          DropdownMenuItem(
                            value: 1,
                            child: Text('Tingkat 1'),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text('Tingkat 2'),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text('Tingkat 3'),
                          ),
                          DropdownMenuItem(
                            value: 4,
                            child: Text('Tingkat 4'),
                          ),
                        ],
                        onChanged: (val) {
                          setState(() {
                            valTingkat = val!;
                          });
                        },
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
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.3),
                          width: 2.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: namaController,
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
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.3),
                          width: 2.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: urlController,
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
                            backgroundColor:
                                const Color.fromARGB(255, 1, 122, 5),
                          ),
                          onPressed: _addmateri,
                          child: const Text(
                            'Tambah',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _addmateri() async {
    final String inputnama = namaController.text;
    final String inputtingkat = valTingkat.toString(); // Use the dropdown value
    final String inputurl = urlController.text;

    try {
      Map<String, String> params = {
        'level': inputtingkat,
        'subject': inputnama,
        'link': inputurl,
      };

      var response = await post(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/bank_material',
          queryParameters: params,
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
        },
        body: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool success = data['success'];
        if (success) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Berhasil menambahkan produk baru!',
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const DaftarMaterialBank()),
              );
            },
          ).show();
        } else {
          final String errorMessage = data['message'];
          throw errorMessage;
        }
      } else {
        throw 'Gagal menambahkan produk: ${response.statusCode}';
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: e.toString(),
        btnOkOnPress: () {},
      ).show();
    }
  }
}
