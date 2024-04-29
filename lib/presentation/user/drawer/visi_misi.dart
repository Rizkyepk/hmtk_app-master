import 'package:flutter/material.dart';
import 'package:hmtk_app/widget/template_page.dart';

import 'drawer_user.dart';

class VisiMisi extends StatelessWidget {
  const VisiMisi({super.key});

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
      ),
      body: MyPage(
          widget: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Image.asset(
            'assets/LogoTK3.png',
            height: 200,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visi',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text(
                  'Menjadi Program Studi S1 berstandar internasional, berperan aktif dalam pengembangan pendidikan , riset dan enterpreneurship, dibidag teknik komputer berbasis teknologi informasi dan komunikasi',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Misi 1',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text(
                  'Menyelenggarakan pendidikan tinggi yang berstandar internasional untuk menghasilkan lulusan yang menguasai ilmu dan teknologi komputer.',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Misi 2',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text(
                  'Mengembangkan, menyebarluaskan, dan memanfaatkan ilmu pengetahuan dan teknologi bidang sistem komputer, serta bekerjasama dengan industri/institusi, guna meningkatkan kesejahteraan dan kemajuan masyarakat.',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Misi 3',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text(
                  'Mengembangkan dan membina jejaring dengan perguruan tinggi dan industri terkemuka dalam dan luar negeri dalam rangka kerjasama pendidikan dan penelitian.',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Misi 4',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text(
                  'Mengembangkan sumber daya untuk mencapai keunggulan dalam pembelajaran, penelitian dan pengabdian kepada masyarakat',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
