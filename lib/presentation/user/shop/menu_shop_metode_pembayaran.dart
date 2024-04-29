import 'package:flutter/material.dart';

class MenuShopMetodePembayaran extends StatefulWidget {
  String metode;

  MenuShopMetodePembayaran({required this.metode});

  @override
  State<MenuShopMetodePembayaran> createState() =>
      _MenuShopMetodePembayaranState();
}

class _MenuShopMetodePembayaranState extends State<MenuShopMetodePembayaran> {
  @override
  Widget build(BuildContext context) {
    if (widget.metode == 'transfer') {
      return Transfer();
    } else if (widget.metode == 'dana') {
      return Dana();
    } else if (widget.metode == 'shopee') {
      return Shopee();
    } else {
      return COD();
    }
  }
}

class Transfer extends StatelessWidget {
  const Transfer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'BCA',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SelectableText('5065268008',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.blue)),
            Text(
              'a/n\nIVAN DANIAR ARYAPUTRA',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

class Dana extends StatelessWidget {
  const Dana({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/pembayaran-dana.jpeg',
              height: 300,
              width: 300,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 30,
            ),
            SelectableText(
              '082169870918',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class Shopee extends StatelessWidget {
  const Shopee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/pembayaran-shopee.jpeg',
              height: 300,
              width: 300,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 30,
            ),
            SelectableText(
              '082169870918',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class COD extends StatelessWidget {
  const COD({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/success.png',
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Silahkan hubungi admin untuk melakukan COD',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
