import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';

import '../../../widget/show_more_text.dart';

class MenuLaboratoryDetail extends StatefulWidget {
  final String lab, gambar, title, deskripsi;

  const MenuLaboratoryDetail(
      {super.key,
      required this.lab,
      required this.gambar,
      required this.title,
      required this.deskripsi});

  @override
  State<MenuLaboratoryDetail> createState() => _MenuLaboratoryDetailState();
}

class _MenuLaboratoryDetailState extends State<MenuLaboratoryDetail> {
  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> posts0(String lab) async {
      try {
        final response = await fetchData(lab);

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final bool success = data["success"];
          if (!success) {
            throw Exception("Not success");
          }

          return List<Map<String, dynamic>>.from(data["lab_posts"]);
        } else {
          throw Exception("error");
        }
      } catch (e) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Terjadi kesalahan: $e',
          btnOkOnPress: () {},
        ).show();
        return [];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline Laboratorium'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/bg-2.png',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          ListView(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
            children: [
              Container(
                // height: 300,
                width: double.maxFinite,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  children: [
                    Image.asset(
                      widget.gambar,
                      height: 70,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DescriptionTextWidget(
                      text: widget.deskripsi,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: posts0(widget.lab),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final posts = snapshot.data!;

                      return ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: posts.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.asset(
                                          widget.gambar,
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            // '8 jam yang lalu',
                                            timeAgoFromIso(
                                                posts[index]["post_date"]),
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                // 'Info Running Modul Pengolaan sinyal digital',
                                posts[index]["content"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              if (posts[index]["img_url"] != null)
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            color: Colors.black54,
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.network(
                                                  posts[index]["img_url"],
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: Image.network(
                                        posts[index]["img_url"],
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              // Container(
                              //   color: Colors.grey.shade300,
                              //   height: 200,
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   children: [
                              //     IconButton(
                              //         onPressed: () {},
                              //         icon: const Icon(Icons.favorite_border,
                              //             color: Colors.blue)),
                              //     const Text(
                              //       '12.036 suka',
                              //       style: TextStyle(color: Colors.blue),
                              //     )
                              //   ],
                              // ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 0.8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     IconButton(
                                  //         onPressed: () {},
                                  //         icon: const Icon(
                                  //           Icons.favorite_border,
                                  //         )),
                                  //     const Text('Suka')
                                  //   ],
                                  // ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     showModalBottomSheet(
                                  //       context: context,
                                  //       shape: const RoundedRectangleBorder(
                                  //           borderRadius: BorderRadius.vertical(
                                  //               top: Radius.circular(35))),
                                  //       builder: (context) => Container(
                                  //         height: MediaQuery.of(context)
                                  //                 .size
                                  //                 .height *
                                  //             0.6,
                                  //         padding: const EdgeInsets.symmetric(
                                  //             vertical: 10, horizontal: 20),
                                  //         child: Column(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.start,
                                  //           children: [
                                  //             const Expanded(
                                  //               flex: 1,
                                  //               child: Column(
                                  //                 children: [
                                  //                   SizedBox(
                                  //                       width: 40,
                                  //                       child: Divider(
                                  //                         thickness: 4,
                                  //                       )),
                                  //                   Text(
                                  //                     'Komentar',
                                  //                     style: TextStyle(
                                  //                         fontSize: 18,
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   ),
                                  //                   Divider(
                                  //                     thickness: 0.8,
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             Expanded(
                                  //               flex: 5,
                                  //               child: ListView.builder(
                                  //                 shrinkWrap: true,
                                  //                 itemCount: 0,
                                  //                 padding:
                                  //                     const EdgeInsets.only(
                                  //                         top: 15),
                                  //                 itemBuilder:
                                  //                     (context, index) =>
                                  //                         InkWell(
                                  //                   child: Padding(
                                  //                     padding:
                                  //                         const EdgeInsets.only(
                                  //                             bottom: 25),
                                  //                     child: Row(
                                  //                       mainAxisAlignment:
                                  //                           MainAxisAlignment
                                  //                               .spaceBetween,
                                  //                       children: [
                                  //                         Row(
                                  //                           children: [
                                  //                             Image.asset(
                                  //                               'assets/profile.png',
                                  //                               width: 40,
                                  //                             ),
                                  //                             const SizedBox(
                                  //                               width: 10,
                                  //                             ),
                                  //                             const Column(
                                  //                               crossAxisAlignment:
                                  //                                   CrossAxisAlignment
                                  //                                       .start,
                                  //                               children: [
                                  //                                 Row(
                                  //                                   children: [
                                  //                                     Text(
                                  //                                       'Ivan Daniar',
                                  //                                       style: TextStyle(
                                  //                                           fontWeight:
                                  //                                               FontWeight.bold),
                                  //                                     ),
                                  //                                     SizedBox(
                                  //                                       width:
                                  //                                           10,
                                  //                                     ),
                                  //                                     Text(
                                  //                                       '8j',
                                  //                                       style: TextStyle(
                                  //                                           color:
                                  //                                               Colors.grey,
                                  //                                           fontSize: 12),
                                  //                                     ),
                                  //                                   ],
                                  //                                 ),
                                  //                                 Text(
                                  //                                   'Ayok yang bisa join',
                                  //                                   style: TextStyle(
                                  //                                       fontSize:
                                  //                                           12),
                                  //                                 ),
                                  //                               ],
                                  //                             ),
                                  //                           ],
                                  //                         ),
                                  //                         PopupMenuButton(
                                  //                           onSelected:
                                  //                               (value) {
                                  //                             // setState(() {
                                  //                             //   hapusKomentar =
                                  //                             //       value.toString();
                                  //                             // });
                                  //                           },
                                  //                           itemBuilder:
                                  //                               (BuildContext
                                  //                                   context) {
                                  //                             return const [
                                  //                               PopupMenuItem(
                                  //                                 value: '1',
                                  //                                 child: Row(
                                  //                                   children: [
                                  //                                     Text(
                                  //                                       "Hapus",
                                  //                                       style: TextStyle(
                                  //                                           color:
                                  //                                               Colors.red),
                                  //                                     ),
                                  //                                     Icon(
                                  //                                         Icons
                                  //                                             .delete,
                                  //                                         color:
                                  //                                             Colors.red)
                                  //                                   ],
                                  //                                 ),
                                  //                               ),
                                  //                             ];
                                  //                           },
                                  //                         )
                                  //                       ],
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Expanded(
                                  //               flex: 1,
                                  //               child: Container(
                                  //                 padding:
                                  //                     const EdgeInsets.only(
                                  //                         left: 5, right: 5),
                                  //                 margin:
                                  //                     const EdgeInsets.all(5),
                                  //                 decoration: BoxDecoration(
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(
                                  //                             15),
                                  //                     color:
                                  //                         Colors.grey.shade300),
                                  //                 child: Row(
                                  //                   children: [
                                  //                     Expanded(
                                  //                         flex: 1,
                                  //                         child: Image.asset(
                                  //                             'assets/girl.png')),
                                  //                     const SizedBox(
                                  //                       width: 10,
                                  //                     ),
                                  //                     Expanded(
                                  //                       flex: 7,
                                  //                       child: Row(
                                  //                         mainAxisAlignment:
                                  //                             MainAxisAlignment
                                  //                                 .spaceBetween,
                                  //                         children: [
                                  //                           const Expanded(
                                  //                             flex: 4,
                                  //                             child: TextField(
                                  //                               decoration: InputDecoration(
                                  //                                   border:
                                  //                                       InputBorder
                                  //                                           .none,
                                  //                                   hintStyle: TextStyle(
                                  //                                       fontSize:
                                  //                                           12),
                                  //                                   hintText:
                                  //                                       'Tambahkan komentar anda..'),
                                  //                             ),
                                  //                           ),
                                  //                           Expanded(
                                  //                               flex: 1,
                                  //                               child:
                                  //                                   IconButton(
                                  //                                       onPressed:
                                  //                                           () {},
                                  //                                       icon:
                                  //                                           const Icon(
                                  //                                         Icons
                                  //                                             .send,
                                  //                                         color:
                                  //                                             Colors.blue,
                                  //                                       )))
                                  //                         ],
                                  //                       ),
                                  //                     )
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             )
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: const Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //     children: [
                                  //       Icon(
                                  //         Icons.mode_comment_outlined,
                                  //       ),
                                  //       SizedBox(
                                  //         width: 5,
                                  //       ),
                                  //       Text(
                                  //         'Komentar',
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Share.share(
                                                    '${widget.title} memposting pada aplikasi MyHMTK ${timeAgoFromIso(posts[index]["post_date"])}:\n\n${posts[index]["content"]}\n',
                                                    subject:
                                                        'Postingan ${widget.title} di MyHMTK');
                                              },
                                              icon: const Icon(
                                                Icons.share,
                                              )),
                                          const Text('Bagi')
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  }),
            ],
          )
        ],
      ),
    );
  }
}

Future<Response> fetchData(String lab) async {
  try {
    Map<String, String> params = {'lab': lab};

    var response = await get(
        Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/lab_post',
            queryParameters: params),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
        });

    return response;
  } catch (e) {
    throw Exception('Failed to load: $e');
  }
}
