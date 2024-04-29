import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/drawer/about_us.dart';
import 'package:hmtk_app/presentation/user/drawer/bph_hmtk.dart';
import 'package:hmtk_app/presentation/user/drawer/visi_misi.dart';
import 'package:hmtk_app/widget/template_page.dart';

import 'bank_materi.dart';

class DrawerUser extends StatefulWidget {
  const DrawerUser({super.key});

  @override
  State<DrawerUser> createState() => _DrawerUserState();
}

class _DrawerUserState extends State<DrawerUser> {
  var selecteditem = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Image.asset(
            'assets/bg-3.png',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/LogoTK3.png'),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 15),
                    height: 70,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.3))
                        ],
                        color: Colors.white),
                    child: Text(
                      'Home',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.maxFinite,
                  padding: EdgeInsets.only(left: 15),
                  height: 70,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1, 1),
                            blurRadius: 3,
                            color: Colors.black.withOpacity(0.3))
                      ],
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      PopupMenuButton(
                          icon: Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 30,
                          ),
                          onSelected: (value) {
                            setState(() {
                              selecteditem = value.toString();
                            });
                            if (selecteditem == '0') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AboutUs(),
                                  ));
                            } else if (selecteditem == '1') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VisiMisi(),
                                  ));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BphHmtk(),
                                  ));
                            }
                          },
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text('About Us'),
                                  value: '0',
                                ),
                                PopupMenuItem(
                                  child: Text('Vision & Mission'),
                                  value: '1',
                                ),
                                PopupMenuItem(
                                  child: Text('BPH HMTK'),
                                  value: '2',
                                ),
                              ])
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BankMateri(),
                        ));
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 15),
                    height: 70,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.3))
                        ],
                        color: Colors.white),
                    child: Text(
                      'Material Bank',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
