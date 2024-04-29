import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/account.dart';
import 'package:hmtk_app/presentation/admin/daftar_about_us.dart';
import 'package:hmtk_app/presentation/admin/daftar_aktivity.dart';
import 'package:hmtk_app/presentation/admin/daftar_bph.dart';
import 'package:hmtk_app/presentation/admin/daftar_funtk.dart';
import 'package:hmtk_app/presentation/admin/daftar_material_bank.dart';
import 'package:hmtk_app/presentation/admin/daftar_shop.dart';
import 'package:hmtk_app/presentation/admin/daftar_timeline.dart';
import 'package:hmtk_app/presentation/admin/daftar_visi_misi.dart';
import 'package:hmtk_app/presentation/admin/daftar_laboratory.dart';
import 'package:hmtk_app/presentation/admin/data_pesanan.dart';
import 'package:hmtk_app/presentation/admin/tambah_about_us.dart';
import 'package:hmtk_app/presentation/admin/tambah_aktivty.dart';
import 'package:hmtk_app/presentation/admin/tambah_bph.dart';
import 'package:hmtk_app/presentation/admin/tambah_fun_tk.dart';
import 'package:hmtk_app/presentation/admin/tambah_lab.dart';
import 'package:hmtk_app/presentation/admin/tambah_material_bank.dart';
import 'package:hmtk_app/presentation/admin/tambah_shop.dart';
import 'package:hmtk_app/presentation/admin/tambah_visi_misi.dart';

import 'package:hmtk_app/presentation/user/start.dart';

import 'package:hmtk_app/utils/color_pallete.dart';

import '../presentation/admin/daftar_aspirasi.dart';

