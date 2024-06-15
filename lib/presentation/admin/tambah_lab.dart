import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/daftar_laboratory.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class TambahLab extends StatefulWidget {
  const TambahLab({super.key});

  @override
  State<TambahLab> createState() => _TambahActivtyState();
}

class _TambahActivtyState extends State<TambahLab> {
  String? imagePath;
  File? image;
  var valLab = 'magics'; // Initialize with a default value
  // var judulController = TextEditingController();
  var contentController = TextEditingController();

  Future<void> getImage() async {
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

  Future<void> tambahLabPost() async {
    String? imgUrl;
    if (image != null) {
      imgUrl = await uploadFileToCDN(image!);
    }

    try {
      var response = await postData(DateTime.now().toIso8601String(), valLab,
          contentController.text, imgUrl);
      if (response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: 'Laboratory added successfully!',
          btnOkOnPress: () {},
        ).show();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DaftarLaboratory()),
        );
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'Error',
          desc: 'Failed to add laboratory: ${response.body}',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Exception',
        desc: 'An error occurred: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
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
                  MaterialPageRoute(
                      builder: (context) => const ActivityFrame()),
                );
              },
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(38), // Image radius
                  child: Image.asset('assets/ftprofil.png', fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Hello, Ivan'))
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Tambah Laboratory',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                child: const Text(
                  'Form yang di unggah akan di tampilkan di halaman Laboratory',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.1))
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Form Unggah Halaman Laboratory",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const Column(
                  children: [
                    Divider(
                      color: Color.fromARGB(255, 219, 219, 219),
                      height: 15,
                      thickness: 2,
                      indent: 0.2,
                      endIndent: 0.2,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Jenis Laboratory",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.only(left: 10),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.3),
                            width: 2.0,
                          ),
                        ),
                        child: DropdownButton(
                            value: valLab,
                            isExpanded: true,
                            isDense: true,
                            // style: TextStyle(fontSize: 16),
                            items: const [
                              DropdownMenuItem(
                                value: 'magics',
                                child: Text('MAGICS Laboratory'),
                              ),
                              DropdownMenuItem(
                                value: 'sea',
                                child: Text('SEA Laboratory'),
                              ),
                              DropdownMenuItem(
                                value: 'rnest',
                                child: Text('RnEST'),
                              ),
                              DropdownMenuItem(
                                value: 'ismile',
                                child: Text('i-SMILE'),
                              ),
                              DropdownMenuItem(
                                value: 'security',
                                child: Text('Security'),
                              ),
                              DropdownMenuItem(
                                value: 'evconn',
                                child: Text('Evconn'),
                              ),
                            ],
                            onChanged: (val) {
                              setState(() {
                                // valLab = val.toString();
                                valLab = val!;
                              });
                            })),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(
                    //   height: 5,
                    //   width: 5,
                    // ),
                    // Tambahkan widget Image.file untuk menampilkan gambar yang dipilih
                    // if (imagePath != null)
                    //   Padding(
                    //     padding: const EdgeInsets.only(top: 10, bottom: 10),
                    //     child: Image.file(
                    //       File(imagePath!),
                    //       width: 250,
                    //       height: 400,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    Container(
                      height: 250,
                      width: 400,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image!,
                                width:
                                    400, // Lebar gambar diatur agar mengisi keseluruhan kontainer
                                height:
                                    250, // Tinggi gambar diatur agar mengisi keseluruhan kontainer
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.black,
                            ),
                    ),
                    const Text(
                      "Upload Foto",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            height: 20,
                            width: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  "choose file",
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                            await getImage();
                            setState(() {
                              imagePath = image?.path;
                            });
                          },
                        ),
                        if (image == null)
                          Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: const Text(
                                'no file chosen',
                                style: TextStyle(fontSize: 11),
                              ))
                      ],
                    ),
                    const Column(
                      children: [
                        Text(
                          'ukuran file foto max 5 mb ( jpg atau png)',
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    const Text(
                      "Deskripsi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.only(left: 10),
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.3),
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: contentController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 1, 122, 5),
                          ),
                          onPressed: tambahLabPost,
                          child: const Text('Tambah')),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<Response> postData(
    String postDate, String lab, String content, String? imgUrl) async {
  try {
    Map<String, String> params = {
      'post_date': DateTime.now().toIso8601String(),
      'lab': lab,
      'content': content,
      if (imgUrl != null) 'img_url': imgUrl,
    };

    var response = await http.post(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/lab_post',
          queryParameters: params,
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
        });

    return response;
  } catch (e) {
    throw Exception('Failed to load: $e');
  }
}
