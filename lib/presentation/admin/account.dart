import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';

class AccountEdit extends StatelessWidget {
  const AccountEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: SaveData.getAuth(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData) {
          final admin = snapshot.data!['user'];
          return Scaffold(
            drawer: const Drawer(
              width: 200,
              backgroundColor: Colors.transparent,
              child: DrawerScren(),
            ),
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 200,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ActivityFrame(),
                        ),
                      );
                    },
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(38), // Image radius
                        child: Image.asset(
                          'assets/default-avatar.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Hello, ${admin['name']}'),
                  ),
                ],
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              elevation: 0.00,
              backgroundColor: ColorPallete.greenprim,
            ),
            body: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 1,
                        color: Colors.black.withOpacity(0.2),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "My Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 219, 219, 219),
                        height: 15,
                        thickness: 2,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Nama",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(3),
                        height: 30,
                        width: 330,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                            width: 2.0,
                          ),
                        ),
                        child: Text(admin['name']),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(3),
                        height: 30,
                        width: 330,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                            width: 2.0,
                          ),
                        ),
                        child: Text(admin['email']),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('No data available'),
            ),
          );
        }
      },
    );
  }
}
