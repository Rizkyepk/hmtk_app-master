import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/widget/template_page.dart';

import 'drawer_user.dart';

class BphHmtk extends StatelessWidget {
  const BphHmtk({super.key});

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BPH HMTK',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green),
                    ),
                    Image.asset('assets/logo-beraksi.png')
                  ],
                ),
                Image.asset('assets/bph-hmtk.png'),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Selamat Datang di Aplikasi Mobile  Program Studi S1 Teknik Komputer Telkom. Selamat Datang di Website Program Studi S1 Teknik Komputer Telkom, Selamat Datang di Website Program Studi S1 Teknik Komputer Telkom',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BPH HMTK',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green),
                    ),
                    Image.asset('assets/logo-beraksi.png')
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'KABINET ',
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text('BERAKSI'),
                  ],
                ),
                Row(
                  children: [
                    Text('Filosofi Logo '),
                    Text(
                      'KABINET',
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text('BERAKSI'),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '1. Singa melambangkan keberanian dan kekuatan, sesuai dengan arti beraksi yang merupakan bergerak melakukan sesuatu untuk mencapai tujuan dengan keberanian dan kekuatan selama prosesnya',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '2. Mata yang berwarna merah melambangkan energi dan semangat dalam melihat semua pandangan dan perbedaan yang ada',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '''3. Corak pendek surai singa yang berbeda warna yaitu :
\n1 warna abu-abu melambangkan departemen kaderisasi yang berjalan dalam hal keseriusan, kemandirian, dan tanggung jawab
\n2 warna biru melambangkan departemen akprof dan departemen mnb yang berjalan dalam hal kecerdasan, intuisi, imajinasi, kedamaian, dan ketertiban
\n2 warna coklat melambangkan departemen relasi internal dan departemen hublusos yang berjalan dalam hal keakraban, kepercayaan, stabilitas, dan rasa aman
\n1 warna hijau melambangkan departemen Kominfo yang berjalan dalam hal kesegaran, kesejahteraan, dan kedamaian
\n2 warna emas melambangkan departemen kwu dan departemen kesma yang berjalan dalam hal kemakmuran, kesuksesan, dan kemewahan''',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '4. Satu surai panjang yang menyatukan semua corak bermakna bahwa kabinet beraksi terdiri dari 8 departemen yang mengampu tugasnya masing-masing tetapi tetap memiliki satu tujuan. Campuran warna biru dan hijau mempresentasikan HMTK yang memiliki kebijaksanaan, produktivitas, kecerdasan, dan kepercayaan',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TURN ON\nTHE FUTURE',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Image.asset('assets/image 11.png')
              ],
            ),
          ),
        ],
      )),
    );
  }
}
