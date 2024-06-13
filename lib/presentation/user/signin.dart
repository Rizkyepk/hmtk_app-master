import 'dart:convert';
import 'dart:io';
import 'package:hmtk_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/dashboard.dart';
import 'package:hmtk_app/presentation/user/forgot_password.dart';
import 'package:hmtk_app/presentation/user/home.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/widget/button.dart';
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
  // String profileID = ''; // Variabel untuk menyimpan NIM
  bool _rememberMe = false; // Tambahkan variabel rememberMe

  // login info
  String? userType;
  int? id;

  SharedPreferences? prefs; // Deklarasikan variabel prefs

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _initializePreferences();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Fungsi untuk menginisialisasi SharedPreferences
  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveLoginInfo(String userType, int id, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_type', userType);
    await prefs.setInt('id', id);
    await prefs.setString('name', name);
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
          if (_rememberMe) {
            prefs?.setString('userData', response.body);
          }

          if (userType == 'mahasiswa') {
            // save login info
            await SaveData.saveAuth(data["auth"]);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
              (route) => false,
            );
          } else if (userType == 'admin') {
            // save login info
            await SaveData.saveAuth(data["auth"]);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
              (route) => false,
            );
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
        title: 'Email dan password yang anda masukkan salah!',
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
            height: MediaQuery.of(context).size.height * 0.25,
            child: Image.asset('assets/LOGO TK.png'),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
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
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorPallete.greenprim.withOpacity(0.3),
                  ),
                  child: 
                  TextFormField(
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
                          )),
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
                  child: 
                  TextFormField(
                    controller: password,
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      hintText: '******',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      border: InputBorder.none,
                      prefixIcon: Container(
                          width: 100,
                          alignment: Alignment.centerLeft,
                          child: const Text(
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
                                builder: (context) => const ForgotPassword(),
                              ));
                        },
                        child: const Text(
                          'Forgot password?',
                        ))
                  ],
                ),
                //user memilih untuk mengingat login-nya
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                    const Text(
                      'Remember Me',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: _login,
                    child: const MyButton(
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
        HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
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
