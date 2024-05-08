import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/aspiration/menu_riwayat_aspirasi.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/main_navigator.dart';
import 'package:hmtk_app/widget/template_page.dart';

import '../drawer/drawer_user.dart';

class MenuAspiration extends StatelessWidget {
  const MenuAspiration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerUserScren(),
      ),
      appBar: AppBar(
        elevation: 0,
      ),
      body: MyPage(
          widget: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 5))
                ]),
                child: MyButton(
                  txt: 'Input Aspirasi',
                  width: 150,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MenuRiwayatAspirasi(),
                      ));
                },
                child: MyButton(
                  txt: 'Riwayat Aspirasi',
                  width: 150,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 70,
          ),
          const Text(
            'Input Response',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                  flex: 1,
                  child: Text(
                    'Judul',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration: const InputDecoration(border: InputBorder.none),
                      maxLines: 1,
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                  flex: 1,
                  child: Text(
                    'Isi Tanggapan',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration: const InputDecoration(border: InputBorder.none),
                      maxLines: 5,
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Align(
            child: InkWell(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: 'Success!',
                  desc: 'Thank you for you aspiration',
                  btnOkOnPress: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainNavigator(),
                        ),
                        (route) => false);
                  },
                ).show();
              },
              child: MyButton(txt: 'Kirim', height: 40),
            ),
          )
        ],
      )),
    );
  }
}
