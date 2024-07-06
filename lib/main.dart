// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
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

  //notif
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Notification Alerts',
        channelDescription: 'Notification tests as alerts',
      ),
    ],
    debug: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  // // TODO: implement key
  // void initState() {
  //   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  //     if (!isAllowed) {
  //       AwesomeNotifications().requestPermissionToSendNotifications();
  //     }
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    _checkNotificationPermission();

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            appBarTheme: AppBarTheme(
              color: ColorPallete.greenprim,
              elevation: 0.8,
            ),
          ),
        );
      },
    );
  }

  void _checkNotificationPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }
}
