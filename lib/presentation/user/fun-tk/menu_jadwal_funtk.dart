import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/detail_activity.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/widget/template_page.dart';

import '../drawer/drawer_user.dart';
import 'menu_detail_activity.dart';

class MenuJadwalFunTK extends StatelessWidget {
  const MenuJadwalFunTK({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerUserScren(),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text('Jadwal Fun TK'),
      ),
      body: MyPage(
          widget: ListView.builder(
        padding: EdgeInsets.all(40),
        itemCount: 4,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuDetailActivity(),
                ));
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: Offset(1, 4),
                      blurRadius: 5)
                ]),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/img-fun-tk.png',
                          height: 230,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 70,
                          width: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            '12\nDes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '18:00 WIB',
                        style: TextStyle(
                            color: ColorPallete.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Image.asset('assets/icon-lokasi.png'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Lapangan Rajawali',
                            style: TextStyle(
                              color: ColorPallete.greenprim,
                              fontSize: 16,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
