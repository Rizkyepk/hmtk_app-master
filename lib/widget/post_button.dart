import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/timeline_post.dart';
import 'package:hmtk_app/utils/color_pallete.dart';

InkWell postButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TimelinePost(),
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 50,
        width: 110,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorPallete.blue),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.add, color: Colors.blue)),
            SizedBox(
              width: 5,
            ),
            Text(
              'Post',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )
          ],
        ),
      ),
    );
  }