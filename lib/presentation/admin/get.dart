
import 'package:flutter/material.dart';

class Get extends StatelessWidget {
  const Get({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 100,
            child: Center(
                          child: Image(
            image: AssetImage('assets/LogoTK3.png'),
                          ),
                        ),
          ),
          const Positioned(
            bottom: 0.100,
            child: Image(
              image: AssetImage('assets/getback.png'),
            ),
          ),
          const Positioned(
            bottom: 0.100,
            child: Image(
              image: AssetImage('assets/getfront.png'),
            ),
          ),
          Positioned(
            bottom: 95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'My-HMTK',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // primary: Color.fromARGB(255, 248, 248, 248),
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.4),
                          foregroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          fixedSize: const Size(80, 50),
                        ),
                        onPressed: () {},
                        child: const Text('Admin')),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // primary: Color.fromARGB(255, 248, 248, 248),
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.4),
                          foregroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          fixedSize: const Size(80, 50),
                        ),
                        onPressed: () {},
                        child: const Text('User')),
                  ],
                )
              ],
            ),
          ),

          // Back image
          // Image(), // Front image
        ],
      ),
    );
  }
}
