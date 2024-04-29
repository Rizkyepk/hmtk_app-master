import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/account.dart';
import 'package:hmtk_app/presentation/user/aspiration/menu_aspiration.dart';
import 'package:hmtk_app/presentation/user/detail_activity.dart';
import 'package:hmtk_app/presentation/user/drawer/drawer.dart';
import 'package:hmtk_app/presentation/user/drawer/drawer_user.dart';
import 'package:hmtk_app/presentation/user/fun-tk/menu_jadwal_funtk.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/widget/item_activity.dart';
import 'package:hmtk_app/widget/template_page.dart';

import 'laboratory/menu_laboratory.dart';
import 'shop/menu_shop.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: Drawer(
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
                  padding: EdgeInsets.only(bottom: 25, left: 20, right: 20),
                  height: 240,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                      color: ColorPallete.greenprim),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => DrawerUser(),
                      //           ));
                      //     },
                      //     icon: Icon(
                      //       Icons.menu,
                      //       color: Colors.white,
                      //       size: 30,
                      //     )),
                      SizedBox(
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
                                Text(
                                  'Good Morning,',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  'Ivan Daniar',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Account()));
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
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          padding: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: Row(
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
                SizedBox(
                  height: 50,
                )
              ],
            ),
            Positioned(
              // alignment: Alignment.bottomCenter,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuShop(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    const Color.fromARGB(255, 90, 209, 94),
                                    Color.fromARGB(255, 70, 163, 73)
                                  ]),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/shop.png'),
                          ),
                          Text(
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
                              builder: (context) => MenuJadwalFunTK(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    const Color.fromARGB(255, 90, 209, 94),
                                    Color.fromARGB(255, 70, 163, 73)
                                  ]),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/fun-tk.png'),
                          ),
                          Text(
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
                              builder: (context) => MenuLaboratory(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    const Color.fromARGB(255, 90, 209, 94),
                                    Color.fromARGB(255, 70, 163, 73)
                                  ]),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/laboratory.png'),
                          ),
                          Text(
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
                              builder: (context) => MenuAspiration(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    const Color.fromARGB(255, 90, 209, 94),
                                    Color.fromARGB(255, 70, 163, 73)
                                  ]),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/aspiration.png'),
                          ),
                          Text(
                            'Aspiration',
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
        SizedBox(
          height: 25,
        ),
        Container(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Activity',
                style: TextStyle(color: Colors.green),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailActivity()));
                  },
                  child: ItemActivity()),
              SizedBox(
                height: 30,
              ),
              ItemActivity(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
