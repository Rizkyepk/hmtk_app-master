import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/account.dart';
import 'package:hmtk_app/presentation/user/drawer/drawer_user.dart';
import 'package:hmtk_app/utils/snapping_data.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  File? image;
  var nameController = TextEditingController();
  // final TextEditingController _nimController = TextEditingController();
  var telController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    // setState(() {});
  }

  Future<http.Response> updateData(
      String fullName, int nim, int noTelp, String email, String? pass) async {
    try {
      // Konversi nilai noTelp menjadi integer
      // int? tel = int.tryParse(noTelp);

      Map<String, String> params = {
        // 'nim': nim,
        'name': fullName,
        'tel': noTelp.toString(),
        'email': email,
        if (pass != null) 'password': pass,
      };

      await SaveData.saveAuth({
        'user_type': 'mahasiswa',
        'user': {
          'nim': nim,
          'name': fullName,
          'email': email,
          'tel': noTelp,
          'pass_hash': null
        }
      });

// Encode body request sebagai JSON
      // String jsonBody = jsonEncode(params);

      var response = await http.put(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/student/$nim',
          queryParameters: params,
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          // HttpHeaders.contentTypeHeader: 'application/json',
        },
        // body: jsonBody,
      );

      return response;
    } catch (e) {
      throw Exception('Failed to load: $e');
    }
  }

  void updateStudent(nim) async {
    // Ambil nilai dari text controllers
    String name = nameController.text;
    int? tel;

    // Periksa apakah nilai yang dimasukkan ke telController adalah angka yang valid
    if (telController.text.isNotEmpty &&
        int.tryParse(telController.text) != null) {
      tel = int.parse(telController.text);
    } else {
      // Tangani jika nilai yang dimasukkan bukan angka yang valid
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Nomor Telepon tidak valid.',
        btnOkOnPress: () {},
      ).show();
      return; // Keluar dari metode jika nilai tidak valid
    }

    String email = emailController.text;
    String? pass = passController.text.isEmpty ? null : passController.text;
    // print("PASS: $pass");

    // Cetak data yang akan diinputkan berserta tipe datanya
    // print('Name: $name (${name.runtimeType})');
    // print('Tel: $tel (${tel.runtimeType})');
    // print('Email: $email (${email.runtimeType})');
    // print('Password: $pass (${pass.runtimeType})');

    try {
      // Panggil metode updateData untuk melakukan pembaruan ke server
      final response = await updateData(name, nim, tel, email, pass);

      if (response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Data disimpan!',
          btnOkOnPress: () {
            // Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Account()));
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Gagal menyimpan',
          desc: response.body,
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Gagal menyimpan data: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return snap((user) {
      final name = user['name'] ?? 'N/A';
      int nim = user['nim'];
      final telp = user['tel'].toString();
      final email = user['email'] ?? 'N/A';

      nameController.value = TextEditingValue(text: name);
      telController.value = TextEditingValue(text: telp);
      emailController.value = TextEditingValue(text: email);

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
                    Text(
                      name,
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
                  controller: nameController,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: name,
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                // const Text(
                //   'NIM',
                //   style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // TextFormField(
                //   controller: _nimController,
                //   decoration: InputDecoration(
                //       filled: true,
                //       hintText: nim,
                //       fillColor: Colors.white,
                //       border: InputBorder.none),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
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
                  controller: telController,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: telp,
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
                  controller: emailController,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: email,
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Password',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passController,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: '******',
                      fillColor: Colors.white,
                      border: InputBorder.none),
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
                          updateStudent(nim);
                        },
                        child: const Text('Simpan'),
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
