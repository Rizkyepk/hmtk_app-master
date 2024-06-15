import 'dart:convert';

import 'package:hmtk_app/presentation/user/signin.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/template_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var email = TextEditingController();

  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchData(String email) async {
    try {
      Map<String, String> params = {
        'email': email,
      };

      var response = await http.post(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/auth/reset_password',
          queryParameters: params,
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          // "Access-Control-Allow-Origin":"*",
          // "Access-Control-Allow-Credentials": "*",
          // "Access-Control-Allow-Headers": "*",
          // "Access-Control-Allow-Methods": "*",
        },
      );

      Map data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data["Success"]) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Email dikirim!\n!CEK FOLDER SPAM ANDA!',
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignIn()),
              );
            },
          ).show();
        } else {
          throw data["message"];
        }
        // Show success dialog
      } else {
        // Show error dialog
        throw "Status Code: ${response.statusCode}";
      }
    } catch (e) {
      // Show error dialog
      // String error = e.toString();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Error',
        desc: 'Failed to send: $e',
        btnOkOnPress: () {
          // Navigator.pop(context);
        },
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyPage(
        widget: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image.asset('assets/LOGO TK.png'),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ColorPallete.greenprim,
                    ),
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: ColorPallete.greenprim,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'FORGOT PASSWORD',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorPallete.greenprim,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorPallete.greenprim.withOpacity(0.3),
                    ),
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        if (email.text.isEmpty) {
                          // Show Awesome Dialog for prompting to enter email
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            title: 'Awesom!',
                            desc: 'Masukkan email terlebih dahulu.',
                            btnOkOnPress: () {},
                          ).show();
                        } else {
                          fetchData(email.text);
                        }
                      },
                      child: const MyButton(
                        txt: 'Kirim email',
                        height: 45,
                        width: 130,
                      ),
                    ),
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
