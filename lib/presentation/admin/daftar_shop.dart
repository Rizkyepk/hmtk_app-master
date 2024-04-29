import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/edit_shop.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;

class DaftarShop extends StatelessWidget {
  const DaftarShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
            ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(38), // Image radius
                child: Image.asset('assets/ftprofil.png', fit: BoxFit.cover),
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
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text(
              "Daftar Shop",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 2),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Nama Barang',
                            textAlign: TextAlign.center,
                          ),
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10))),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'File Foto',
                            textAlign: TextAlign.center,
                          ),
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Jumlah',
                            textAlign: TextAlign.center,
                          ),
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Ukuran',
                            textAlign: TextAlign.center,
                          ),
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Deskripsi',
                            textAlign: TextAlign.center,
                          ),
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          padding: EdgeInsets.all(3),
                          child: Column(
                            children: [
                              Text(
                                'Informasi',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Tambahan',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Harga',
                            textAlign: TextAlign.center,
                          ),
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Aksi',
                            textAlign: TextAlign.center,
                          ),
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: () {
                                    AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.question,
                                            animType: AnimType.rightSlide,
                                            title:
                                                'Yakin ingin menghapus data?',
                                            btnOkOnPress: () {},
                                            btnCancelOnPress: () {})
                                        .show();
                                  },
                                  child: Image(
                                      image: AssetImage('assets/Vector.png'))),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditShop(),
                                        ));
                                  },
                                  child: Image(
                                      image: AssetImage('assets/icon.png'))),
                            ],
                          ),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(0))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10))),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0))),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: () {
                                    AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.question,
                                            animType: AnimType.rightSlide,
                                            title:
                                                'Yakin ingin menghapus data?',
                                            btnOkOnPress: () {},
                                            btnCancelOnPress: () {})
                                        .show();
                                  },
                                  child: Image(
                                      image: AssetImage('assets/Vector.png'))),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditShop(),
                                        ));
                                  },
                                  child: Image(
                                      image: AssetImage('assets/icon.png'))),
                            ],
                          ),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
