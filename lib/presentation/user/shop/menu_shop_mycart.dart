import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/shop/menu_shop_metode_pembayaran.dart';
import 'package:hmtk_app/presentation/user/shop/menu_shop_pesanan_berhasil.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/template_page.dart';

import '../../../utils/color_pallete.dart';

class MenuShopMycart extends StatefulWidget {
  const MenuShopMycart({super.key});

  @override
  State<MenuShopMycart> createState() => _MenuShopMycartState();
}

class _MenuShopMycartState extends State<MenuShopMycart> {
  int jumlah = 1;
  List<String> ukurans = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'];
  String valueUkuran = 'S';

  int jumlahBarang = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyPage(
          widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'My Cart',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          ListView.builder(
            itemCount: jumlahBarang,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/jersey pemain detail.png',
                        height: 70,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jersey Pemain',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Rp 150.000',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                          Icons.remove,
                                          size: 20,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      '$jumlah',
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.blue),
                                    ),
                                  ),
                                  CircleAvatar(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            jumlah++;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          size: 20,
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              DropdownButton(
                                value: valueUkuran,
                                focusColor: Colors.blue,
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 18),
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
                          ),
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            jumlahBarang--;
                          });
                        },
                        icon: const Icon(Icons.delete, color: Colors.red)),
                  )
                ],
              ),
            ),
          ),
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
                                            MenuShopMetodePembayaran(
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
                                            MenuShopMetodePembayaran(
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
                                            MenuShopMetodePembayaran(
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
                                            MenuShopMetodePembayaran(
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Total Pembayaran',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Rp. 155.000',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            // IconButton(
                            //     onPressed: () {},
                            //     icon: Icon(Icons.arrow_forward_ios_rounded)),
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
                      child: MyButton(
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
                child: const Text(
                  'Rp 150.000',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
