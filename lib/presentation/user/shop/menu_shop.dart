import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/home.dart';
import 'package:hmtk_app/presentation/user/shop/menu_shop_mycart.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/main_navigator.dart';
import 'package:hmtk_app/widget/template_page.dart';

import '../drawer/drawer_user.dart';
import 'menu_shop_detail.dart';
import 'menu_shop_history.dart';

class MenuShop extends StatelessWidget {
  const MenuShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerUserScren(),
      ),
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          MyPage(
              widget: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: EdgeInsets.only(left: 20, top: 20),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 500,
                  // color: Colors.amber,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(right: 15),
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuShopDetail(
                                    gambar: 'assets/jersey pemain detail.png',
                                    title: 'Jersey Pemain',
                                    harga: 'Rp 150.000'),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.3))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/jersey pemain.png'),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Jersey Pemain\nRp. 150.000,00',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuShopDetail(
                                    gambar: 'assets/jersey kiper detail.png',
                                    title: 'Jersey Kiper',
                                    harga: 'Rp 150.000'),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.3))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/jersey kiper.png'),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Jersey Kiper\nRp. 150.000,00',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuShopMycart(),
                          ));
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: MyButton(txt: 'My Cart'))),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuShopHistory(),
                          ));
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: MyButton(txt: 'History')))
              ],
            ),
          )),
          // Positioned(
          //     top: 30,
          //     child: IconButton(
          //         onPressed: () {
          //           Navigator.pushAndRemoveUntil(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => MainNavigator(),
          //               ),
          //               (route) => false);
          //         },
          //         icon: Icon(
          //           Icons.arrow_back_ios_new,
          //           size: 25,
          //           color: Colors.white,
          //         )))
        ],
      ),
    );
  }
}
