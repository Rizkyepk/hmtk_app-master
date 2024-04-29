import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/color_pallete.dart';

class MyButton extends StatelessWidget {
  String txt;

  double height;
  double width;

  MyButton({required this.txt, this.height = 50, this.width = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      child: Text(
        txt,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: ColorPallete.blue),
    );
  }
}
