
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/account.dart';
import 'package:hmtk_app/utils/color_pallete.dart';

import '../presentation/user/home.dart';
import '../presentation/user/timeline.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 1;
  final List<Widget> _screen = [
    const Timeline(),
    const Home(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screen[_selectedIndex],
        bottomNavigationBar: Container(
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              // borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                backgroundColor: ColorPallete.greenprim,
                selectedItemColor: ColorPallete.greensec,
                unselectedItemColor: Colors.white,
                items: [
                  BottomNavigationBarItem(
                      icon: Image.asset('assets/timeline.png'),
                      label: 'Timeline'),
                  const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: 'Home'),
                  const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      label: 'Account'),
                ],
                onTap: (i) {
                  setState(() {
                    _selectedIndex = i;
                  });
                },
              ),
            )));
  }
}
