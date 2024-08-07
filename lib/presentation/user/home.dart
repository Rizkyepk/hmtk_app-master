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
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          List<Map<String, dynamic>> activities =
              List<Map<String, dynamic>>.from(data["activities"]);

          // Sort activities based on ID (assuming higher ID means newer activity)
          activities.sort((a, b) => b["id"].compareTo(a["id"]));

          if (activities.isNotEmpty) {
            int latestActivityId = activities.first["id"];
            if (_lastActivityId == null || latestActivityId > _lastActivityId!) {
              // New activity detected, update the last activity ID
              _lastActivityId = latestActivityId;
              for (var activity in activities) {
                activityNotification(activity);
              }
            }
          }
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

  activityNotification(Map<String, dynamic> activity) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: activity["id"],
        channelKey: 'basic_channel',
        title: 'My-HMTK',
        body: 'Aktivitas Baru: ${activity["title"]}',
      ),
    );
  }

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
                  padding: const EdgeInsets.only(bottom: 25, left: 20, right: 20),
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
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontSize: 30,
                                                      fontWeight: FontWeight.bold,
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
            Positioned(
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
            ],
          ),
        )
      ]),
    );
  }
}
