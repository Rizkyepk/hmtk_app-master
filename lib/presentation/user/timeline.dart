import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/post_button.dart';
import 'package:hmtk_app/widget/template_page.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:sizer/sizer.dart';

import 'drawer/drawer_user.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  Future<List<Map<String, dynamic>>> _posts() async {
    try {
      final response = await fetchData();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool success = data["success"];
        if (!success) {
          throw Exception("Not success");
        }

        return List<Map<String, dynamic>>.from(data["posts"]);
      } else {
        throw Exception("error");
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed: $e',
        btnOkOnPress: () {},
      ).show();
      return [];
    }
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
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Berhasil menghapus post!',
            btnOkOnPress: () {
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => const Timeline()));
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

  Future<void> toggleLike(List<Map<String, dynamic>> posts, int index) async {
    try {
      setState(() {
        if (posts[index]["is_liked"]) {
          posts[index]["is_liked"] = false;
          posts[index]["current_like_count"] -= 1;
        } else {
          posts[index]["is_liked"] = true;
          posts[index]["current_like_count"] += 1;
        }
      });

      var postObj = posts[index];
      var auth = await SaveData.getAuth();
      Map<String, String> params = {'user_id': auth["user"]["nim"].toString()};

      var response = await post(
          Uri(
              scheme: 'https',
              host: 'myhmtk.jeyy.xyz',
              path: '/post/${postObj["id"]}/like',
              queryParameters: params),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          print("berhasil like/unlike");
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

  Future<List<Map<String, dynamic>>> fetchComment(int postId) async {
    try {
      var response = await get(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/post/$postId/comment',
          ),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data["success"]) {
          return List<Map<String, dynamic>>.from(data["comments"]);
        } else {
          throw data["message"];
        }
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> addComment(int postId) async {
    try {
      if (addCommentController.text.isEmpty) {
        throw "Comment can not be empty!";
      }
      var content = addCommentController.text;
      addCommentController.text = "";
      var auth = await SaveData.getAuth();
      Map<String, String> params = {
        'commenter_id': auth["user"]["nim"].toString(),
        'comment_date': DateTime.now().toIso8601String(),
        'content': content
      };

      var response = await post(
          Uri(
              scheme: 'https',
              host: 'myhmtk.jeyy.xyz',
              path: '/post/$postId/comment',
              queryParameters: params),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data["success"]) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'Berhasil mengirim komentar!',
            btnOkOnPress: () {},
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

  Future<void> deleteComment(int postId, int commentId) async {
    try {
      var response = await delete(
          Uri(
              scheme: 'https',
              host: 'myhmtk.jeyy.xyz',
              path: '/post/$postId/comment/$commentId'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'Berhasil menghapus komentar!',
            btnOkOnPress: () {},
          ).show();
          setState(() {});
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

  // var hapusKomentar = '';
  bool isLike = false;
  List? data;
  bool myPostsOnly = false;
  TextEditingController addCommentController = TextEditingController();

  Future<void> _refresh() async {
    try {
      final List<dynamic> newData =
          await Future.wait([_posts(), SaveData.getAuth()]);
      setState(() {
        data = newData;
      });
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed to refresh data: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerUserScren(),
      ),
      appBar: AppBar(
        title: const Text('Timeline'),
        actions: [
          PopupMenuButton(
            child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Image.asset('assets/filter.png')),
            onSelected: (value) {
              if (value == 0) {
                setState(() {
                  myPostsOnly = false;
                });
              } else {
                setState(() {
                  myPostsOnly = true;
                });
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "All Post",
                        ),
                        Image.asset(
                          'assets/all-post.png',
                          width: 40,
                        )
                      ],
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "My Post",
                        ),
                        Image.asset('assets/my-post.png')
                      ],
                    ),
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: MyPage(
          widget: SafeArea(
              child: RefreshIndicator(
        onRefresh: _refresh, //pull to refresh
        child: FutureBuilder(
            future: data == null
                ? Future.wait([_posts(), SaveData.getAuth()])
                : Future.value(data!),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  data == null) {
                // return const Text('Loading data...');
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                data = snapshot.data;
                final allPosts = List<Map<String, dynamic>>.from(data![0]);
                final auth = Map<String, dynamic>.from(data![1]);

                List<Map<String, dynamic>> posts;
                if (myPostsOnly) {
                  posts = allPosts
                      .where((post) =>
                          post["poster"]["nim"] == auth["user"]["nim"])
                      .toList();
                } else {
                  posts = allPosts;
                }
                var itemCount = posts.length;

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: itemCount,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    radius: 38,
                                    backgroundColor: Colors.transparent,
                                    child: ClipOval(
                                        child: Image.network(
                                      posts[index]["poster"]["avatar_url"],
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60,
                                    ))),
                                const SizedBox(
                                  width: 2,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                            posts[index]["poster"]["name"],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          )),
                                    ),
                                    Text(
                                      // '8 jam yang lalu',
                                      timeAgoFromIso(posts[index]["post_date"]),
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (posts[index]["poster"]["nim"] ==
                                auth["user"]["nim"])
                              PopupMenuButton(
                                iconSize: 30,
                                onSelected: (value) {
                                  setState(() {
                                    if (value == 1) {
                                      deletePost(posts[index]["id"]);
                                    }
                                  });
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem(
                                      value: 1,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Hapus",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Icon(Icons.delete, color: Colors.red)
                                        ],
                                      ),
                                    ),
                                  ];
                                },
                              )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          // 'Info futsal slurrr kabeh.. ${posts.toString()}',
                          posts[index]["content"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (posts[index]["img_url"] != null)
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  height: 198,
                                  width: 352,
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
                                  )),
                            ],
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        // if (posts[index]["current_like_count"] != 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(Icons.favorite, color: Colors.red),
                            const SizedBox(width: 5),
                            Text(
                              '${posts[index]["current_like_count"]} suka',
                              style: const TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.8,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // like
                            InkWell(
                              onTap: () {
                                toggleLike(posts, index);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  (posts[index]["is_liked"] != null &&
                                          posts[index]["is_liked"] == true)
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                        ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('Suka')
                                ],
                              ),
                            ),
                            // komentar
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(35))),
                                    builder: (context) {
                                      return Container(
                                        height: 60,
                                        // MediaQuery.of(context)
                                        //         .size
                                        //         .height *
                                        //     0.6,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                      width: 40,
                                                      child: Divider(
                                                        thickness: 4,
                                                      )),
                                                  Text(
                                                    'Komentar',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Divider(
                                                    thickness: 0.8,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color:
                                                        Colors.grey.shade300),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: CircleAvatar(
                                                          radius: 38,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          child: ClipOval(
                                                              child:
                                                                  Image.network(
                                                            auth["user"]
                                                                ["avatar_url"],
                                                            fit: BoxFit.cover,
                                                            width: 60,
                                                            height: 60,
                                                          ))),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 7,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            flex: 4,
                                                            child: TextField(
                                                              controller:
                                                                  addCommentController,
                                                              maxLength: 100,
                                                              decoration: const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                  hintText:
                                                                      'Tambahkan komentar anda..'),
                                                            ),
                                                          ),
                                                          Expanded(
                                                              flex: 1,
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    addComment(posts[
                                                                            index]
                                                                        ["id"]);
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons.send,
                                                                    color: Colors
                                                                        .blue,
                                                                  )))
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: FutureBuilder(
                                                  future: fetchComment(
                                                      posts[index]["id"]),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const Center(
                                                        child: SizedBox(
                                                            width: 30,
                                                            height: 30,
                                                            child:
                                                                CircularProgressIndicator()),
                                                      ); // Show loading indicator while data is being fetched
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                    } else {
                                                      var comments =
                                                          snapshot.data;
                                                      return ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            comments.length,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 15),
                                                        itemBuilder:
                                                            (context, index) {
                                                          var comment =
                                                              comments[index];
                                                          return InkWell(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          25),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                          radius:
                                                                              38,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          child: ClipOval(
                                                                              child: Image.network(
                                                                            comment["commenter"]["avatar_url"],
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            width:
                                                                                60,
                                                                            height:
                                                                                60,
                                                                          ))),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 200,
                                                                                child: SingleChildScrollView(
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  child: Text(
                                                                                    comment["commenter"]["name"],
                                                                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              // const SizedBox(
                                                                              //   width: 10,
                                                                              // ),
                                                                              Text(
                                                                                timeAgoFromIso(comment["comment_date"]),
                                                                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                200,
                                                                            child:
                                                                                Text(
                                                                              comment["content"],
                                                                              softWrap: true,
                                                                              style: const TextStyle(fontSize: 12),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  if (auth["user"]
                                                                          [
                                                                          "nim"] ==
                                                                      comment["commenter"]
                                                                          [
                                                                          "nim"])
                                                                    PopupMenuButton(
                                                                      onSelected:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          deleteComment(
                                                                              posts[index]["id"],
                                                                              comment["id"]);
                                                                          // hapusKomentar =
                                                                          //     value
                                                                          //         .toString();
                                                                        });
                                                                      },
                                                                      itemBuilder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return const [
                                                                          PopupMenuItem(
                                                                            value:
                                                                                '1',
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Hapus",
                                                                                  style: TextStyle(color: Colors.red),
                                                                                ),
                                                                                Icon(Icons.delete, color: Colors.red)
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ];
                                                                      },
                                                                    )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  }),
                                            ),
                                          ],
                                        ),
                                      );
                                      //   }
                                      // });
                                    });
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.mode_comment_outlined,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Komentar',
                                  ),
                                ],
                              ),
                            ),
                            // share
                            InkWell(
                              onTap: () {
                                Share.share(
                                    '${posts[index]["poster"]["name"]} memposting pada aplikasi MyHMTK ${timeAgoFromIso(posts[index]["post_date"])}:\n\n${posts[index]["content"]}\n[${posts[index]["img_url"]}]',
                                    subject:
                                        'Postingan ${posts[index]["poster"]["name"]} di MyHMTK');
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.share,
                                  ),
                                  Text('Bagi')
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
            }),
      ))),
      floatingActionButton: postButton(context),
    );
  }
}

Future<Response> fetchData() async {
  try {
    var auth = await SaveData.getAuth();
    Map<String, String> params = {'user_id': auth["user"]["nim"].toString()};

    var response = await get(
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
