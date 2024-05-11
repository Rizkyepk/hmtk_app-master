import 'package:flutter/material.dart';

import 'drawer_user.dart';

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
          Stack(
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
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        ItemBank(
                            txt: 'Bahasa Inggris',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(txt: 'Fisika 1', color: Colors.green),
                        ItemBank(
                            txt: 'Kalkulus 1',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Logika Matematika', color: Colors.green),
                        ItemBank(
                            txt: 'Pembetukan Karakter',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Pendidikan Kewarganegaraan',
                            color: Colors.green),
                        ItemBank(
                            txt: 'Pengantar Rekayasa dan Desain',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Pengenalan Teknik Komputer',
                            color: Colors.green),
                        ItemBank(
                            txt: 'Algoritma dan Pemrograman',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(txt: 'Biologi', color: Colors.green),
                        ItemBank(
                            txt: 'Fisika 2',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(txt: 'Kalkulus', color: Colors.green),
                        ItemBank(
                            txt: 'Interaksi Manusia dan Komputer',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Literasi Manusia', color: Colors.green),
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
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: const Text(
                    'Tingkat 1',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          Stack(
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
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        ItemBank(
                            txt: 'Bahasa Indonesia',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Desain Basis Data', color: Colors.green),
                        ItemBank(
                            txt: 'Matematika Dikret',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Matriks dan Ruang Vektor',
                            color: Colors.green),
                        ItemBank(
                            txt: 'Pemrograman Berorientasi Obyek',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Rangkaian Listrik Dasar',
                            color: Colors.green),
                        ItemBank(
                            txt: 'Desain Sistem Digital',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Elektronika Dasar', color: Colors.green),
                        ItemBank(
                            txt: 'Jaringan dan Komputer Data 1',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(txt: 'Metode Numerik', color: Colors.green),
                        ItemBank(
                            txt: 'Literasi Data',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Probabilitas dan Statistika',
                            color: Colors.green),
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
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: const Text(
                    'Tingkat 2',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          Stack(
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
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        ItemBank(
                            txt: 'Jaringan dan Komputer Data 2',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Keamanan Sistem Komputer',
                            color: Colors.green),
                        ItemBank(
                            txt: 'Kewirausahaan',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(txt: 'Komputasi Awan', color: Colors.green),
                        ItemBank(
                            txt: 'Mikroprosessor dan Antarmuka',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Pendidikan Agama dan Etika',
                            color: Colors.green),
                        ItemBank(
                            txt: 'Sistem Operasi',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Dasar Perancangan Perangkat Lunak',
                            color: Colors.green),
                        ItemBank(
                            txt: 'Kecerdasan Buatan',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Organisasi dan Arsitektur Komputer',
                            color: Colors.green),
                        ItemBank(
                            txt: 'Pendidikan Pancasila',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Pengolahan Sistem Digital',
                            color: Colors.green),
                        ItemBank(
                            txt: 'Sistem Kendali Mekanik',
                            color: Color.fromARGB(255, 96, 221, 100)),
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
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: const Text(
                    'Tingkat 3',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          Stack(
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
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        ItemBank(
                            txt: 'Manajemen Proyek',
                            color: Color.fromARGB(255, 96, 221, 100)),
                        ItemBank(
                            txt: 'Pemrograman Mobile', color: Colors.green),
                        ItemBank(
                            txt: 'Stadium General',
                            color: Color.fromARGB(255, 96, 221, 100)),
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
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: const Text(
                    'Tingkat 4',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemBank extends StatelessWidget {
  final String txt;
  final Color color;

  const ItemBank({super.key, required this.txt, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
        alignment: Alignment.center,
        color: color,
        child: Text(
          txt,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
