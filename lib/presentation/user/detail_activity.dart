import 'package:flutter/material.dart';

class DetailActivity extends StatefulWidget {
  const DetailActivity({super.key});

  @override
  State<DetailActivity> createState() => _DetailActivityState();
}

class _DetailActivityState extends State<DetailActivity> {
  bool tapFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CircleAvatar(
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
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/img-futsal.png',
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Watch a match!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Tekkom VS Elektro',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 150,
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: double.maxFinite,
                  padding:
                      const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'KBAA Champion',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        'Informasi',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Glotroopers menang dramatis lewat adu penalti!',
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Lokasi',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        'assets/maps.png',
                        height: 180,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
