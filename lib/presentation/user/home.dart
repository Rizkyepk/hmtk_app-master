import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/account.dart';
import 'package:hmtk_app/presentation/user/detail_activity.dart';
import 'package:hmtk_app/presentation/user/drawer/drawer_user.dart';
import 'package:hmtk_app/presentation/user/fun-tk/menu_jadwal_funtk.dart';
import 'package:hmtk_app/presentation/user/timeline.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/item_activity.dart';
import 'package:http/http.dart';

import 'laboratory/menu_laboratory.dart';
import 'shop/menu_shop.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: const Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerUserScren(),
      ),
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView(children: [
        Stack(
          children: [
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(bottom: 25, left: 20, right: 20),
                  height: 240,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                      color: ColorPallete.greenprim),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Hello!',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                FutureBuilder<Map<String, dynamic>>(
                                    future: SaveData.getAuth(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Map<String, dynamic>>
                                            snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text('');
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        final student = snapshot.data!["user"];
                                        return Text(
                                          student["name"],
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        );
                                      }
                                    }),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Account()));
                              },
                              child: CircleAvatar(
                                radius: 28,
                                child: Image.asset(
                                  'assets/profile.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.only(top: 20, bottom: 20),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 9,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Search',
                                        border: InputBorder.none),
                                  )),
                              Expanded(flex: 1, child: Icon(Icons.search))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
            Positioned(
              // alignment: Alignment.bottomCenter,
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MenuShop(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color.fromARGB(255, 90, 209, 94),
                                    Color.fromARGB(255, 70, 163, 73)
                                  ]),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/shop.png'),
                          ),
                          const Text(
                            'Shop',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MenuJadwalFunTK(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color.fromARGB(255, 90, 209, 94),
                                    Color.fromARGB(255, 70, 163, 73)
                                  ]),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/fun-tk.png'),
                          ),
                          const Text(
                            'Fun-TK',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MenuLaboratory(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color.fromARGB(255, 90, 209, 94),
                                    Color.fromARGB(255, 70, 163, 73)
                                  ]),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/laboratory.png'),
                          ),
                          const Text(
                            'Laboratory',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Timeline(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color.fromARGB(255, 90, 209, 94),
                                    Color.fromARGB(255, 70, 163, 73)
                                  ]),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/icon-timeline.png'),
                          ),
                          const Text(
                            'Timeline',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Activity',
                style: TextStyle(color: Colors.green),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DetailActivity()));
                  },
                  child: const ItemActivity()),
              const SizedBox(
                height: 30,
              ),
              const ItemActivity(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )
      ]),
    );
  }
}

Future<Response> fetchStudent(int nim) async {
  try {
    var response = await get(
      Uri(
        scheme: 'https',
        host: 'myhmtk.jeyy.xyz',
        path: '/student/$nim',
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
      },
    );

    return response;
  } catch (e) {
    throw Exception('Failed to load: $e');
  }
}
