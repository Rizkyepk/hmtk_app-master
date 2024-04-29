import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:image_picker/image_picker.dart';

class AccountEdit extends StatelessWidget {
  const AccountEdit({super.key});

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
                      'Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
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
                  color: Colors.black.withOpacity(0.2))
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Profile",
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
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Text(
                        "Nama",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(3),
                        height: 30,
                        width: 330,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                            width: 2.0,
                          ),
                        ),
                        child: Text('Ivan Daniar'),
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(3),
                        height: 30,
                        width: 330,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                            width: 2.0,
                          ),
                        ),
                        child: Text('lulustepatwaktu@gmail.com '),
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.2))
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Edit Profilee ",
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
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Text(
                        "Nama",
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
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Text(
                        "Email",
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
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Text(
                        "Password",
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
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Text(
                        "Confitm Password",
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
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 1, 122, 5),
                            ),
                            onPressed: () {},
                            child: Text('Simpan')),
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
