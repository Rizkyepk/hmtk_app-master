import 'package:flutter/material.dart';

class ItemActivity extends StatefulWidget {
  const ItemActivity({super.key});

  @override
  State<ItemActivity> createState() => _ItemActivityState();
}

class _ItemActivityState extends State<ItemActivity> {
  bool tapFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 300,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/img-futsal.png',
                    height: 200,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    'Glotroopers menang dramatis lewat adu penalti!',
                    style: TextStyle(color: Colors.green),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade50.withOpacity(0.5),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    tapFavorite = !tapFavorite;
                  });
                },
                icon: tapFavorite
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 25,
                      )
                    : const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 25,
                      )),
          ),
        )
      ],
    );
  }
}
