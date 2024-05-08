import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/daftar_aktivity.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:image_picker/image_picker.dart';

class TambahActivty extends StatefulWidget {
  const TambahActivty({super.key});

  @override
  State<TambahActivty> createState() => _TambahActivtyState();
}

File? image;
Future getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? imagePicked =
      await picker.pickImage(source: ImageSource.gallery);
  image = File(imagePicked!.path);
  // setState(() {});
}

class _TambahActivtyState extends State<TambahActivty> {
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
                  MaterialPageRoute(builder: (context) => const ActivityFrame()),
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
                padding: const EdgeInsets.all(8.0), child: const Text('Hello, Ivan'))
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text(
                      'Tambah Activity',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                  child: const Text(
                    'form yang di ungggah akan tampil di halaman activity',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
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
                  "Form Unggah Halaman Activity",
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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Judul Aktivity",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.only(left: 10),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color:
                                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                            width: 2.0,
                          ),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      const Text(
                        "Uploud Foto",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            child: Container(
                              height: 20,
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    "choose file",
                                    style: TextStyle(fontSize: 11),
                                  )
                                ],
                              ),
                            ),
                            onTap: () async {
                              await getImage();
                            },
                          ),
                          Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: const Text(
                                'no file chosen',
                                style: TextStyle(fontSize: 11),
                              ))
                        ],
                      ),
                      Container(
                        child: const Column(
                          children: [
                            Text(
                              'ukuran file foto max 5 mb ( jpg atau png)',
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      const Text(
                        "Deskripsi Informasi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.only(left: 10),
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color:
                                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                            width: 2.0,
                          ),
                        ),
                        child: const TextField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      const Text(
                        "Link Lokasi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.only(left: 10),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color:
                                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                            width: 2.0,
                          ),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 1, 122, 5),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                // DetailPage adalah halaman yang dituju
                                MaterialPageRoute(
                                    builder: (context) => const DaftarAktivity()),
                              );
                            },
                            child: const Text('Tambah')),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
