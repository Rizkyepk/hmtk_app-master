import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;
import 'package:http/http.dart';

class DaftarTimeline extends StatefulWidget {
  const DaftarTimeline({super.key});

  @override
  State<DaftarTimeline> createState() => _DaftarTimelineState();
}

class _DaftarTimelineState extends State<DaftarTimeline> {
  late List<Map<String, dynamic>> _postsData = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> deletePost(int postId) async {
    try {
      var response = await delete(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/post/$postId',
          ),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          // Tampilkan dialog sukses jika berhasil
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Berhasil menghapus post!',
            btnOkOnPress: () {
              _fetchPosts();
            },
          ).show();
        } else {
          throw data["message"];
        }
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      // Tampilkan dialog error jika gagal
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  Future<void> _fetchPosts() async {
    try {
      final response = await fetchData();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool success = data["success"];
        if (!success) {
          throw Exception("Not success");
        }

        final List<Map<String, dynamic>> posts =
            List<Map<String, dynamic>>.from(data["posts"]);

        setState(() {
          _postsData = posts;
        });
      } else {
        throw Exception("error");
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerScren(),
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 200,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ActivityFrame()),
                );
              },
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(38), // Image radius
                  child: Image.asset('assets/ftprofil.png', fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Hello, Ivan'))
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: ColorPallete.greenprim,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            height: 55,
            child: const Text(
              "Daftar Timeline",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              child: DataTable(
                dataRowMaxHeight: double.infinity,
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Judul')),
                  DataColumn(label: Text('Gambar')),
                  DataColumn(label: Text('Waktu post')),
                  DataColumn(label: Text('Aksi')),
                ],
                rows: _postsData.map((post) {
                  return DataRow(
                    cells: [
                      DataCell(Text(post["poster"]["name"])),
                      DataCell(
                        SizedBox(
                          width: 250,
                          child: Text(
                            post["content"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(
                        post["img_url"] != null
                            ? Image.network(
                                post["img_url"],
                                width: 100,
                                height: 100,
                              )
                            : const Text('Null'), // Placeholder text for null image
                      ),
                      DataCell(Text(post["post_date"])),
                      DataCell(
                        InkWell(
                          onTap: () {
                            deletePost(post[
                                "id"]); // Memanggil deletePost dengan postId
                          },
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Response> fetchData() async {
    try {
      var response = await get(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/post',
          ),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          });

      return response;
    } catch (e) {
      throw Exception('Failed to load: $e');
    }
  }
}
            // child: Column(
            //   children: [
            //     //head
            //     Container(
            //       margin: const EdgeInsets.fromLTRB(10, 10, 10, 2),
            //       child: Row(
            //         children: [
            //           Container(
            //             padding: const EdgeInsets.all(15),
            //             height: 50,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(10))),
            //             child: const Text(
            //               'Nama',
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.all(15),
            //             height: 50,
            //             width: 100,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //             child: const Text(
            //               'Judul',
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.all(15),
            //             height: 50,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //             child: const Text(
            //               'Gambar',
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.all(15),
            //             height: 50,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //             child: const Text(
            //               'Waktu post',
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.all(15),
            //             height: 50,
            //             width: 100,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topRight: Radius.circular(10))),
            //             child: const Text(
            //               'Aksi',
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     //1
            //     Container(
            //       margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            //       child: Row(
            //         children: [
            //           Container(
            //             height: 100,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //           ),
            //           Container(
            //             height: 100,
            //             width: 100,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //           ),
            //           Container(
            //             height: 100,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //           ),
            //           Container(
            //             height: 100,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //           ),
            //           Container(
            //             height: 100,
            //             width: 100,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topRight: Radius.circular(0))),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 InkWell(
            //                     onTap: () {
            //                       AwesomeDialog(
            //                               context: context,
            //                               dialogType: DialogType.question,
            //                               animType: AnimType.rightSlide,
            //                               title: 'Yakin ingin menghapus data?',
            //                               btnOkOnPress: () {},
            //                               btnCancelOnPress: () {})
            //                           .show();
            //                     },
            //                     child: const Image(
            //                         image: AssetImage('assets/Vector.png'))),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     //2
            //     Container(
            //       margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            //       child: Row(
            //         children: [
            //           Container(
            //             height: 100,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     bottomLeft: Radius.circular(10))),
            //           ),
            //           Container(
            //             height: 100,
            //             width: 100,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //           ),
            //           Container(
            //             height: 100,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //           ),
            //           Container(
            //             height: 100,
            //             width: 150,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(0))),
            //           ),
            //           Container(
            //             height: 100,
            //             width: 100,
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 1,
            //                       spreadRadius: 1,
            //                       color: Colors.black.withOpacity(0.1))
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: const BorderRadius.only(
            //                     bottomRight: Radius.circular(10))),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 InkWell(
            //                     onTap: () {
            //                       AwesomeDialog(
            //                               context: context,
            //                               dialogType: DialogType.question,
            //                               animType: AnimType.rightSlide,
            //                               title: 'Yakin ingin menghapus data?',
            //                               btnOkOnPress: () {},
            //                               btnCancelOnPress: () {})
            //                           .show();
            //                     },
            //                     child: const Image(
            //                         image: AssetImage('assets/Vector.png'))),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     )
            //   ],
            // ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  
