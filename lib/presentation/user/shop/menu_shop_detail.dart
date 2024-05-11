import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/template_page.dart';
import 'package:http/http.dart' as http;

class MenuShopDetail extends StatefulWidget {
  // final String title, harga, gambar;
  final int productId;

  const MenuShopDetail({super.key, required this.productId});

  @override
  State<MenuShopDetail> createState() => _MenuShopDetailState();
}

class _MenuShopDetailState extends State<MenuShopDetail> {
  int jumlah = 1;
  Map<String, dynamic>? data;

  List<String> ukurans = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'];
  String valueUkuran = 'S';

  Future<Map<String, dynamic>> _product(int productId) async {
    try {
      final response = await fetchProduct(productId);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final bool success = data["success"];
        if (!success) {
          throw Exception("Not success");
        }

        return Map<String, dynamic>.from(data["product"]);
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw Exception("error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyPage(
          widget: ListView(
        children: [
          Stack(
            children: [
              Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ))),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
          FutureBuilder(
            future: _product(widget.productId),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting && data == null) {
                return const Text('Loading data...');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final product = snapshot.data!;
                data = product;
                return Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 130,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 150,
                              ),
                              Text(
                                product["name"],
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Jumlah',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.green),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                child: IconButton(
                                                    onPressed: () {
                                                      if (jumlah > 1) {
                                                        setState(() {
                                                          jumlah--;
                                                        });
                                                      }
                                                    },
                                                    icon: const Icon(
                                                        Icons.remove)),
                                              ),
                                              Text(
                                                '$jumlah',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blue),
                                              ),
                                              CircleAvatar(
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        jumlah++;
                                                      });
                                                    },
                                                    icon:
                                                        const Icon(Icons.add)),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Ukuran',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.green),
                                          ),
                                          DropdownButton(
                                            value: valueUkuran,
                                            focusColor: Colors.blue,
                                            style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 18),
                                            iconEnabledColor: Colors.blue,
                                            onChanged: (value) {
                                              setState(() {
                                                valueUkuran = value!;
                                              });
                                            },
                                            items: ukurans
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(
                                                        e,
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Harga',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.green),
                                          ),
                                          Text(
                                            'Rp. ${product["price"]}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Info Tambahan',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Berikan informasi Tambahan Anda Di Sini',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.green),
                              ),
                              Container(
                                height: 150,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                color: Colors.grey.shade300,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Deskripsi',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                product["description"],
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.green),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.rightSlide,
                                    title: 'Berhasil menambahkan data',
                                    btnOkOnPress: () {},
                                  ).show();
                                },
                                child: const MyButton(
                                  txt: 'Add to Cart',
                                  width: double.maxFinite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                            height: 260,
                            width: 260,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  product["img_url"],
                                  fit: BoxFit.contain,
                                ))))
                  ],
                );
              }
            },
          )
        ],
      )),
    );
  }
}

Future<http.Response> fetchProduct(int productId) async {
  try {
    var response = await http.get(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/product/$productId',
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer myhmtk-app-key',
        });

    return response;
  } catch (e) {
    throw Exception('Failed to load: $e');
  }
}
