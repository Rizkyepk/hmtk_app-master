import 'package:flutter/material.dart';

import 'package:hmtk_app/presentation/user/account.dart';
import 'package:hmtk_app/presentation/user/aspiration/menu_aspiration.dart';
import 'package:hmtk_app/presentation/user/drawer/about_us.dart';
import 'package:hmtk_app/presentation/user/drawer/bank_materi.dart';
import 'package:hmtk_app/presentation/user/drawer/bph_hmtk.dart';
import 'package:hmtk_app/presentation/user/drawer/visi_misi.dart';
import 'package:hmtk_app/presentation/user/fun-tk/menu_jadwal_funtk.dart';
import 'package:hmtk_app/presentation/user/home.dart';
import 'package:hmtk_app/presentation/user/laboratory/menu_laboratory.dart';
import 'package:hmtk_app/presentation/user/shop/menu_shop.dart';
import 'package:hmtk_app/presentation/user/start.dart';

import 'package:hmtk_app/presentation/user/timeline.dart';
import 'package:hmtk_app/widget/main_navigator.dart';

class DrawerUserScren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment(0.0, 0.1),
          colors: [Colors.white.withOpacity(0.8), Colors.white], //
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Image(
              image: AssetImage('assets/LogoTK3.png'),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Account'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Account(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Sejarah TK'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Visi Misi TK'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VisiMisi(),
                  ));
            },
          ),
          ListTile(
            title: const Text('BPH HMTK'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BphHmtk(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Timeline'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Timeline(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Shop'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuShop(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Fun TK'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuJadwalFunTK(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Laboratory'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuLaboratory(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Aspirasi'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuAspiration(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Material Bank'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BankMateri(),
                  ));
            },
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Start()),
                  (route) => false);
            },
          )
        ],
      ),
    );
  }
}
