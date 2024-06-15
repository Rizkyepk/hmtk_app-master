// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/snapping_data.dart';
import 'package:hmtk_app/utils/utils.dart';
// import 'package:hmtk_app/utils/utils.dart';
// import 'package:http/http.dart';
// import 'package:image_picker/image_picker.dart';

import 'drawer/drawer_user.dart';
import 'edit_account.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

//tampulan awal account
class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return snap((user) {
      final nim = user['nim'].toString(); // Konversi nim ke string
      final tel = user['tel'].toString(); // Konversi tel ke string

      return Scaffold(
        drawer: const Drawer(
          width: 200,
          backgroundColor: Colors.transparent,
          child: DrawerUserScren(),
        ),
        appBar: AppBar(
          elevation: 0,
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/bg.png',
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            ListView(
              padding: const EdgeInsets.all(25),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Account',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                            radius: 38,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                                child: Image.network(
                              user["avatar_url"],
                              fit: BoxFit.cover,
                              width: 76,
                              height: 76,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return SizedBox(
                                    height: 200,
                                    width: double.maxFinite,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ))),
                      ],
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          getFirstString(user["name"]),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Full Name',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: user['name'],
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'NIM',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: nim,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'No Telp',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: tel,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: user['email'],
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Address',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: user['address'],
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditAccount(),
                            ),
                          );
                        },
                        child: const Text('Edit account'),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
