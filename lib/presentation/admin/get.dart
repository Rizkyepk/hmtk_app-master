import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;

class Get extends StatelessWidget {
  const Get({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 100,
            child: Container(
                child: Center(
              child: Image(
                image: AssetImage('assets/LogoTK3.png'),
              ),
            )),
          ),
          Positioned(
            bottom: 0.100,
            child: Image(
              image: AssetImage('assets/getback.png'),
            ),
          ),
          Positioned(
            bottom: 0.100,
            child: Image(
              image: AssetImage('assets/getfront.png'),
            ),
          ),
          Positioned(
            bottom: 95,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'My-HMTK',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // primary: Color.fromARGB(255, 248, 248, 248),
                            backgroundColor: Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.4),
                            foregroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            fixedSize: const Size(80, 50),
                          ),
                          onPressed: () {},
                          child: Text('Admin')),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // primary: Color.fromARGB(255, 248, 248, 248),
                            backgroundColor: Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.4),
                            foregroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            fixedSize: const Size(80, 50),
                          ),
                          onPressed: () {},
                          child: Text('User')),
                    ],
                  )
                ],
              ),
            ),
          ),

          // Back image
          // Image(), // Front image
        ],
      ),
    );
  }
}
