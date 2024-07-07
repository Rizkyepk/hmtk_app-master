import 'package:awesome_dialog/awesome_dialog.dart';
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
import 'package:hmtk_app/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerUserScren extends StatefulWidget {
  const DrawerUserScren({super.key});

  @override
  State<DrawerUserScren> createState() => _DrawerUserScrenState();
}

class _DrawerUserScrenState extends State<DrawerUserScren> {
  Future<void> logout() async {
    await SaveData.clearAuth();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Start()),
        (route) => false);
  }

  void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WillPopScope(
          onWillPop: () async {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
              (route) => false,
            );
            return false;
          },
          child: screen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: const Alignment(0.0, 0.1),
          colors: [Colors.white.withOpacity(0.8), Colors.white], //
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Image(
              // image: AssetImage('assets/LogoTK3.png'),
              image: AssetImage('assets/LOGO TK.png'),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Account'),
            onTap: () {
              navigateTo(context, const Account());
            },
          ),
          ListTile(
            title: const Text('Sejarah TK'),
            onTap: () {
              navigateTo(context, const AboutUs());
            },
          ),
          ListTile(
            title: const Text('Visi Misi TK'),
            onTap: () {
              navigateTo(context, const VisiMisi());
            },
          ),
          ListTile(
            title: const Text('BPH HMTK'),
            onTap: () {
              navigateTo(context, const BphHmtk());
            },
          ),
          ListTile(
            title: const Text('Timeline'),
            onTap: () {
              navigateTo(context, const Timeline());
            },
            // title: const Text('Timeline'),
            // onTap: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const Timeline(),
            //       ));
            // },
          ),
          ListTile(
            title: const Text('Shop'),
            onTap: () {
              navigateTo(context, const MenuShop());
            },
          ),
          ListTile(
            title: const Text('Fun TK'),
            onTap: () {
              navigateTo(context, const MenuJadwalFunTK());
            },
          ),
          ListTile(
            title: const Text('Laboratory'),
            onTap: () {
              navigateTo(context, const MenuLaboratory());
            },
          ),
          ListTile(
            title: const Text('Aspirasi'),
            onTap: () {
              navigateTo(context, const MenuAspiration());
            },
          ),
          ListTile(
            title: const Text('Material Bank'),
            onTap: () {
              navigateTo(context, BankMateri());
            },
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: logout,
          ),
          IconButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.rightSlide,
                    title: 'Butuh bantuan?',
                    btnOkText: 'Hubungi',
                    btnOkOnPress: () async {
                      if (!await launchUrl(
                          Uri.parse('https://linktr.ee/HMTK_TELU'))) {
                        throw Exception('Ada masalah');
                      }
                    },
                  ).show();
                },
                icon: const Icon(
                  Icons.help_outline_rounded,
                  color: Colors.grey,
                  size: 20,
                )),
        ],
      ),
    );
  }
}
