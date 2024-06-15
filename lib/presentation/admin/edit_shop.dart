import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/daftar_shop.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class EditShop extends StatefulWidget {
  final Map<String, dynamic> shop;
  const EditShop({super.key, required this.shop});

  @override
  State<EditShop> createState() => _TambahActivtyState();
}

class _TambahActivtyState extends State<EditShop> {
  String? imagePath;
  File? image;
  var nameController = TextEditingController();
  var priceController = TextEditingController();
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

    if (fileSizeMb > 10) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed: Batas ukuran file 10MB',
        btnOkOnPress: () {},
      ).show();
    }

    setState(() {
      image = File(imagePicked.path);
    });
  }

  Future<void> _uploadDataproduct(int id) async {
    String name = nameController.text;
    String content = contentController.text;
    String price = priceController.text;
    String? imgUrl;
    if (image != null) {
      imgUrl = await uploadFileToCDN(image!);
    }

    try {
      var response =
          await postEditDataProduct(id, name, content, price, imgUrl);

      if (response.statusCode == 200) {
        // Tampilkan dialog Awesome jika berhasil
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Success',
          desc: 'Activity successfully edited!',
          btnOkOnPress: () {
            // Navigasi ke halaman DaftarShop setelah menekan tombol OK
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DaftarShop()),
            );
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Failed',
          desc: 'Failed to edit activity. Please try again later.',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed',
        desc: 'Failed to edit activity: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    contentController.text = widget.shop["description"] ?? '';
    nameController.text = widget.shop["name"] ?? '';
    priceController.text = widget.shop["price"].toString();

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
                    'Edit Shop',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                child: const Text(
                  'Kosongkan jika tidak ingiin mengubah data',
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
                  "Form Edit Halaman Shop",
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
                        decoration: InputDecoration(
                          // hintText: widget.shop["name"],
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
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
                          : widget.shop["img_url"] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    widget.shop["img_url"],
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
                      "Uploud Foto",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await getImage();
                      },
                      child: Container(
                        height: 25,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Choose File",
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Ukuran file foto maksimum 10 MB (jpg atau png)',
                      style: TextStyle(fontSize: 11),
                    ),
                    const SizedBox(height: 10),
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
                        decoration: InputDecoration(
                          hintText: widget.shop["price"].toString(),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                        controller: contentController,
                        decoration: InputDecoration(
                          hintText: widget.shop["description"],
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
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
                            _uploadDataproduct(widget.shop['id']);
                            // Navigator.push(
                            //   context,
                            //   // DetailPage adalah halaman yang dituju
                            //   MaterialPageRoute(
                            //       builder: (context) => const DaftarShop()),
                            // );
                          },
                          child: const Text('Edit')),
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

  Future<Response> postEditDataProduct(int product_id, String name,
      String content, String price, String? imgUrl) async {
    try {
      Map<String, dynamic> params = {
        'name': name,
        'description': content,
        'price': price,
        if (imgUrl != null) 'img_url': imgUrl,
      };

      var response = await http.put(
        Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/product/$product_id',
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
