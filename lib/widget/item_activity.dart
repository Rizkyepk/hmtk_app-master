import 'package:flutter/material.dart';

class ItemActivity extends StatefulWidget {
  final String title;
  final String imgUrl;
  const ItemActivity({super.key, required this.title, required this.imgUrl});

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
                  child: Image.network(
                    widget.imgUrl,
                    height: 200,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.title,
                    style: const TextStyle(color: Colors.green),
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
