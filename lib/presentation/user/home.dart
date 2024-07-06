import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? _lastActivityId;

  Future<List<Map<String, dynamic>>> fetchActivities() async {
    try {
      var response = await get(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/activity',
        ),
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}'},
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> activities = [];
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data["success"]) {
          // Ambil list aktivitas dari respons
          activities = List<Map<String, dynamic>>.from(data["activities"]);

          // Urutkan aktivitas berdasarkan post_date dari yang terbaru
          activities.sort((a, b) => DateTime.parse(b["post_date"])
              .compareTo(DateTime.parse(a["post_date"])));

          // Cek jika ada aktivitas baru yang belum ditampilkan notifikasi
          if (_lastActivityId != null &&
              activities.isNotEmpty &&
              activities[0]["id"] != _lastActivityId) {
            // Jika ada, tampilkan notifikasi
            activityNotification(activities[0]);
          }

          // Simpan ID aktivitas terbaru untuk referensi selanjutnya
          _lastActivityId = activities.isNotEmpty ? activities[0]["id"] : null;

          return activities;
        } else {
          throw data["message"];
        }
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw "Failed: $e";
    }
  }

  void activityNotification(Map<String, dynamic> activity) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: activity["id"],
        channelKey: 'basic_channel',
        title: 'My-HMTK',
        body: 'Aktivitas Baru: ${activity["title"]}',
      ),
    );
  }

  // void activityNotification(Map<String, dynamic> activity) {
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: activity["id"], // Use unique ID for each notification
  //       channelKey: 'My-HMTK',
  //       title: 'Aktivitas Baru: ${activity["title"]}',
  //       body: activity["description"], // Assuming there's a description field
  //       notificationLayout: NotificationLayout.Default,
  //     ),
  //   );
  // }

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
                  height: 140,
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
                                        return SizedBox(
                                            width: 190,
                                            child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Text(
                                                  getFirstString(
                                                      student["name"]),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )));
                                      }
                                    }),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Account()));

                                setState(() {});
                              },
                              child: CircleAvatar(
                                radius: 38,
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                  child: FutureBuilder<Map<String, dynamic>>(
                                      future: SaveData.getAuth(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<Map<String, dynamic>>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Image.network(
                                            "https://cdn.jeyy.xyz/image/default_avatar_b0e451.png",
                                            fit: BoxFit.cover,
                                            width: 66,
                                            height: 66,
                                          );
                                        } else if (snapshot.hasError) {
                                          return Image.network(
                                            "https://cdn.jeyy.xyz/image/default_avatar_b0e451.png",
                                            fit: BoxFit.cover,
                                            width: 66,
                                            height: 66,
                                          );
                                        } else {
                                          final student =
                                              snapshot.data!["user"];
                                          return Image.network(
                                            student["avatar_url"],
                                            fit: BoxFit.cover,
                                            width: 66,
                                            height: 66,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return SizedBox(
                                                  height: 200,
                                                  width: double.maxFinite,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
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
                                          );
                                        }
                                      }),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20, right: 20),
                      //   child: Container(
                      //     height: 50,
                      //     margin: const EdgeInsets.only(top: 20, bottom: 20),
                      //     padding: const EdgeInsets.only(left: 20, right: 20),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(30),
                      //         color: Colors.white),
                      //     child: const Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Expanded(
                      //             flex: 9,
                      //             child: TextField(
                      //               decoration: InputDecoration(
                      //                   hintText: 'Search',
                      //                   border: InputBorder.none),
                      //             )),
                      //         Expanded(flex: 1, child: Icon(Icons.search))
                      //       ],
                      //     ),
                      //   ),
                      // )
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
                      key: const Key("navigate_to_timeline_button"),
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
                'Aktivitas Terkini',
                style: TextStyle(color: Colors.green),
              ),
              FutureBuilder(
                  future: fetchActivities(),
                  builder: (BuildContext build, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('');
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Map<String, dynamic>> activities = snapshot.data;

                      return SingleChildScrollView(
                        child: Column(
                          children: activities.map((activity) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailActivity(activity: activity),
                                      ),
                                    );
                                  },
                                  child: ItemActivity(
                                    title: activity["title"],
                                    imgUrl: activity["img_url"],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      );
                    }
                  }),

              // const SizedBox(
              //   height: 30,
              // ),
              // InkWell(
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const DetailActivity()));
              //     },
              //     child: const ItemActivity()),
              // const SizedBox(
              //   height: 30,
              // ),

              // const ItemActivity(),
              // const SizedBox(
              //   height: 30,
              // ),
            ],
          ),
        )
      ]),
    );
  }
}