class ActivityDialog extends StatelessWidget {
  const ActivityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Set latar belakang menjadi transparan
      content: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        height: 100,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: const Alignment(0.0,
                0.5), // Sesuaikan titik akhir untuk membuat opacity pada bagian kanan
            colors: [
              ColorPallete.greenprim.withOpacity(0.3),
              ColorPallete.greenprim
            ], // Warna hijau dengan sedikit opasitas pada bagian kanan
          ),
        ),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: const Text(
                  'Tambah Activity',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahActivty(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              GestureDetector(
                child: const Text('Daftar Activity',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarAktivity(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AspirasiDialog extends StatelessWidget {
  const AspirasiDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Set latar belakang menjadi transparan
      content: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        height: 60,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: const Alignment(0.0,
                0.5), // Sesuaikan titik akhir untuk membuat opacity pada bagian kanan
            colors: [
              ColorPallete.greenprim.withOpacity(0.3),
              ColorPallete.greenprim
            ], // Warna hijau dengan sedikit opasitas pada bagian kanan
          ),
        ),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              // GestureDetector(
              //   child: const Text(
              //     'Masukan Aspirasi',
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   onTap: () {
              //     // Navigator.pop(context);
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const InputAspirasi(),
              //       ),
              //     );
              //   },
              // ),
              // Divider(
              //   color: Colors.grey.shade300,
              // ),
              GestureDetector(
                child: const Text(
                  'Daftar Aspirasi',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarAspirasi(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityFrame extends StatelessWidget {
  const ActivityFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Set latar belakang menjadi transparan
      content: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        height: 180,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: const Alignment(0.0,
                0.5), // Sesuaikan titik akhir untuk membuat opacity pada bagian kanan
            colors: [
              ColorPallete.greenprim.withOpacity(0.3),
              ColorPallete.greenprim
            ], // Warna hijau dengan sedikit opasitas pada bagian kanan
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text(
                      'Account',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountEdit(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 150, 0),
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Start(),
                          ),
                          (route) => false);
                      // Navigator.pop(context);
                      // SystemNavigator.pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FuntkDialog extends StatelessWidget {
  const FuntkDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Set latar belakang menjadi transparan
      content: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        height: 100,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: const Alignment(0.0,
                0.5), // Sesuaikan titik akhir untuk membuat opacity pada bagian kanan
            colors: [
              ColorPallete.greenprim.withOpacity(0.3),
              ColorPallete.greenprim
            ], // Warna hijau dengan sedikit opasitas pada bagian kanan
          ),
        ),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: const Text(
                  'Tambah Fun TK',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahFunTk(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              GestureDetector(
                child: const Text('Daftar Fun TK',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarFuntk(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopDialog extends StatelessWidget {
  const ShopDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Set latar belakang menjadi transparan
      content: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        height: 140,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: const Alignment(0.0,
                0.5), // Sesuaikan titik akhir untuk membuat opacity pada bagian kanan
            colors: [
              ColorPallete.greenprim.withOpacity(0.3),
              ColorPallete.greenprim
            ], // Warna hijau dengan sedikit opasitas pada bagian kanan
          ),
        ),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: const Text(
                  'Tambah Produk',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahShop(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              // GestureDetector(
              //   child: Text(
              //     'Edit Shop',
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => EditShop(),
              //       ),
              //     );
              //   },
              // ),
              GestureDetector(
                child: const Text(
                  'Daftar Shop',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarShop(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              GestureDetector(
                child: const Text('Data Pesanan',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DataPesanan(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabDialog extends StatelessWidget {
  const LabDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Set latar belakang menjadi transparan
      content: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        height: 100,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: const Alignment(0.0,
                0.5), // Sesuaikan titik akhir untuk membuat opacity pada bagian kanan
            colors: [
              ColorPallete.greenprim.withOpacity(0.3),
              ColorPallete.greenprim
            ], // Warna hijau dengan sedikit opasitas pada bagian kanan
          ),
        ),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: const Text(
                  'Tambah Laboratory',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahLab(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              GestureDetector(
                child: const Text('Daftar Laboratory',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarLaboratory(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaterialBankDialog extends StatelessWidget {
  const MaterialBankDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Set latar belakang menjadi transparan
      content: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        height: 100,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: const Alignment(0.0,
                0.5), // Sesuaikan titik akhir untuk membuat opacity pada bagian kanan
            colors: [
              ColorPallete.greenprim.withOpacity(0.3),
              ColorPallete.greenprim
            ], // Warna hijau dengan sedikit opasitas pada bagian kanan
          ),
        ),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: const Text(
                  'Tambah Material Bank',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahmaterialBank(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              GestureDetector(
                child: const Text('Daftar Material Bank',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarMaterialBank(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutUsDialog extends StatelessWidget {
  const AboutUsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Set latar belakang menjadi transparan
      content: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        height: 100,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: const Alignment(0.0,
                0.5), // Sesuaikan titik akhir untuk membuat opacity pada bagian kanan
            colors: [
              ColorPallete.greenprim.withOpacity(0.3),
              ColorPallete.greenprim
            ], // Warna hijau dengan sedikit opasitas pada bagian kanan
          ),
        ),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: const Text(
                  'Tambah About Us',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahAboutUs(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              GestureDetector(
                child: const Text('Daftar  About Us',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarAboutUs(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VisiMisiDialog extends StatelessWidget {
  const VisiMisiDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Set latar belakang menjadi transparan
      content: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        height: 100,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: const Alignment(0.0,
                0.5), // Sesuaikan titik akhir untuk membuat opacity pada bagian kanan
            colors: [
              ColorPallete.greenprim.withOpacity(0.3),
              ColorPallete.greenprim
            ], // Warna hijau dengan sedikit opasitas pada bagian kanan
          ),
        ),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: const Text(
                  'Tambah Vision & Mision',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahVisiMisi(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              GestureDetector(
                child: const Text('Daftar Vision & Mision',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarVisiMisi(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BphDialog extends StatelessWidget {
  const BphDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Set latar belakang menjadi transparan
      content: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        height: 100,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: const Alignment(0.0,
                0.5), // Sesuaikan titik akhir untuk membuat opacity pada bagian kanan
            colors: [
              ColorPallete.greenprim.withOpacity(0.3),
              ColorPallete.greenprim
            ], // Warna hijau dengan sedikit opasitas pada bagian kanan
          ),
        ),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: const Text(
                  'Tambah BPH HMTK',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahBph(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              GestureDetector(
                child: const Text('Daftar BPH HMTK',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarBph(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimelineDialog extends StatelessWidget {
  const TimelineDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Set latar belakang menjadi transparan
      content: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        height: 70,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: const Alignment(0.0,
                0.5), // Sesuaikan titik akhir untuk membuat opacity pada bagian kanan
            colors: [
              ColorPallete.greenprim.withOpacity(0.3),
              ColorPallete.greenprim
            ], // Warna hijau dengan sedikit opasitas pada bagian kanan
          ),
        ),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: const Text(
                  'Daftar Timeline',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarTimeline(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
