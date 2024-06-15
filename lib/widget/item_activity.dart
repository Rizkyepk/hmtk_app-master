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
                  child: Stack(
                    children: [
                      Image.network(
                        widget.imgUrl,
                        height: 200,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return SizedBox(
                              height: 200,
                              width: double.maxFinite,
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
        // Positioned(
        //   top: 10,
        //   right: 10,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.grey.shade50.withOpacity(0.5),
        //     child: IconButton(
        //         onPressed: () {
        //           setState(() {
        //             tapFavorite = !tapFavorite;
        //           });
        //         },
        //         icon: tapFavorite
        //             ? const Icon(
        //                 Icons.favorite,
        //                 color: Colors.red,
        //                 size: 25,
        //               )
        //             : const Icon(
        //                 Icons.favorite,
        //                 color: Colors.white,
        //                 size: 25,
        //               )),
        //   ),
        // )
      ],
    );
  }
}
