import 'package:flutter/material.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/template_page.dart';

class MenuShopDataPemesanan extends StatefulWidget {
  final String title, harga, gambar;

  const MenuShopDataPemesanan(
      {super.key,
      required this.title,
      required this.harga,
      required this.gambar});

  @override
  State<MenuShopDataPemesanan> createState() => _MenuShopDataPemesananState();
}

class _MenuShopDataPemesananState extends State<MenuShopDataPemesanan> {
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
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ))),
              SizedBox(
                height: 50,
              ),
            ],
          ),
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 90,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          '${widget.title}',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Full Name',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(1, 1))
                            ],
                          ),
                          child: Text(
                            'Ivan Daniar',
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'NIM',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(1, 1))
                            ],
                          ),
                          child: Text(
                            '1100000009',
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'No Telp',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(1, 1))
                            ],
                          ),
                          child: Text(
                            '084534780327',
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(1, 1))
                            ],
                          ),
                          child: Text(
                            'lulustepatwaktu@gmail.com',
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Informasi Tambahan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(1, 1))
                            ],
                          ),
                          child: Text(
                            'Nama Punggung Kita \nNomor Punggung 10',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Jumlah',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Ukuran',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'M',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Harga',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Rp 150.000',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    '${widget.gambar}',
                    height: 200,
                  ))
            ],
          ),
        ],
      )),
    );
  }
}
