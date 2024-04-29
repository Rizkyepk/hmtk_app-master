import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/aspiration/menu_aspiration.dart';
import 'package:hmtk_app/presentation/user/home.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/main_navigator.dart';
import 'package:hmtk_app/widget/template_page.dart';

import '../drawer/drawer_user.dart';

class MenuRiwayatAspirasi extends StatelessWidget {
  const MenuRiwayatAspirasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerUserScren(),
      ),
      appBar: AppBar(
        elevation: 0,
      ),
      body: MyPage(
          widget: ListView(
        padding: EdgeInsets.all(25),
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuAspiration(),
                      ));
                },
                child: MyButton(
                  txt: 'Input Aspirasi',
                  width: 150,
                ),
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 5))
                ]),
                child: MyButton(
                  txt: 'Riwayat Aspirasi',
                  width: 150,
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Table(
              columnWidths: {
                0: FixedColumnWidth(20),
                1: FixedColumnWidth(80),
                2: FixedColumnWidth(80),
                3: FixedColumnWidth(80),
              },
              border: TableBorder.symmetric(
                  outside: BorderSide.none, inside: BorderSide()),
              children: [
                TableRow(children: [
                  Text('No',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Tanggal',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Judul',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Isi',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ]),
                TableRow(children: [
                  Text('1',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('10/10/22',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Halaman shop',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Tidak bisa mengakses halaman shop',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ]),
                TableRow(children: [
                  Text('2',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('27/10/22',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Halaman checkout',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Kesulitan dalam mengakses aplikasi checkout',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ])
              ],
            ),
          ),
        ],
      )),
    );
  }
}
