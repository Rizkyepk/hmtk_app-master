import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/shop/menu_shop.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/main_navigator.dart';


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
              padding: const EdgeInsets.only(bottom: 20),
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Pesanan Berhasil',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Silahkan Menunggu',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainNavigator(),
                          ),
                          (route) => false);
                    },
                    child: const MyButton(
                      txt: 'Home',
                      width: 200,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MenuShop(),
                          ),
                          (route) => false);
                    },
                    child: const MyButton(
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
