import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/dashboard.dart';
import 'package:hmtk_app/presentation/user/home.dart';
import 'package:hmtk_app/presentation/user/start.dart';
import 'package:hmtk_app/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _start = 1;

  startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            SaveData.getAuth().then((value) {
              if (value['user_type'] == 'mahasiswa') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              } else if (value['user_type'] == 'admin') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                );
              }
            }).catchError((e) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Start(),
                  ));
            });
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/bg-4.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/LogoTK3.png'),

              CircularProgressIndicator(
                strokeWidth: 5,
                color: Color.fromARGB(255, 170, 170, 170),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
