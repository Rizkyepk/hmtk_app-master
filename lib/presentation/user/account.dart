import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/reset_password.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'drawer/drawer_user.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

//tampulan awal account
class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: SaveData.getAuth(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // or any other loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final user = snapshot.data!["user"];
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
          }
        });
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
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              )),
                        ),
                      )
                    ],
                  ),
                  const Text(
                    'Ivan Daniar',
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
                decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Ivan Daniar',
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
                decoration: const InputDecoration(
                    filled: true,
                    hintText: '10070806',
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
                decoration: const InputDecoration(
                    filled: true,
                    hintText: '0896756747',
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
                decoration: const InputDecoration(
                    filled: true,
                    hintText: 'lulustepat@gmail.com',
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
                      child: const Text('Simpan'),
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
  }
}

Future<Response> fetchStudentData(int nim) async {
  try {
    var response = await get(
      Uri(
        scheme: 'https',
        host: 'myhmtk.jeyy.xyz',
        path: '/student/$nim',
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
      },
    );

    return response;
  } catch (e) {
    throw Exception('Failed to load: $e');
  }
}
