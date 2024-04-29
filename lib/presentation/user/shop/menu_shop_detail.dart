import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/template_page.dart';

class MenuShopDetail extends StatefulWidget {
  final String title, harga, gambar;

  const MenuShopDetail(
      {super.key,
      required this.title,
      required this.harga,
      required this.gambar});

  @override
  State<MenuShopDetail> createState() => _MenuShopDetailState();
}

class _MenuShopDetailState extends State<MenuShopDetail> {
  int jumlah = 1;

  List<String> ukurans = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'];
  String valueUkuran = 'S';

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
                    height: 130,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Text(
                          '${widget.title}',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Jumlah',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.green),
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
                                              icon: Icon(Icons.remove)),
                                        ),
                                        Text(
                                          '$jumlah',
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.blue),
                                        ),
                                        CircleAvatar(
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  jumlah++;
                                                });
                                              },
                                              icon: Icon(Icons.add)),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ukuran',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.green),
                                    ),
                                    DropdownButton(
                                      value: valueUkuran,
                                      focusColor: Colors.blue,
                                      style: TextStyle(
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
                                )),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Harga',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.green),
                                    ),
                                    Text(
                                      '${widget.harga}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Info Tambahan',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Berikan informasi Tambahan Anda Di Sini',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                        Container(
                          height: 150,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          color: Colors.grey.shade300,
                          child: TextFormField(
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Deskripsi',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Dapatkan jersey futsal pemain Glootropers dari HMTK dengan bahan premium kami yang ringan, tahan air, dan desain ekonomis untuk penampilan maksimal di lapangan dan terlihat kece pastinya.',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                        SizedBox(
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
                          child: MyButton(
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
                  child: Image.asset('${widget.gambar}'))
            ],
          ),
        ],
      )),
    );
  }
}
