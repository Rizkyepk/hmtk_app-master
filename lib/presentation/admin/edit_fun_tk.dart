import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:hmtk_app/presentation/admin/daftar_funtk.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
// import 'package:hmtk_app/presentation/admin/daftar_funtk.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class EditFunTk extends StatefulWidget {
  final Map<String, dynamic> fun_tk;
  const EditFunTk({super.key, required this.fun_tk});

  @override
  State<EditFunTk> createState() => _EditFunTkState();
}

class _EditFunTkState extends State<EditFunTk> {
  String? imagePath;
  File? image;

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

  Future<void> _uploadDataFun(int id) async {
    String title = titleController.text;
    String content = contentController.text;
    String date = dateController.text;
    String time = timeController.text;
    String location = locationController.text;
    String map = mapController.text;
    String? imgUrl;
    if (image != null) {
      imgUrl = await uploadFileToCDN(image!);
    }

    try {
      var response = await postEditDataFunTK(
          id, title, content, date, time, location, map, imgUrl);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["success"]) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Success',
            desc: 'Fun TK successfully edited!',
            btnOkOnPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DaftarFuntk()),
              );
            },
          ).show();
        } else {
          throw data["message"];
        }
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Failed',
          desc: 'Failed to edit Fun TK. Please try again later.',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed',
        desc: 'Failed to edit Fun TK: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    contentController.text = widget.fun_tk["description"] ?? "";
    titleController.text = widget.fun_tk["title"] ?? "";
    timeController.text = widget.fun_tk["time"] ?? "";
    dateController.text = widget.fun_tk["date"] ?? "";
    locationController.text = widget.fun_tk["location"];
    mapController.text = widget.fun_tk["map_url"] ?? '-';

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
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const ActivityFrame()),
            //     );
            //   },
            //   child: ClipOval(
            //     child: SizedBox.fromSize(
            //       size: const Size.fromRadius(38), // Image radius
            //       child: Image.asset('assets/ftprofil.png', fit: BoxFit.cover),
            //     ),
            //   ),
            // ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Fun TK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ))
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
                    'Edit Fun TK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                child: const Text(
                  'Kosongkan jika tidak ingin mengubah data',
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
                  "Form Edit Halaman Fun TK",
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
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.3),
                          width: 2.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 16.0),
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
                          : widget.fun_tk["img_url"] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    widget.fun_tk["img_url"],
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
                      height: 40,
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
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
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
                      height: 40,
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
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
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
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.3),
                          width: 2.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: contentController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 16.0),
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
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.3),
                          width: 2.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 16.0),
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
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.3),
                          width: 2.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: mapController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 16.0),
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
                            _uploadDataFun(widget.fun_tk["id"]);
                          },
                          child: const Text('Edit',style: TextStyle(color: Colors.white),)),
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

  Future<Response> postEditDataFunTK(
      int funTkId,
      String title,
      String content,
      String date,
      String time,
      String location,
      String? map,
      String? imgUrl) async {
    try {
      Map<String, String> params = {
        'title': title,
        'description': content,
        'date': date,
        'time': time,
        'location': location,
        if (map != null) 'map_url': map,
        if (imgUrl != null) 'img_url': imgUrl,
      };

      var response = await http.put(
        Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/fun_tk/$funTkId',
            queryParameters: params),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
        },
        body: params,
      );

      return response;
    } catch (e) {
      throw Exception('Failed to load: $e');
    }
  }
}
