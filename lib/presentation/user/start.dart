import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/signin.dart';
import 'package:hmtk_app/presentation/user/sso/sso_login.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/color_pallete.dart';

class Start extends StatelessWidget {
  const Start({super.key});

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
