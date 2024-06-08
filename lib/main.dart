import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sizer/sizer.dart';

import 'presentation/user/splash.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ColorPallete.greenprim,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(),
              appBarTheme:
                  AppBarTheme(color: ColorPallete.greenprim, elevation: 0.8)),
        );
      },
    );
  }
}
