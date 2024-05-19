import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/shop/menu_shop_metode_pembayaran.dart';
import 'package:hmtk_app/presentation/user/shop/menu_shop_pesanan_berhasil.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/template_page.dart';
import 'package:http/http.dart';

import '../../../utils/color_pallete.dart';

class MenuShopMycart extends StatefulWidget {
  const MenuShopMycart({super.key});

  @override
  State<MenuShopMycart> createState() => _MenuShopMycartState();
}

class _MenuShopMycartState extends State<MenuShopMycart> {
  int jumlah = 1;
  List<String> ukurans = ['S', 'M', 'L', 'XL', 'XXL'];
  String valueUkuran = 'M';

  FutureResult<List<Map<String, dynamic>>>? futureResult;
  // List<Map<String, dynamic>>? data;

  Future<List<Map<String, dynamic>>> getStudentCarts() async {
    try {
      var auth = await SaveData.getAuth();

      var response = await get(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/student/${auth["user"]["nim"]}/cart',
          ),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          return List<Map<String, dynamic>>.from(data["carts"]);
        } else {
          throw data["message"];
        }
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<void> deleteCart(int cartId) async {
    try {
      var auth = await SaveData.getAuth();

      var response = await delete(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/student/${auth["user"]["nim"]}/cart/$cartId',
          ),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Berhasil menghapus barang di cart!',
            btnOkOnPress: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MenuShopMycart()));
            },
          ).show();
        } else {
          throw data["message"];
        }
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  Future<void> fetchStudentCarts() async {
    setState(() {
      futureResult = FutureResult.loading();
    });

    try {
      final data = await getStudentCarts();
      setState(() {
        futureResult = FutureResult.success(data);
      });
    } catch (e) {
      setState(() {
        futureResult = FutureResult.error(e.toString());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStudentCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: MyPage(
          widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (futureResult == null ||
              futureResult!.status == FutureStatus.loading)
            const Text("Loading..."),
          if (futureResult?.status == FutureStatus.error)
            Text('Error: ${futureResult?.errorMessage}'),
          if (futureResult?.status == FutureStatus.success &&
              futureResult?.data != null)
            ListView.builder(
                itemCount: futureResult!.data!.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  final carts = futureResult!.data!;

                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Image.network(
                                // 'assets/jersey pemain detail.png',
                                carts[index]["product"]["img_url"],
                                width: 70,
                                height: 70,
                                fit: BoxFit.contain),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // 'Jersey Pemain',
                                  carts[index]["product"]["name"],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Harga: Rp${formatNumber(carts[index]["product"]["price"])}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Jumlah: ${carts[index]["quantity"]}   Size: ${carts[index]["size"].toUpperCase()}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 4, bottom: 2, right: 4, top: 2),
                                  decoration: BoxDecoration(
                                      color: ColorPallete.blue,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Total: Rp${formatNumber(carts[index]["product"]["price"] * carts[index]["quantity"])}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         CircleAvatar(
                                //           child: IconButton(
                                //               onPressed: () {
                                //                 if (jumlah > 1) {
                                //                   setState(() {
                                //                     jumlah--;
                                //                   });
                                //                 }
                                //               },
                                //               icon: const Icon(
                                //                 Icons.remove,
                                //                 size: 20,
                                //               )),
                                //         ),
                                //         Padding(
                                //           padding: const EdgeInsets.only(
                                //               left: 10, right: 10),
                                //           child: Text(
                                //             '$jumlah',
                                //             style: const TextStyle(
                                //                 fontSize: 20,
                                //                 color: Colors.blue),
                                //           ),
                                //         ),
                                //         CircleAvatar(
                                //           child: IconButton(
                                //               onPressed: () {
                                //                 if (jumlah < 30) {
                                //                   setState(() {
                                //                     jumlah++;
                                //                   });
                                //                 }
                                //               },
                                //               icon: const Icon(
                                //                 Icons.add,
                                //                 size: 20,
                                //               )),
                                //         ),
                                //       ],
                                //     ),
                                //     const SizedBox(
                                //       width: 10,
                                //     ),
                                //     DropdownButton(
                                //       value: valueUkuran,
                                //       focusColor: Colors.blue,
                                //       style: const TextStyle(
                                //           color: Colors.blue, fontSize: 18),
                                //       iconEnabledColor: Colors.blue,
                                //       onChanged: (value) {
                                //         setState(() {
                                //           valueUkuran = value!;
                                //         });
                                //       },
                                //       items: ukurans
                                //           .map((e) => DropdownMenuItem(
                                //                 value: e,
                                //                 child: Text(
                                //                   e,
                                //                 ),
                                //               ))
                                //           .toList(),
                                //     ),
                                //   ],
                                // ),
                              ],
                            )
                          ],
                        ),
                        Positioned(
                          right: 0,
                          top: 22,
                          child: IconButton(
                              onPressed: () {
                                deleteCart(carts[index]["id"]).then((_) {
                                  setState(() {});
                                });
                              },
                              icon:
                                  const Icon(Icons.delete, color: Colors.red)),
                        )
                      ],
                    ),
                  );
                }),
        ],
      )),
      bottomNavigationBar: InkWell(
        onTap: () {
          showModalBottomSheet<dynamic>(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(35))),
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.45,
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Checkout',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel))
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(35))),
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Pilih metode pembayaran',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.cancel))
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MenuShopMetodePembayaran(
                                                metode: 'transfer'),
                                      ));
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Transfer',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MenuShopMetodePembayaran(
                                                metode: 'dana'),
                                      ));
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'DANA',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MenuShopMetodePembayaran(
                                                metode: 'shopee'),
                                      ));
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Shopee',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MenuShopMetodePembayaran(
                                                metode: 'cod'),
                                      ));
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Cash On Delivery (COD)',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pembayaran',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset('assets/card.png'),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Biaya Admin',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Rp. 5.000',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Total Pembayaran',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (futureResult == null ||
                                futureResult!.status == FutureStatus.loading)
                              const Text("Loading...")
                            else if (futureResult?.status == FutureStatus.error)
                              Text('Error: ${futureResult?.errorMessage}')
                            else if (futureResult?.status ==
                                    FutureStatus.success &&
                                futureResult?.data != null)
                              Text(
                                'Rp${formatNumber(futureResult!.data!.map<int>((cart) => cart['quantity'] * cart['product']['price']).reduce((a, b) => a + b) + 5000)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            else
                              Container()
                          ],
                        ),
                      )
                    ],
                  ),
                  const Text(
                    'By placing an order you agree to our\nTerms And Conditions',
                    style: TextStyle(fontSize: 12, color: Colors.green),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MenuShopPesananBerhasil(),
                            ));
                      },
                      child: const MyButton(
                        txt: 'BAYAR SEKARANG',
                        width: 200,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Total Pembayaran',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 40,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorPallete.blue),
                child: futureResult == null ||
                        futureResult!.status == FutureStatus.loading
                    ? const Text("Loading...")
                    : futureResult?.status == FutureStatus.error
                        ? Text('Error: ${futureResult?.errorMessage}')
                        : futureResult?.status == FutureStatus.success &&
                                futureResult?.data != null
                            ? Text(
                                'Rp${formatNumber(futureResult!.data!.map<int>((cart) => cart['quantity'] * cart['product']['price']).reduce((a, b) => a + b))}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
