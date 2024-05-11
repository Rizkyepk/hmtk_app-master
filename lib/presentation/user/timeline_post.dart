import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/template_page.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../utils/color_pallete.dart';

class TimelinePost extends StatefulWidget {
  const TimelinePost({super.key});

  @override
  State<TimelinePost> createState() => _TimelinePostState();
}

class _TimelinePostState extends State<TimelinePost> {
  bool nonActiveComentar = true;

  File? image;
  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyPage(
          widget: Column(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 50,
                        width: 100,
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
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: const TextField(
                maxLength: 300,
                maxLines: 30,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'posting hal yang bermanfaat dan positif...'),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 5, left: 20, right: 20),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await getImage();
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Unggah Gambar',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Komentar',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Switch(
                            value: nonActiveComentar,
                            onChanged: (value) {
                              setState(() {
                                nonActiveComentar = value;
                              });
                            })
                      ],
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}

Future<http.Response> postData(
    int posterId, String content, bool canComment, String? imgUrl) async {
  try {
    Map<String, String> params = {
      'poster_id': posterId.toString(),
      'content': content,
      'post_date': DateTime.now().toIso8601String(),
      // 'can_comment': canComment.toString(),
      if (imgUrl != null) 'img_url': imgUrl,
    };

    var response = await http.post(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/post',
          queryParameters: params,
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
        });

    return response;
  } catch (e) {
    throw Exception('Failed to load: $e');
  }
}
