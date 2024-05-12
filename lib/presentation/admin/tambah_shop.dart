import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/daftar_shop.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:image_picker/image_picker.dart';

class TambahShop extends StatefulWidget {
  const TambahShop({super.key});

  @override
  State<TambahShop> createState() => _TambahShopState();
}

class _TambahShopState extends State<TambahShop> {
  File? image;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  Future<void> _tambahProduct() async {
    final String inputName = nameController.text;
    final String inputPrice = priceController.text;
    final String inputDescription = descriptionController.text;

    final response = await fetchData(
      inputName,
      inputPrice,
      inputDescription,
    );
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool success = data['success'];
        if (success) {
          // Berhasil menambahkan produk, tambahkan logika lain di sini jika diperlukan
          final String message = data['message'];
          throw message;
          // print('Produk berhasil ditambahkan');
        } else {
          // Gagal menambahkan produk, mungkin ada pesan kesalahan dari server
          final String errorMessage = data['message'];
          throw errorMessage;
        }
      } else {
        // Response tidak berhasil (kode status bukan 200)
        throw 'Gagal menambahkan produk: ${response.statusCode}';
      }
    } catch (e) {
      // Terjadi kesalahan selama proses
      throw Exception("Error: $e");
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
        // title: const Text("GeeksforGeeks"),
        // titleSpacing: 00.0,
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
                    'Tambah Produk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                child: const Text(
                  'Form yang di unggah akan ditampilkan di halaman Shop',
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
                  "Form Unggah Halaman Shop",
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
                      "Nama Barang",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.only(left: 10),
                      height: 50,
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
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    const Text(
                      "Uploud Foto",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            height: 25,
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
                        //belum bisa masukin gambar
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
                    // const Text(
                    //   "Jumlah",
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 12,
                    //   ),
                    // ),
                    // Container(
                    //   margin: const EdgeInsets.only(bottom: 10),
                    //   padding: const EdgeInsets.only(left: 10),
                    //   height: 30,
                    //   decoration: BoxDecoration(
                    //     borderRadius:
                    //         const BorderRadius.all(Radius.circular(5.0)),
                    //     border: Border.all(
                    //       color: const Color.fromARGB(255, 0, 0, 0)
                    //           .withOpacity(0.3),
                    //       width: 2.0,
                    //     ),
                    //   ),
                    //   child: const TextField(
                    //     decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    const Text(
                      "Harga",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.only(left: 10),
                      height: 50,
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
                        controller: priceController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
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
                      height: 100,
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
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    // const Text(
                    //   "Info Tambahan",
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 12,
                    //   ),
                    // ),
                    // Container(
                    //   margin: const EdgeInsets.only(bottom: 10),
                    //   padding: const EdgeInsets.only(left: 10),
                    //   height: 30,
                    //   decoration: BoxDecoration(
                    //     borderRadius:
                    //         const BorderRadius.all(Radius.circular(5.0)),
                    //     border: Border.all(
                    //       color: const Color.fromARGB(255, 0, 0, 0)
                    //           .withOpacity(0.3),
                    //       width: 2.0,
                    //     ),
                    //   ),
                    //   child: const TextField(
                    //     decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 1, 122, 5),
                          ),
                          onPressed: () {
                            _tambahProduct();
                            Navigator.push(
                              context,
                              // DetailPage adalah halaman yang dituju
                              MaterialPageRoute(
                                  builder: (context) => const DaftarShop()),
                            );
                          },
                          child: const Text(
                            'Tambah',
                            style: TextStyle(color: Colors.white),
                          )),
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

  Future<http.Response> fetchData(
      String inputName, String inputPrice, String inputDescription) async {
    try {
      Map<String, String> params = {
        'name': inputName,
        'price': inputPrice,
        'description': inputDescription,
      };

      var response = await http.post(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/auth/login',
          queryParameters: params,
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer myhmtk-app-key',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Failed to load: $e');
    }
  }
}
