import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/shop/menu_shop.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/main_navigator.dart';

import '../home.dart';

class MenuShopPesananBerhasil extends StatelessWidget {
  const MenuShopPesananBerhasil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/pesanan-berhasil.png',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(bottom: 20),
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Pesanan Berhasil',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Silahkan Menunggu',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainNavigator(),
                          ),
                          (route) => false);
                    },
                    child: MyButton(
                      txt: 'Home',
                      width: 200,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuShop(),
                          ),
                          (route) => false);
                    },
                    child: MyButton(
                      txt: 'Order Again',
                      width: 200,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
