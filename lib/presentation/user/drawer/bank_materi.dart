import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/drawer/drawer_user.dart';
// import '../../utils/color_pallete.dart';
// import 'widget/drawer_user.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemBank extends StatelessWidget {
  final String txt;
  final Color color;
  final String url;

  const ItemBank(
      {super.key, required this.txt, required this.color, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (!await launchUrl(uri)) {
          throw Exception('bermasalah $url');
        }
      },
      child: Container(
        height: 35,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
        alignment: Alignment.center,
        color: color,
        child: Text(
          txt,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class BankMateri extends StatelessWidget {
  const BankMateri({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerUserScren(),
      ),
      appBar: AppBar(),
      body: ListView(
        children: [
          buildItemList('Tingkat 1', [
            const ItemBank(
                txt: 'Bahasa Inggris',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/17vHGUA_rgiZC41Yg4jgGphPnu3MSc4nH'),
            const ItemBank(
                txt: 'Fisika 1',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1rJNMaRlUOYBTZJ6Oj4ey8oka7ixAyeO4'),
            const ItemBank(
                txt: 'Kalkulus 1',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/10fxs6l5SLiDTOJ_sG2qd6FP4wOj9PVdn'),
            const ItemBank(
                txt: 'Logika Matematika',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/14_fPN3kL57JCFNlRwT257VyRxj09Ugvf'),
            const ItemBank(
                txt: 'Pembetukan Karakter',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1s9VaeFtTZRsC_1K52D47L6zsJ7M_cX0V?usp=sharing'),
            const ItemBank(
                txt: 'Pendidikan Kewarganegaraan',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/13tgVH0Clo3NxgpSWxVq_Q0bY9s3wlZxe'),
            const ItemBank(
                txt: 'Pengantar Rekayasa dan Desain',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1grRH3V2epKNlnctYZhBucrYi6pcw1NbY'),
            const ItemBank(
                txt: 'Pengenalan Teknik Komputer',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1cRnVqiNKelGaxzI3SqJrj9aB-4CKnk9Z'),
            const ItemBank(
                txt: 'Algoritma dan Pemrograman',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1xUq7ycc-Wre8FBtSdulPfxkuQVFdcwvz'),
            const ItemBank(
                txt: 'Biologi',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1Dt7MDz7VtLHONeAb7559lwUAL-LGBQxV'),
            const ItemBank(
                txt: 'Fisika 2',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1nOnBluAra37v1rVy2R-xKlH7Gm4vCx9T'),
            const ItemBank(
                txt: 'Kalkulus',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/12JwLDBvbtOx8buvngTEuiEUsAlWQW7L6'),
            const ItemBank(
                txt: 'Interaksi Manusia dan Komputer',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1rBFxi-H1LX-GC6CoBfzHGDuxpPTP_Haj?usp=sharing'),
            const ItemBank(
                txt: 'Literasi Manusia',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1TRWIV7s6CgvsJr1ZYtaRwV2YyYZI0RyI'),
          ]),
          buildItemList('Tingkat 2', [
            const ItemBank(
                txt: 'Bahasa Indonesia',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1W3RXQcG1BP6M_HHibqQWpKfwVsG5F_RT'),
            const ItemBank(
                txt: 'Desain Basis Data',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/12sTNQGu1n_lPf_4jshc40gQwrgl7ayU6'),
            const ItemBank(
                txt: 'Matematika Diskret',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1bnDM2WBitVVFGYxnGScbfpWSZ2aARhRb'),
            const ItemBank(
                txt: 'Matriks dan Ruang Vektor',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1bYRswmTvmotmxY9haBSk0aGSWeMEorbQ'),
            const ItemBank(
                txt: 'Pemrograman Berorientasi Obyek',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1lynNxfS5UV_l7-f3S20uArPOuBkHfNCz'),
            const ItemBank(
                txt: 'Rangkaian Listrik Dasar',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1IQoycUpx4cyls-0pGW31aot4vZBHWcqb'),
            const ItemBank(
                txt: 'Desain Sistem Digital',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1IL4MAXkNvIYEgMHXgFMBxycG9G7cAoW_'),
            const ItemBank(
                txt: 'Elektronika Dasar',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1qllL65nu-yRliH3IPzlSRLIRGi4ETeYv'),
            const ItemBank(
                txt: 'Jaringan dan Komputer Data 1',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1qK4vaRt1SGIGYdPkrEyLRWYoRx19ziUS'),
            const ItemBank(
                txt: 'Metode Numerik',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1gN3l8YjeEvXAKMWLC1aIrVDOZ-wwrx5x'),
            const ItemBank(
                txt: 'Literasi Data',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1pA4EbMKhUmtjfFt9qu6w8ENgeM_wdU0f'),
            const ItemBank(
                txt: 'Probabilitas dan Statistika',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1GxrH_rRUv4H5nDeFmI1oTZbKWORJEZIf'),
          ]),
          buildItemList('Tingkat 3', [
            const ItemBank(
                txt: 'Jaringan dan Komputer Data 2',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1Sp0WXx5DvDDal5Vqqei_M70Q4eQ059Ae?usp=sharing'),
            const ItemBank(
                txt: 'Keamanan Sistem Komputer',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1EbA_Rb9BLt96eCS1XcqfQHH7YCyDLSFL?usp=sharing'),
            const ItemBank(
                txt: 'Kewirausahaan',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/11QK8E2KLir6iHdrk3TNBfKYIeJE0-aop'),
            const ItemBank(
                txt: 'Komputasi Awan',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1o3hKmLjTT3VIt0iK7VcWW11MQNmO2YvJ'),
            const ItemBank(
                txt: 'Mikroprosessor dan Antarmuka',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1BEjoRh7cJ_MDAwdp3geqVebXQdmF3JwX?usp=sharing'),
            const ItemBank(
                txt: 'Pendidikan Agama dan Etika',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/13134A5cARFpLlySYQjxsxvcZGSIYJvQS?usp=sharing'),
            const ItemBank(
                txt: 'Sistem Operasi',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1ygSsdmPSTxfTM5IyRCLq4q-8ALf3bZe6?usp=sharing'),
            const ItemBank(
                txt: 'Dasar Perancangan Perangkat Lunak',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/10mVXrERehCUH4wGlm5ofNOrlo8tyMotG?usp=sharing'),
            const ItemBank(
                txt: 'Kecerdasan Buatan',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/18wxzr8YFvgORvGXCHWzL82kedihP4T5K'),
            const ItemBank(
                txt: 'Organisasi dan Arsitektur Komputer',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1WPIrstfX875EDdTi9BK4RCvm3pQOUsge'),
            const ItemBank(
                txt: 'Pendidikan Pancasila',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1Dozd0JEByJRFk0zthF-iaDGXByEyrhWV?usp=sharing'),
            const ItemBank(
                txt: 'Pengolahan Sistem Digital',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/1BVOLnoRwNVjQwxEUOj7D0A07rIokZCo2'),
            const ItemBank(
                txt: 'Sistem Kendali Mekanik',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/17U2YCb91BMoAhmYKXfvdEq_qcuFeoD5q'),
          ]),
          buildItemList('Tingkat 4', [
            const ItemBank(
                txt: 'Manajemen Proyek',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1pkFsQTrV92KGY40lTnYYqMTPS-8fdhR2?usp=sharing'),
            const ItemBank(
                txt: 'Pemrograman Mobile',
                color: Colors.green,
                url:
                    'https://drive.google.com/drive/folders/15N_3MljWFm5w_7cA1DvU7vNSgzNxh0QX?usp=sharing'),
            const ItemBank(
                txt: 'Stadium General',
                color: Color.fromARGB(255, 96, 221, 100),
                url:
                    'https://drive.google.com/drive/folders/1u-vx1Y8UI3m-csqeI8URQGWZt_TG42Dd?usp=sharing'),
          ]),
        ],
      ),
    );
  }

  Widget buildItemList(String level, List<ItemBank> items) {
    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.only(bottom: 15),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade300),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: items.map((item) {
                        return ItemBank(
                          txt: item.txt,
                          color: item.color,
                          url: item.url,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 35,
            child: Container(
              height: 50,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.green),
              child: Text(
                level,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
