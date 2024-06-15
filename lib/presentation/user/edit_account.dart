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
  var telController = TextEditingController();
  var addressController = TextEditingController();

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);

    if (imagePicked == null) {
      return;
    }

    final File imageFile = File(imagePicked.path);
    double fileSizeMb = await imageFile.length() / (1024 * 1024);

    if (fileSizeMb > 5) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed: Batas ukuran file 5MB',
        btnOkOnPress: () {},
      ).show();
    }

    setState(() {
      image = File(imagePicked.path);
    });
  }

  Future<http.Response> updateData(int nim, String fullName, String email,
      int noTelp, String address, String avatarUrl) async {
    try {
      String? imgUrl;
      if (image != null) {
        imgUrl = await uploadFileToCDN(image!);
      }

      Map<String, String> params = {
        'tel': noTelp.toString(),
        'address': address,
        if (image != null && imgUrl != null) 'avatar_url': imgUrl
      };

      await SaveData.saveAuth({
        'user_type': 'mahasiswa',
        'user': {
          'nim': nim,
          'name': fullName,
          'email': email,
          'tel': noTelp,
          'avatar_url': imgUrl ?? avatarUrl,
          'address': address,
          'pass_hash': null
        }
      });

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

  void updateStudent(
      int nim, String name, String email, String avatarUrl) async {
    String address = addressController.text;
    int? tel;

    if (address.isEmpty) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Address tidak valid.',
        btnOkOnPress: () {},
      ).show();
    }

    if (telController.text.isNotEmpty &&
        int.tryParse(telController.text) != null) {
      tel = int.parse(telController.text);
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Nomor Telepon tidak valid.',
        btnOkOnPress: () {},
      ).show();
      return;
    }

    try {
      final response =
          await updateData(nim, name, email, tel, address, avatarUrl);

      if (response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Data disimpan!',
          btnOkOnPress: () {
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
      print(user["nim"].runtimeType);
      final String name = user['name'];
      final int nim = user['nim'];
      final int telp = user['tel'];
      final String address = user["address"];
      final String email = user["email"];
      final String avatarUrl = user["avatar_url"];

      telController.value = TextEditingValue(text: telp.toString());
      addressController.value = TextEditingValue(text: address);

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
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: image != null
                                ? Image(
                                    image: FileImage(image!),
                                    fit: BoxFit.cover,
                                    width: 76,
                                    height: 76,
                                  )
                                : Image.network(
                                    user["avatar_url"],
                                    fit: BoxFit.cover,
                                    width: 76,
                                    height: 76,
                                  ),
                          ),
                        ),
                        // Image.asset(
                        //   'assets/profile.png',
                        //   height: 100,
                        // ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 20,
                            child: IconButton(
                                onPressed: () {
                                  getImage();
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                )),
                          ),
                        )
                      ],
                    ),
                    // Text(
                    //   name,
                    //   style: const TextStyle(
                    //       fontSize: 30,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    // ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          getFirstString(user["name"]),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                // const Text(
                //   'Full Name',
                //   style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // TextFormField(
                //   inputFormatters: [LengthLimitingTextInputFormatter(15)],
                //   controller: nameController,
                //   decoration: InputDecoration(
                //       filled: true,
                //       hintText: name,
                //       fillColor: Colors.white,
                //       border: InputBorder.none),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
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
                      hintText: telp.toString(),
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Address',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: address,
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
                          updateStudent(nim, name, email, avatarUrl);
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
