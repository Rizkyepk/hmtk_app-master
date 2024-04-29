import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/daftar_laboratory.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:image_picker/image_picker.dart';

class TambahLab extends StatefulWidget {
  const TambahLab({super.key});

  @override
  State<TambahLab> createState() => _TambahActivtyState();
}

File? image;
Future getImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? imagePicked =
      await _picker.pickImage(source: ImageSource.gallery);
  image = File(imagePicked!.path);
}

class _TambahActivtyState extends State<TambahLab> {
  var valLab = 'MAGICS Laboratory';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerScren(),
      ),
      appBar: AppBar(
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
                  MaterialPageRoute(builder: (context) => ActivityFrame()),
                );
              },
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(38), // Image radius
                  child: Image.asset('assets/ftprofil.png', fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(8.0), child: Text('Hello, Ivan'))
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
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text(
                      'Tambah Laboratory',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
                  child: Text(
                    'Form yang di unggah akan di tampilkan di halaman Laboratory',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.1))
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Form Unggah Halaman Laboratory",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Column(
                  children: [
                    const Divider(
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
                      Text(
                        "Jenis Laboratory",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(left: 10),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                              color:
                                  Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                              width: 2.0,
                            ),
                          ),
                          child: DropdownButton(
                              value: valLab,
                              isExpanded: true,
                              isDense: true,
                              // style: TextStyle(fontSize: 16),
                              items: [
                                DropdownMenuItem(
                                  child: Text('MAGICS Laboratory'),
                                  value: 'MAGICS Laboratory',
                                ),
                                DropdownMenuItem(
                                  child: Text('SEA Laboratory'),
                                  value: 'SEA Laboratory',
                                ),
                                DropdownMenuItem(
                                  child: Text('RnEST Laboratory'),
                                  value: 'RnEST Laboratory',
                                ),
                                DropdownMenuItem(
                                  child: Text('i-SMILE Laboratory'),
                                  value: 'i-SMILE Laboratory',
                                ),
                                DropdownMenuItem(
                                  child: Text('Security Laboratory'),
                                  value: 'Security Laboratory',
                                ),
                                DropdownMenuItem(
                                  child: Text('Evconn Laboratory'),
                                  value: 'Evconn Laboratory',
                                ),
                              ],
                              onChanged: (val) {
                                setState(() {
                                  valLab = val.toString();
                                });
                              })),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Judul Laboratory",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 10),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                            width: 2.0,
                          ),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Text(
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
                              child: Column(
                                children: [
                                  Text(
                                    "choose file",
                                    style: TextStyle(fontSize: 11),
                                  )
                                ],
                              ),

                              // margin: EdgeInsets.only(bottom: 10),
                              // padding: EdgeInsets.only(left: 10),
                              height: 20,
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onTap: () async {
                              await getImage();
                            },
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(
                                'no file chosen',
                                style: TextStyle(fontSize: 11),
                              ))
                        ],
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              'ukuran file foto max 5 mb ( jpg atau png)',
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Text(
                        "Deskripsi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 10),
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                            width: 2.0,
                          ),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 1, 122, 5),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                // DetailPage adalah halaman yang dituju
                                MaterialPageRoute(
                                    builder: (context) => DaftarLaboratory()),
                              );
                            },
                            child: Text('Tambah')),
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
