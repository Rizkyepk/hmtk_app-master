import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/dashboard.dart';
import 'package:hmtk_app/presentation/user/start.dart';
import 'package:hmtk_app/utils/utils.dart';

import 'activity.dart';

class DrawerScren extends StatefulWidget {
  const DrawerScren({super.key});

  @override
  State<DrawerScren> createState() => _DrawerScrenState();
}

class _DrawerScrenState extends State<DrawerScren> {
  Future<void> logout() async {
    await SaveData.clearAuth();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Start()),
        (route) => false);
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
            title: const Text('Dashboard'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const Dashboard(); //
                },
              );
            },
          ),
          ListTile(
            title: const Text('Activity'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ActivityDialog(); //
                },
              );
            },
          ),
          ListTile(
            title: const Text('Fun TK'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const FuntkDialog(); //
                },
              );
            },
          ),
          ListTile(
            title: const Text('Shop'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ShopDialog(); //
                },
              );
            },
          ),
          ListTile(
            title: const Text('Laboratory'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const LabDialog(); //
                },
              );
            },
          ),
          ListTile(
            title: const Text('Aspiration'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AspirasiDialog(); //
                },
              );
            },
          ),
          ListTile(
            title: const Text('Material Bank'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const MaterialBankDialog(); //
                },
              );
            },
          ),
          ListTile(
            title: const Text('Timeline'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const TimelineDialog(); //
                },
              );
            },
          ),
          // ListTile(
          //   title: const Text('About Us'),
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return const AboutUsDialog(); //
          //       },
          //     );
          //   },
          // ),
          // ListTile(
          //   title: const Text('Vision & Mision'),
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return const VisiMisiDialog(); //
          //       },
          //     );
          //   },
          // ),
          // ListTile(
          //   title: const Text('BPH HMTK'),
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return const BphDialog(); //
          //       },
          //     );
          //   },
          // ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: () {
              AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Ingin logout?',
                      btnOkOnPress: logout)
                  .show();
            },
          ),
        ],
      ),
    );
  }
}
