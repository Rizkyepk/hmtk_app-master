import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/signin.dart';
import 'package:hmtk_app/presentation/user/sso/sso_login.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/color_pallete.dart';

class Start extends StatelessWidget {
  const Start({super.key});

//   void _showPrivacyPolicyDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         bool isChecked = false;
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: const Text('Privacy Policy'),
//               content: SizedBox(
//                 width: double.maxFinite,
//                 child: ListView(
//                   shrinkWrap: true,
//                   children: [
//                     const Text(
//                       '''Please agree to our Privacy Policy to continue

// Dengan menggunakan aplikasi mobile My-HMTK, Anda memberikan persetujuan untuk pengumpulan dan penggunaan informasi pribadi Anda untuk tujuan-tujuan berikut:

// 1. Autentikasi dan Verifikasi : Nama, jurusan, nomor telepon, alamat, email universitas, dan foto profil Anda akan dikumpulkan dan digunakan untuk mengautentikasi bahwa Anda adalah mahasiswa yang valid dari program Teknik Komputer di Universitas Telkom.
// 2. Penyediaan Layanan : Informasi pribadi Anda akan digunakan untuk menyediakan layanan yang disesuaikan dengan kebutuhan Anda sebagai pengguna aplikasi My-HMTK, termasuk pengelolaan profil dan akses ke informasi yang relevan dengan jurusan Anda.
// 3. Tujuan E-commerce : Nomor telepon dan alamat Anda akan digunakan untuk keperluan transaksi e-commerce yang terintegrasi dalam aplikasi, seperti pembelian barang atau layanan yang ditawarkan oleh Himpunan Mahasiswa Teknik Komputer.
// 4. Keamanan : Kami akan menggunakan informasi Anda untuk menjaga keamanan akun Anda dan memantau aktivitas yang mencurigakan atau tidak sah untuk melindungi privasi dan integritas data Anda.

// Kami menjamin bahwa semua data yang dikumpulkan akan ditangani dengan kerahasiaan yang tinggi dan hanya digunakan sesuai dengan tujuan-tujuan yang disebutkan di atas.

// Dengan mencentang kotak "Setuju" berikut ini, Anda mengakui bahwa Anda telah membaca, memahami, dan menyetujui kebijakan privasi ini.
//                       ''',
//                     ),
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: isChecked,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               isChecked = value ?? false;
//                             });
//                           },
//                         ),
//                         const Text('Setuju'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: isChecked
//                       ? () {
//                           Navigator.of(context).pop();
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const SsoLogin(),
//                             ),
//                           );
//                         }
//                       : null,
//                   child: const Text('Agree'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/bg.png',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 20,
            bottom: 400,
            child: Image.asset(
              'assets/LOGO TK.png',
              width: 316,
              height: 308,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: ColorPallete.greenprim,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(50))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // _showPrivacyPolicyDialog(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SsoLogin(),
                          ));
                    },
                    child: const MyButton(
                      txt: 'SSO Login',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'or',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignIn(),
                          ));
                    },
                    child: const MyButton(
                      width: 120,
                      txt: 'Login Admin',
                    ),
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.all(15.0),
                  //   child: Text(
                  //     'or',
                  //     style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => const SignUp(),
                  //         ));
                  //   },
                  //   child: const MyButton(
                  //     txt: 'Sign  Up',
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 15,
            child: IconButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.rightSlide,
                    title: 'Butuh bantuan?',
                    btnOkText: 'Hubungi',
                    btnOkOnPress: () async {
                      if (!await launchUrl(
                          Uri.parse('https://linktr.ee/HMTK_TELU'))) {
                        throw Exception('Ada masalah');
                      }
                    },
                  ).show();
                },
                icon: const Icon(
                  Icons.help_outline_rounded,
                  color: Colors.white,
                  size: 40,
                )),
          )
        ],
      ),
    );
  }
}
