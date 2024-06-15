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
          await registerStudent();
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
        'name': widget.ssoData["fullname"],
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
              'nim': widget.ssoData["numberid"],
              'name': widget.ssoData["fullname"],
              'tel': int.tryParse(widget.ssoData["phone"]),
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
