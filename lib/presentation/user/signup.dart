import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/template_page.dart';

import 'signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var fullname = TextEditingController();
  var nim = TextEditingController();
  var notelp = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
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

  void _register() async {
    // Retrieve input values from controllers
    String fullNameValue = fullname.text;
    String nimValue = nim.text;
    String noTelpValue = notelp.text;
    String emailValue = email.text;
    String passwordValue = password.text;

    try {
      // Send data to API
      var response = await addData(
          fullNameValue, nimValue, noTelpValue, emailValue, passwordValue);

      // Check API response
      if (response.statusCode == 200) {
        // Show success dialog
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Register berhasil!',
          btnOkOnPress: () {},
        ).show();
      } else {
        // Show error dialog if failed
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Gagal menyimpan data',
          desc: 'Terjadi kesalahan saat menyimpan data.',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      // Show error dialog if an error occurred
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Terjadi kesalahan: $e',
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
              margin: const EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset(
                'assets/LOGO TK.png',
                height: 80,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.75,
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorPallete.greenprim,
                    ),
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: ColorPallete.greenprim,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorPallete.greenprim,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorPallete.greenprim.withOpacity(0.3),
                    ),
                    child: TextFormField(
                      controller: fullname,
                      decoration: InputDecoration(
                        hintText: 'Ivan Daniar',
                        border: InputBorder.none,
                        prefixIcon: Container(
                          width: 100,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Full Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorPallete.greenprim.withOpacity(0.3),
                    ),
                    child: TextFormField(
                      controller: nim,
                      decoration: InputDecoration(
                        hintText: '110320....',
                        border: InputBorder.none,
                        prefixIcon: Container(
                          width: 100,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'NIM',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorPallete.greenprim.withOpacity(0.3),
                    ),
                    child: TextFormField(
                      controller: notelp,
                      decoration: InputDecoration(
                        hintText: '',
                        border: InputBorder.none,
                        prefixIcon: Container(
                          width: 100,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'No Telp',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.only(left: 15, right: 15),
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
                          child: const Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorPallete.greenprim.withOpacity(0.3),
                    ),
                    child: TextFormField(
                      controller: password,
                      obscureText: isVisible,
                      decoration: InputDecoration(
                        hintText: '*****',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: InputBorder.none,
                        prefixIcon: Container(
                          width: 100,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Password',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Already a member?',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignIn(),
                              ));
                        },
                        child: const Text('Login'),
                      )
                    ],
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: _register,
                        child: MyButton(
                          txt: 'Register',
                          height: 45,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<http.Response> addData(String fullName, String nim, String noTelp,
    String email, String password) async {
  try {
    Map<String, dynamic> params = {
      'nim': nim,
      'name': fullName,
      'tel': noTelp,
      'email': email,
      'password': password,
    };

    var response = await http.post(
      Uri(
        scheme: 'https',
        host: 'myhmtk.jeyy.xyz',
        path: '/student',
        queryParameters: params,
      ),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer myhmtk-app-key',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(params),
    );

    return response;
  } catch (e) {
    throw Exception('Failed to load: $e');
  }
}
