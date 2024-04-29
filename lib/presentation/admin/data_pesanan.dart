import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;

class DataPesanan extends StatelessWidget {
  const DataPesanan({super.key});

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
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text(
              "Data Pemesanan",
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
                            'Nama',
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
                            'Nim',
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
