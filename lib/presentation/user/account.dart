import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/reset_password.dart';
import 'package:hmtk_app/presentation/user/signin.dart';
import 'package:hmtk_app/presentation/user/start.dart';
import 'package:image_picker/image_picker.dart';

import 'drawer/drawer_user.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
      body: Stack(
        children: [
          Image.asset(
            'assets/bg.png',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Container(
            child: ListView(
              padding: EdgeInsets.all(25),
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
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
                        // Positioned(
                        //   bottom: 0,
                        //   right: 0,
                        //   child: CircleAvatar(
                        //     backgroundColor: Colors.grey[200],
                        //     radius: 20,
                        //     child: IconButton(
                        //         onPressed: () async {
                        //           await getImage();
                        //         },
                        //         icon: Icon(
                        //           Icons.edit,
                        //           color: Colors.black,
                        //         )),
                        //   ),
                        // )
                      ],
                    ),
                    Text(
                      'Ivan Daniar',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Full Name',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Ivan Daniar',
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'NIM',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: '10070806',
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No Telp',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: '0896756747',
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'lulustepat@gmail.com',
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 10,
                ),
                // Text(
                //   'Password',
                //   style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // TextFormField(
                //   readOnly: true,
                //   decoration: InputDecoration(
                //       filled: true,
                //       hintText: '*********',
                //       fillColor: Colors.white,
                //       border: InputBorder.none),
                // ),
                SizedBox(
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
                              builder: (context) => EditAccount(),
                            ),
                          );
                        },
                        child: Text('Edit account'),
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
                              builder: (context) => ResetPassword(),
                            ),
                          );
                        },
                        child: Text('Reset password'),
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.red,
                        //     minimumSize: Size(100, 40)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  File? image;
  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    // setState(() {});
  }

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
      body: Stack(
        children: [
          Image.asset(
            'assets/bg.png',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Container(
            child: ListView(
              padding: EdgeInsets.all(25),
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Edit Account',
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
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 20,
                            child: IconButton(
                                onPressed: () async {
                                  await getImage();
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                )),
                          ),
                        )
                      ],
                    ),
                    Text(
                      'Ivan Daniar',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Full Name',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Ivan Daniar',
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'NIM',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      hintText: '10070806',
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No Telp',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      hintText: '0896756747',
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'lulustepat@gmail.com',
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'Data disimpan!',
                            btnOkOnPress: () {
                              Navigator.pop(context);
                            },
                          ).show();
                        },
                        child: Text('Simpan'),
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.red,
                        //     minimumSize: Size(100, 40)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}