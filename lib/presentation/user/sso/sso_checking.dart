import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/home.dart';
import 'package:hmtk_app/presentation/user/start.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:http/http.dart';

class SsoChecking extends StatefulWidget {
  final Map<String, dynamic> ssoData;
  const SsoChecking({super.key, required this.ssoData});

  @override
  State<SsoChecking> createState() => _SsoCheckingState();
}

class _SsoCheckingState extends State<SsoChecking> {
  bool _agreeToPrivacyPolicy = false;

  Future<void> getStudent() async {
    print("---------------- CHECKING ONE ------------------");
    if (widget.ssoData["studyprogram"] != "S1 Teknik Komputer") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Login Gagal: Anda bukan mahasiswa Teknik Komputer',
        btnOkOnPress: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Start(),
              ));
        },
      ).show();
    }

    try {
      var response = await get(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/student/${widget.ssoData["numberid"]}',
        ),
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          await loginStudent();
        } else {
          // ask privacy
          showPrivacyPolicyDialog();
        }
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw "Failed: $e";
    }
  }

  Future<void> registerStudent() async {
    try {
      Map<String, dynamic> params = {
        'nim': widget.ssoData["numberid"],
        'name': toTitleCase(widget.ssoData["fullname"]),
        'tel': widget.ssoData["phone"],
        'email': widget.ssoData["email"],
        'avatar_url': widget.ssoData["photo"],
        'address': widget.ssoData["address"] + ", " + widget.ssoData["zipcode"],
        'password': widget.ssoData["numberid"] +
            widget.ssoData["fullname"] +
            widget.ssoData["email"],
      };

      var response = await post(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/student',
          queryParameters: params,
        ),
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          await SaveData.saveAuth({
            "user_type": "mahasiswa",
            "user": {
              'nim': int.parse(widget.ssoData["numberid"]),
              'name': toTitleCase(widget.ssoData["fullname"]),
              'tel': int.parse(widget.ssoData["phone"]),
              'email': widget.ssoData["email"],
              'avatar_url': widget.ssoData["photo"],
              'address':
                  widget.ssoData["address"] + ", " + widget.ssoData["zipcode"],
            }
          });

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ));
        } else {
          if (!data["message"].startsWith("Data mahasiswa dengan NIM ")) {
            throw data["message"];
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ));
          }
        }
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw "Failed: $e";
    }
  }

  Future<void> loginStudent() async {
    try {
      Map<String, dynamic> params = {
        'email': widget.ssoData["email"],
        'password': widget.ssoData["numberid"] +
            widget.ssoData["fullname"] +
            widget.ssoData["email"],
      };

      var response = await post(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/auth/login',
          queryParameters: params,
        ),
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          await SaveData.saveAuth(data["auth"]);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ));
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

  void showPrivacyPolicyDialog() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Privacy Policy'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              const Text(
                '''
Please read and agree to our privacy policy to proceed.

Kebijakan Privasi dan Penggunaan Data

Dengan menggunakan aplikasi mobile My-HMTK, Anda memberikan persetujuan untuk pengumpulan dan penggunaan informasi pribadi Anda untuk tujuan-tujuan berikut:

1. Autentikasi dan Verifikasi : Nama, jurusan, nomor telepon, alamat, email universitas, dan foto profil Anda akan dikumpulkan dan digunakan untuk mengautentikasi bahwa Anda adalah mahasiswa yang valid dari program Teknik Komputer di Universitas Telkom.
2. Penyediaan Layanan : Informasi pribadi Anda akan digunakan untuk menyediakan layanan yang disesuaikan dengan kebutuhan Anda sebagai pengguna aplikasi My-HMTK, termasuk pengelolaan profil dan akses ke informasi yang relevan dengan jurusan Anda.
3. Tujuan E-commerce : Nomor telepon dan alamat Anda akan digunakan untuk keperluan transaksi e-commerce yang terintegrasi dalam aplikasi, seperti pembelian barang atau layanan yang ditawarkan oleh Himpunan Mahasiswa Teknik Komputer.
4. Keamanan : Kami akan menggunakan informasi Anda untuk menjaga keamanan akun Anda dan memantau aktivitas yang mencurigakan atau tidak sah untuk melindungi privasi dan integritas data Anda.

Kami menjamin bahwa semua data yang dikumpulkan akan ditangani dengan kerahasiaan yang tinggi dan hanya digunakan sesuai dengan tujuan-tujuan yang disebutkan di atas. 

Dengan mencentang kotak "Setuju" berikut ini, Anda mengakui bahwa Anda telah membaca, memahami, dan menyetujui kebijakan privasi ini.
                ''',
                textAlign: TextAlign.justify,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _agreeToPrivacyPolicy,
                    onChanged: (bool? value) {
                      setState(() {
                        _agreeToPrivacyPolicy = value!;
                      }
                      );
                    },
                  ),
                  const Text('Setuju'),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Start()),
              );
            },
            child: const Text('Back'),
          ),
          TextButton(
            onPressed: _agreeToPrivacyPolicy
                ? () {
                    Navigator.of(context).pop();
                    registerStudent();
                  }
                : null,
            child: const Text('Agree'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: ColorPallete.greensec),
          child: Row(
            children: [
              SizedBox(height: AppBar().preferredSize.height),
              FutureBuilder(
                future: getStudent(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Row(
                      children: [
                        Text("Verifying Login Info...",
                            style: TextStyle(color: Colors.white)),
                        CircularProgressIndicator()
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.white));
                  } else {
                    return const Text("",
                        style: TextStyle(color: Colors.white));
                  }
                },
              ),
            ],
          )),
    );
  }
}
