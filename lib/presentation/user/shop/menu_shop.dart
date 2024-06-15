import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/shop/menu_shop_mycart.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/template_page.dart';
import 'package:http/http.dart' as http;

import '../drawer/drawer_user.dart';
import 'menu_shop_detail.dart';
import 'menu_shop_history.dart';

class MenuShop extends StatelessWidget {
  const MenuShop({super.key});

  Future<List<Map<String, dynamic>>> _products() async {
    try {
      final response = await fetchProducts();
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final bool success = data["success"];
        if (!success) {
          throw Exception("Not success");
        }

        return List<Map<String, dynamic>>.from(data["products"]);
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw Exception("error: $e");
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
        elevation: 0,
      ),
      body: Stack(
        children: [
          MyPage(
              widget: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _products(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final products = snapshot.data!;

                          return ListView(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Products',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 500,
                                // color: Colors.amber,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(right: 15),
                                  itemCount: products.length,
                                  itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MenuShopDetail(
                                                        productId:
                                                            products[index]
                                                                ["id"])));
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.3))
                                              ]),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Image.asset('assets/jersey pemain.png'),
                                              SizedBox(
                                                height: 400,
                                                width: 273,
                                                child: Image.network(
                                                  products[index]["img_url"],
                                                  height: 200,
                                                  width: double.maxFinite,
                                                  fit: BoxFit.contain,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    } else {
                                                      return SizedBox(
                                                        height: 200,
                                                        width: double.maxFinite,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: loadingProgress
                                                                        .expectedTotalBytes !=
                                                                    null
                                                                ? loadingProgress
                                                                        .cumulativeBytesLoaded /
                                                                    loadingProgress
                                                                        .expectedTotalBytes!
                                                                : null,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                                // Image.network(
                                                //                                               products[index]["img_url"],
                                                //                                               fit: BoxFit.contain,
                                                //                                             )
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Text(
                                                  '${products[index]["name"]}\nRp${formatNumber(products[index]["price"])}',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MenuShopMycart(),
                                        ));
                                  },
                                  child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: MyButton(txt: 'My Cart'))),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MenuShopHistory(),
                                        ));
                                  },
                                  child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: MyButton(txt: 'History')))
                            ],
                          );
                        }
                      })))
        ],
      ),
    );
  }
}

Future<http.Response> fetchProducts() async {
  try {
    var response = await http.get(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: '/product',
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
        });

    return response;
  } catch (e) {
    throw Exception('Failed to load: $e');
  }
}
