import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/home.dart';
import 'package:hmtk_app/presentation/user/signin.dart';
import 'package:hmtk_app/presentation/user/signup.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/button.dart';

import '../../utils/color_pallete.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    var auth = await SaveData.getAuth();
    if (auth != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false,
      );
    }
  }

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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignIn(),
                          ));
                    },
                    child: const MyButton(
                      txt: 'Login',
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
                            builder: (context) => const SignUp(),
                          ));
                    },
                    child: const MyButton(
                      txt: 'Sign  Up',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
