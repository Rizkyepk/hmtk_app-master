import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/timeline.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/template_page.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/color_pallete.dart';

class TimelinePost extends StatefulWidget {
  const TimelinePost({super.key});

  @override
  State<TimelinePost> createState() => _TimelinePostState();
}

class _TimelinePostState extends State<TimelinePost> {
  TextEditingController contentController = TextEditingController();
  bool canComment = true;

  File? image;
  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);

    if (imagePicked == null) {
      return;
    }

    final File imageFile = File(imagePicked.path);
    double fileSizeMb = await imageFile.length() / (1024 * 1024);

    if (fileSizeMb > 10) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed: Batas ukuran file 10MB',
        btnOkOnPress: () {},
      ).show();
    }

    setState(() {
      image = File(imagePicked.path);
    });
  }

  Future<void> addPost() async {
    try {
      var auth = await SaveData.getAuth();

      if (contentController.text == '') {
        throw "Teks tidak boleh kosong";
      }

      String? imgUrl;
      if (image != null) {
        imgUrl = await uploadFileToCDN(image!);
      }

      Map<String, dynamic> params = {
        'poster_id': auth['user']['nim'].toString(),
        'post_date': DateTime.now().toIso8601String(),
        'content': contentController.text,
        'can_comment': canComment.toString(),
        if (imgUrl != null) 'img_url': imgUrl
      };

      var response = await post(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/post',
            queryParameters: params,
          ),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Berhasil menambahkan post baru!',
            btnOkOnPress: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Timeline()));
            },
          ).show();
        } else {
          throw data["message"];
        }
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyPage(
          widget: Column(
        children: [
          // Expanded(
          Container(
              // flex: 1,
              height: 58,
              margin: const EdgeInsets.only(top: 30),
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
                      onTap: addPost,
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
            // flex: 5,
            child: Container(
              padding: const EdgeInsets.all(15),
              // margin: const EdgeInsets.only(left: 20, right: 20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: TextField(
                controller: contentController,
                maxLength: 300,
                maxLines: 30,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'posting hal yang bermanfaat dan positif...'),
              ),
            ),
          ),
          // Expanded(
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
            child: Column(
              children: [
                if (image != null)
                  Stack(children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                                height: 99,
                                width: 176,
                                child: Image.file(image!, fit: BoxFit.cover)))),
                    Positioned(
                      top: 10, // Adjust top position as needed
                      right: 10, // Adjust right position as needed
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              image = null;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.2), // Shadow color
                                    spreadRadius: 2, // Spread radius
                                    blurRadius: 5, // Blur radius
                                    offset: const Offset(0, 2), // Offset
                                  ),
                                ],
                                shape: BoxShape
                                    .circle, // Optional: You can change the shape as needed
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 25,
                              ))),
                    ),
                  ]),
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
                        value: canComment,
                        onChanged: (value) {
                          setState(() {
                            canComment = value;
                          });
                        })
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

Future<Response> postData(
    int posterId, String content, bool canComment, String? imgUrl) async {
  try {
    Map<String, String> params = {
      'poster_id': posterId.toString(),
      'content': content,
      'post_date': DateTime.now().toIso8601String(),
      'can_comment': canComment.toString(),
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
