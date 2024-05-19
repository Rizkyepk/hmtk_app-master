import 'dart:io';

// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/reset_password.dart';
import 'package:hmtk_app/utils/snapping_data.dart';
import 'package:hmtk_app/utils/utils.dart';
// import 'package:http/http.dart';
// import 'package:image_picker/image_picker.dart';

import 'drawer/drawer_user.dart';
import 'edit_account.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

//tampulan awal account
class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return snap((user) {
      final nim = user['nim'].toString(); // Konversi nim ke string
      final tel = user['tel'].toString(); // Konversi tel ke string

      return Scaffold(
        drawer: const Drawer(
          width: 200,
          backgroundColor: Colors.transparent,
          child: DrawerUserScren(),
        ),
        appBar: AppBar(
          elevation: 0,
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/bg.png',
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            ListView(
              padding: const EdgeInsets.all(25),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Account',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          'assets/profile.png',
                          height: 100,
                        ),
                      ],
                    ),
                    Text(
                      user['name'],
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Full Name',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: user['name'],
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'NIM',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: nim,
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'No Telp',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: tel,
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: user['email'],
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditAccount(),
                            ),
                          );
                        },
                        child: const Text('Edit account'),
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.red,
                        //     minimumSize: Size(100, 40)),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPassword(),
                            ),
                          );
                        },
                        child: const Text('Reset password'),
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.red,
                        //     minimumSize: Size(100, 40)),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
        

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<Map<String, dynamic>>(
  //       future: SaveData.getAuth(),
  //       builder: (BuildContext context,
  //           AsyncSnapshot<Map<String, dynamic>> snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const CircularProgressIndicator();
  //         } else if (snapshot.hasError) {
  //           return Text('Error: ${snapshot.error}');
  //         } else {
  //           final user = snapshot.data!["user"];
  //           return buildAccountWidget(user);
  //         }
  //       });
  // }
// }
