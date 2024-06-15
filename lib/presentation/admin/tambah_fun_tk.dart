import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/daftar_funtk.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class TambahFunTk extends StatefulWidget {
  const TambahFunTk({super.key});

  @override
  State<TambahFunTk> createState() => _TambahActivtyState();
}

class _TambahActivtyState extends State<TambahFunTk> {
  String? imagePath;
  File? image;

  double? latitude;
  double? longitude;

  var contentController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var locationController = TextEditingController();
  var mapController = TextEditingController();
  var titleController = TextEditingController();

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

  Future<void> uploadData() async {
    String title = titleController.text;
    String content = contentController.text;
    String date = dateController.text;
    String time = timeController.text;
    String location = locationController.text;
    String map = mapController.text;

    if (title.isEmpty ||
        content.isEmpty ||
        date.isEmpty ||
        time.isEmpty ||
        location.isEmpty ||
        image == null) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Pastikan semua kolom terisi dengan benar!',
        btnOkOnPress: () {},
      ).show();
    }

    String imgUrl = await uploadFileToCDN(image!);

    try {
      var response = await postData(DateTime.now().toIso8601String(), title,
          content, date, location, time, map, imgUrl);

      if (response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Success',
          desc: 'Fun TK berhasil ditambahkan!',
          btnOkOnPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DaftarFuntk()),
            );
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Failed',
          desc: 'Gagal menambahkan Fun TK',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed',
        desc: 'Gagal menambahkan: $e',
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
                    'Tambah Fun TK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                child: const Text(
                  'Form yang di unggah akan di tampilkan di halaman Fun TK',
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
                  color: Colors.green.withOpacity(0.1))
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Form Unggah Halaman Fun TK",
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
                      "Judul",
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
                      child: TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    //tampil
                    Container(
                      height: 250,
                      width: 400,
                      margin: const EdgeInsets.all(10),
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
                      "Tanggal Pelaksanaan",
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
                      child: TextField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          hintText: 'YY-MM-DD',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 7),
                        ),
                        onTap: () {
                          showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          ).then((selectedDate) {
                            if (selectedDate != null) {
                              dateController.text =
                                  formatDate(selectedDate.toIso8601String());
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    const Text(
                      "Waktu Pelaksanaan",
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
                      child: TextField(
                          controller: timeController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime:
                                  TimeOfDay.fromDateTime(DateTime.now()),
                            ).then((selectedTime) {
                              if (selectedTime != null) {
                                timeController.text = formatTime(selectedTime);
                              }
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    const Text(
                      "Informasi",
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
                      child: TextField(
                        controller: contentController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    const Text(
                      "Lokasi",
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
                      child: TextField(
                        controller: locationController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const Text(
                      "Maps",
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
                      child: TextField(
                        controller: mapController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 1, 122, 5),
                          ),
                          onPressed: () {
                            uploadData();
                            // Navigator.push(
                            //   context,
                            //   // DetailPage adalah halaman yang dituju
                            //   MaterialPageRoute(
                            //       builder: (context) => const DaftarFuntk()),
                            // );
                          },
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
    String postDate,
    String title,
    String content,
    String date,
    String location,
    String time,
    String map,
    String imgUrl) async {
  try {
    Map<String, String> params = {
      'post_date': DateTime.now().toIso8601String(),
      'title': title,
      'description': content,
      'date': date,
      'time': time,
      'location': location,
      'map_url': map,
      'img_url': imgUrl,
    };

    var response = await http.post(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/fun_tk',
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
