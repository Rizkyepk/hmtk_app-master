import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/drawer/drawer_user.dart';
import 'package:hmtk_app/widget/template_page.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerUserScren(),
      ),
      appBar: AppBar(),
      body: MyPage(
          widget: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(
            'assets/LogoTK3.png',
            height: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Apa Itu Teknik Komputer?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text(
                  'Teknik komputer adalah suatu disiplin khusus yang mengkombinasikan teknik elektro dan ilmu komputer. Seorang teknisi komputer adalah teknisi elektro arus lemah yang lebih berfokus pada sistem sirkuit digital, sistem komunikasi data pada frekuensi radio, dan elektronika sebagai bagian dari komputer secara menyeluruh.',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sejarah Teknik Komputer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text('Tahun 1990'),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'STT TELKOM DIDIRIKAN Sekolah Tinggi Teknologi Telkom (STTTelkom) didirikan oleh Yayasan Pendidikan dan Pelatihan Teknologi dan Manajemen Telekomunikasi atau disingkat Yayasan Pendidikan Telkom (YPT) pada tanggal 28 September 1990. STT Telkom didirikan untuk menyiapkan tenaga-tenaga ahli di bidang informasi dan Telekomunikasi (Infokom) yang terampil dan berwawasan bisnis sebagai jawaban atas tuntutan perkembangan industri infokom yang begitu pesat.\n\nFakultas Elektro dan Komunikasi merupakan pengembangan dari Departemen Teknik Elektro, yang merupakan departemen terbesar di dalam Institut Teknologi Telkom dilihat dari sumber daya manusia (Mahasiswa, Dosen, Alumni) maupun dari sisi jumlah laboratorium, serta dari kerjasama yang telah dijalin. Departemen Teknik Elektro didirikan seiring dengan berdirinya STT Telkom pada tahun 1990, yang sebelumnya bernama Jurusan Teknik Elektro.\n\nPada saat itu Departemen Teknik Elektro hanya membuka 2 (dua) buah program Studi yaitu Program Studi S1 Teknik Telekomunikasi dan D3 Teknik Telekomunikasi. Pada tahun 2007, Jurusan Teknik Elektro berubah nama menjadi Departemen Teknik Elektro.',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sejarah Teknik Komputer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text('Tahun 2007'),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '''POLITEKNIK TELKOM DIDIRIKAN
Upaya pengembangan Departemen Teknik Elektro terus dilakukan. Pada tahun 2007, Institut Teknologi Telkom diberi kepercayaan untuk membuka program studi baru, yaitu Program Teknik Elektro dan Teknik Komputer. Berdasarkan SK Mendikbud No. 108/D/T/2007, pada tanggal 16 Januari 2007, kedua program studi tersebut diberi status ijin Operasional. Dengan demikian Departemen Teknik Elektro memiliki 5 (Lima) Program Studi yaitu :
Program Studi S1 Teknik Telekomunikasi
Program Studi S1 Teknik Elektro
Program Studi S1 Teknik Komputer
Program Studi D3 Teknik Telekomunikasi
Program Studi S2 Teknik Elektro''',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sejarah Teknik Komputer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text('Tahun 2008'),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '''STT TELKOM BERUBAH MENJADI IT TELKOM
Seiring dengan perubahan status Institusi dari Sekolah Tinggi Teknologi Telkom menjadi Institut Teknologi Telkom (ITTelkom) pada tanggal 27 Nopember 2007 dan penambahan program studi di lingkungan Departemen Teknik Elektro maka pada tanggal 1 Pebruari 2009, Departemen Teknik Elektro berubah status menjadi Fakultas Elektro dan Komunikasi.''',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sejarah Teknik Komputer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text('Tahun 2011'),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '''AKREDITASI PERTAMA SISTEM KOMPUTER
Pada tahun 2011, untuk pertama kali dilakukan proses akreditasi atas Program Studi Sistem Komputer. Berdasarkan SK Nomor 021/BAN-PT/Ak-XIV/S1/VIII/2011, Prodi Sistem Komputer mendapat peringkat akreditasi C dengan point 274 dengan masa berlaku 18 Agustrus 2011 sampai dengan 18 Agustus 2016.''',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sejarah Teknik Komputer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text('Tahun 2008'),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '''STT TELKOM BERUBAH MENJADI IT TELKOM
Seiring dengan perubahan status Institusi dari Sekolah Tinggi Teknologi Telkom menjadi Institut Teknologi Telkom (ITTelkom) pada tanggal 27 Nopember 2007 dan penambahan program studi di lingkungan Departemen Teknik Elektro maka pada tanggal 1 Pebruari 2009, Departemen Teknik Elektro berubah status menjadi Fakultas Elektro dan Komunikasi.''',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sejarah Teknik Komputer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text('Tahun 2013'),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '''PENGGABUNGAN 4 INSTITUSI MENJADI TELKOM UNIVERSITY
Berdasarkan Keputusan Menteri Pendidikan dan kebudayaan RI Nomor 270/E/O/2013 Tentang Penggabungan Politeknik Telkom, Institut Teknologi Telkom, dan Institut Manajemen Telkom yang diselenggarakan oleh Yayasan Pendidikan Telkom Menjadi Universitas Telkom di Kabupaten Bandung Provinsi Jawa Barat, maka Prodi Sistem Komputer berada di Fakultas Teknik Universitas Telkom.Pada bulan April 2014 terjadi pemekaran Fakultas Teknik Universitas Telkom menjadi 3 fakultas yaitu Fakultas Teknik Elektro, Fakultas Rekayasa Industri, dan Fakultas Informatika. Oleh karena itu Fakultas Teknik Elektro memiliki 5 (lima) Program Studi yaitu :
Program Studi S1 Teknik Telekomunikasi
Program Studi S1 Teknik Elektro
Program Studi S1 Sistem Komputer
Program Studi S1 Teknik Fisika.
Program Studi S2 Teknik Elektro''',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sejarah Teknik Komputer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Text('Tahun 2016'),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '''AKREDITASI KEDUA SISTEM KOMPUTER
Pada tahun 2016, dilakukan akreditasi kembali sehingga status akreditasi terbaru Program Studi Sistem Komputer berdasarkan SK Nomor 0942/SK/BAN-PT/Akred/S/VI/2016 adalah B dengan masa berlaku sampai dengan 17 Juli 2021. Pada saat ini, kurikulum yang berlaku di Program Studi Sistem Komputer adalah kurikulum 2016.''',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sosial Media Kami',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.green),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Instagram : @hmtk_telu',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Text(
                    'Youtube : @HMSKTELU',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green),
                  ),
                ),
                Text(
                  'Line : @QSG4413Q',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
