import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/dashboard.dart';
import 'package:hmtk_app/presentation/user/forgot_password.dart';
import 'package:hmtk_app/presentation/user/home.dart';
import 'package:hmtk_app/presentation/user/reset_password.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/main_navigator.dart';
import 'package:hmtk_app/widget/template_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var email = TextEditingController();
  var password = TextEditingController();
  bool isVisible = false;
  late int profileID; // Variabel untuk menyimpan NIM

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

  //fungsi login
  Future<void> _login() async {
    final String inputEmail = email.text;
    final String inputPassword = password.text;

    try {
      final response = await fetchData(inputEmail, inputPassword);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool success = data['success'];

        final String userType = data['auth']['user_type'];

        if (success) {
          if (userType == 'mahasiswa') {
            profileID = data['auth']['user']['nim']; // Simpan value NIM
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false,
            );
          } else if (userType == 'admin') {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
              (route) => false,
            );
          } else {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'Email dan password yang anda masukkan salah!',
              btnOkOnPress: () {},
            ).show();
          }
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Login gagal: ${data['message']}',
            btnOkOnPress: () {},
          ).show();
        }
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Terjadi kesalahan: $e',
        btnOkOnPress: () {},
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
            margin: EdgeInsets.only(bottom: 20),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Image.asset('assets/LOGO TK.png'),
          ),
          Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ColorPallete.greenprim),
                ),
                Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: ColorPallete.greenprim),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPallete.greenprim),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorPallete.greenprim.withOpacity(0.3),
                  ),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: 'example@gmail.com',
                      border: InputBorder.none,
                      prefixIcon: Container(
                          width: 100,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorPallete.greenprim.withOpacity(0.3),
                  ),
                  child: TextFormField(
                    controller: password,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      hintText: '',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      border: InputBorder.none,
                      prefixIcon: Container(
                          width: 100,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ));
                        },
                        child: Text(
                          'Forgot password?',
                        ))
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: _login,
                    child: MyButton(
                      txt: 'Login',
                      height: 45,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

Future<http.Response> fetchData(String email, String password) async {
  try {
    Map<String, String> params = {
      'email': email,
      'password': password,
    };

    var response = await http.post(
      Uri(
        scheme: 'https',
        host: 'myhmtk.jeyy.xyz',
        path: '/auth/login',
        queryParameters: params,
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer myhmtk-app-key',
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials": "*",
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "*",
      },
    );

    return response;
  } catch (e) {
    throw Exception('Failed to load: $e');
  }
}
