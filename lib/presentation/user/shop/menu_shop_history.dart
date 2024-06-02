import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/shop/menu_shop_payment.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:hmtk_app/widget/template_page.dart';
import 'package:http/http.dart';

class MenuShopHistory extends StatefulWidget {
  const MenuShopHistory({super.key});

  @override
  State<MenuShopHistory> createState() => _MenuShopHistoryState();
}

class _MenuShopHistoryState extends State<MenuShopHistory> {
  FutureResult<List<Map<String, dynamic>>>? futureResult;

  Future<List<Map<String, dynamic>>> getStudentTransactions() async {
    try {
      var auth = await SaveData.getAuth();

      var response = await get(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/student/${auth["user"]["nim"]}/transactions',
          ),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"]) {
          return List<Map<String, dynamic>>.from(data["transactions"]);
        } else {
          throw data["message"];
        }
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<void> fetchStudentTransactions() async {
    setState(() {
      futureResult = FutureResult.loading();
    });

    try {
      final data = await getStudentTransactions();
      setState(() {
        futureResult = FutureResult.success(data);
      });
    } catch (e) {
      setState(() {
        futureResult = FutureResult.error(e.toString());
      });
    }
  }

  Future<void> completeTransaction(int transactionId) async {
    try {
      var auth = await SaveData.getAuth();

      Map<String, String> params = {'completed': 'true'};
      var response = await put(
          Uri(
            scheme: 'https',
            host: 'myhmtk.jeyy.xyz',
            path: '/student/${auth["user"]["nim"]}/transactions/$transactionId',
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
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'Pastikan produk sudah sesuai!',
            btnCancelText: 'Belum',
            btnOkText: 'Sudah',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MenuShopHistory()));
            },
          ).show();
        } else {
          throw data["message"];
        }
      } else {
        throw "Status code: ${response.statusCode}";
      }
    } catch (e) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStudentTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: MyPage(
        widget: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: futureResult == null
              ? 1
              : futureResult!.status == FutureStatus.success &&
                      futureResult!.data != null
                  ? futureResult!.data!.length
                  : 1,
          itemBuilder: (context, index) {
            if (futureResult == null ||
                futureResult!.status == FutureStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (futureResult!.status == FutureStatus.error) {
              return Center(
                  child: Text('Error: ${futureResult?.errorMessage}'));
            } else if (futureResult!.status == FutureStatus.success &&
                futureResult!.data != null) {
              final transaction = futureResult!.data![index];

              return Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: ExpansionTile(
                  shape: const Border(),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Text(
                    "Jumlah barang: ${transaction["orders"].length}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Waktu: ${formatDateTime(transaction["transaction_date"])}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Total: Rp${formatNumber(transaction['orders'].fold(0, (sum, order) => sum + order['quantity'] * order['product']['price']) + 5000)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                if (transaction["status"] == "pending") {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentPage(
                                          paymentUrl:
                                              transaction["payment_url"]),
                                    ),
                                  ).then((_) {
                                    setState(() {
                                      futureResult = null;
                                      fetchStudentTransactions();
                                    });
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: () {
                                    switch (transaction["status"]) {
                                      case "settlement":
                                      case "capture":
                                        return Colors.grey;
                                      case "expire":
                                      case "deny":
                                      case "cancel":
                                      case "failure":
                                        return Colors.red;
                                      default:
                                        return ColorPallete.greenprim;
                                    }
                                  }(),
                                ),
                                child: Text(
                                  () {
                                    switch (transaction["status"]) {
                                      case "settlement":
                                      case "capture":
                                        return "Sudah dibayar";
                                      case "expire":
                                        return "Waktu bayar habis";
                                      case "deny":
                                      case "cancel":
                                      case "failure":
                                        return "Pembayaran gagal";
                                      default:
                                        return "Bayar";
                                    }
                                  }(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // Text(
                                //   transaction["paid"] == false
                                //       ? "Bayar"
                                //       : "Sudah dibayar",
                                //   style: const TextStyle(
                                //       color: Colors.white,
                                //       fontWeight: FontWeight.bold),
                                // ),
                              ),
                            ),
                          ),
                          if (transaction["paid"])
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: InkWell(
                                onTap: () {
                                  if (transaction["completed"] == false) {
                                    completeTransaction(transaction["id"]);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: transaction["completed"]
                                          ? Colors.grey
                                          : ColorPallete.greenprim),
                                  child: Text(
                                    transaction["completed"]
                                        ? "Pesanan Selesai"
                                        : "Selesaikan Pesanan",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transaction["orders"].length,
                      itemBuilder: (context, index) {
                        final order = transaction["orders"][index];

                        return ExpansionTile(
                          shape: const Border(bottom: BorderSide()),
                          title: Text(order["product"]["name"]),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Harga: Rp${formatNumber(order["product"]["price"])}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Jumlah: ${order["quantity"]}   Size: ${order["size"].toUpperCase()}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 4,
                                  bottom: 2,
                                  right: 4,
                                  top: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorPallete.blue,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'Total: Rp${formatNumber(order["product"]["price"] * order["quantity"])}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          leading: Image.network(
                            order["product"]["img_url"],
                            width: 70,
                            height: 70,
                            fit: BoxFit.contain,
                          ),
                          children: [
                            Text(
                                "Info tambahan: ${order["information"] ?? "-"}")
                          ],
                        );
                      },
                    )
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        // ListView.builder(
        //   itemCount: 7,
        //   shrinkWrap: true,
        //   padding: const EdgeInsets.all(20),
        //   itemBuilder: (context, index) => InkWell(
        //     onTap: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => const MenuShopDataPemesanan(
        //                 title: 'Jersey Pemain',
        //                 harga: 'Rp 150.000',
        //                 gambar: 'assets/jersey pemain detail.png'),
        //           ));
        //     },
        //     child: Container(
        //       padding: const EdgeInsets.all(15),
        //       margin: const EdgeInsets.only(bottom: 25),
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(20), color: Colors.white),
        //       child: Row(
        //         children: [
        //           Image.asset(
        //             'assets/jersey pemain detail.png',
        //             height: 80,
        //           ),
        //           const SizedBox(
        //             width: 15,
        //           ),
        //           const Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Text(
        //                 'Jersey Pemain',
        //                 style: TextStyle(
        //                     fontSize: 18, fontWeight: FontWeight.bold),
        //               ),
        //               Row(
        //                 children: [
        //                   Text(
        //                     'M',
        //                     style: TextStyle(
        //                         fontSize: 14, fontWeight: FontWeight.bold),
        //                   ),
        //                   Padding(
        //                     padding: EdgeInsets.only(left: 10, right: 10),
        //                     child: Text(
        //                       '-',
        //                       style: TextStyle(
        //                           fontSize: 14, fontWeight: FontWeight.bold),
        //                     ),
        //                   ),
        //                   Text(
        //                     'Rp 150.000',
        //                     style: TextStyle(
        //                         fontSize: 14, fontWeight: FontWeight.bold),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
