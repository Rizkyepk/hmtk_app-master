import 'dart:io';
import 'package:hmtk_app/utils/snapping_data.dart';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/aspiration/menu_riwayat_aspirasi.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/template_page.dart';
import 'package:http/http.dart';

import '../drawer/drawer_user.dart';

class MenuAspiration extends StatefulWidget {
  const MenuAspiration({super.key});

  @override
  State<MenuAspiration> createState() => _MenuAspirationState();
}

class _MenuAspirationState extends State<MenuAspiration> {
  var judulController = TextEditingController();
  var isiController = TextEditingController();

  Future<void> uploadData(String nim) async {
    // int nim;
    String title = judulController.text;
    String content = isiController.text;

    // print('nim: $nim, type: ${nim.runtimeType}');
    // print('title: $title, type: ${title.runtimeType}');
    // print('content: $content, type: ${content.runtimeType}');

    try {
      var response = await postData(nim, title, content);

      if (response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Success!',
          desc: 'Thank you for you aspiration',
          btnOkOnPress: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MenuAspiration(),
                ),
                (route) => false);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Failed',
          desc: 'Gagal menambahkan aspiration',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed',
        desc: 'Gagal menambahkan: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return snap((user) {
      final nim = user['nim'].toString();

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
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 5))
                  ]),
                  child: const MyButton(
                    txt: 'Input Aspirasi',
                    width: 150,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MenuRiwayatAspirasi(),
                        ));
                  },
                  child: const MyButton(
                    txt: 'Riwayat Aspirasi',
                    width: 150,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            const Text(
              'Input Response',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                    flex: 1,
                    child: Text(
                      'Judul',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: judulController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        maxLines: 1,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                    flex: 1,
                    child: Text(
                      'Isi Tanggapan',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: isiController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        maxLines: 5,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
              child: InkWell(
                onTap: () => uploadData(nim),
                child: const MyButton(txt: 'Kirim', height: 40),
              ),
            )
          ],
        )),
      );
    });
  }
}

Future<Response> postData(String nim, String title, String content) async {
  try {
    Map<String, dynamic> params = {
      'mahasiswa_nim': nim,
      'title': title,
      'content': content,
    };

    var response = await http.post(
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
