import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;

class DataPesanan extends StatefulWidget {
  const DataPesanan({Key? key}) : super(key: key);

  @override
  State<DataPesanan> createState() => _DataPesananState();
}

class _DataPesananState extends State<DataPesanan> {
  List<Map<String, dynamic>> _transactionData = [];

  @override
  void initState() {
    super.initState();
    _fetchDatapesanan();
  }

  Future<void> _fetchDatapesanan() async {
    try {
      final response = await fetchData();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool success = data["success"];
        if (success) {
          final List<Map<String, dynamic>> datapesanan =
              List<Map<String, dynamic>>.from(data["transactions"]);

          setState(() {
            _transactionData = datapesanan;
          });
        } else {
          throw Exception("Request not successful");
        }
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw 'Error fetching data: $e';
    }
  }

  Future<http.Response> fetchData() async {
    try {
      final response = await http.get(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          path: 'student/0/transactions_all',
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Secrets.apiKey}',
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to load: $e');
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'capture':
      case 'settlement':
        return 'Selesai';
      default:
        return 'Pesanan Gagal';
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
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const ActivityFrame()),
            //     );
            //   },
            //   child: ClipOval(
            //     child: SizedBox.fromSize(
            //       size: const Size.fromRadius(38), // Image radius
            //       child: Image.asset('assets/ftprofil.png', fit: BoxFit.cover),
            //     ),
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Pesanan'),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        elevation: 0.0,
        backgroundColor: ColorPallete.greenprim,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: const Text(
              "Data Pemesanan",
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
                columns: const [
                  DataColumn(label: Text('ID Transaksi')),
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('Produk')),
                  DataColumn(label: Text('Jumlah')),
                  DataColumn(label: Text('Ukuran')),
                  DataColumn(label: Text('Informasi')),
                ],
                rows: _transactionData.map((transaction) {
                  final transactionId = transaction['id']?.toString() ?? '';
                  final studentName = transaction['student']['name'] ?? '';
                  final status = transaction['status'] ?? '';
                  final statusText = _getStatusText(status);

                  return DataRow(cells: [
                    DataCell(Text(transactionId)),
                    DataCell(Text(studentName)),
                    DataCell(Container(
                      width: 250,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: transaction['orders'].length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 5),
                        itemBuilder: (BuildContext context, int index) {
                          final order = transaction['orders'][index];
                          final productName = order['product']['name'] ?? '';
                          // final quantity = order['quantity']?.toString() ?? '';
                          // final size = order['size'] ?? '';

                          return Text(
                            '$productName',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    )),
                    DataCell(Container(
                      width: 250,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: transaction['orders'].length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 5),
                        itemBuilder: (BuildContext context, int index) {
                          final order = transaction['orders'][index];
                          final quantity = order['quantity']?.toString() ?? '';
                          return Text(quantity);
                        },
                      ),
                    )),
                    DataCell(Container(
                      width: 250,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: transaction['orders'].length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 5),
                        itemBuilder: (BuildContext context, int index) {
                          final order = transaction['orders'][index];
                          final size = order['size'] ?? '';
                          return Text(size);
                        },
                      ),
                    )),
                    DataCell(Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: statusText == 'Pending'
                            ? Colors.orange
                            : statusText == 'Selesai'
                                ? Colors.green
                                : Colors.red,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        statusText,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


          //   child: Column(
          //     children: [
          //       Container(
          //         margin: const EdgeInsets.fromLTRB(10, 10, 10, 2),
          //         child: Row(
          //           children: [
          //             Container(
          //               padding: const EdgeInsets.all(15),
          //               height: 50,
          //               width: 150,
          //               decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                         blurRadius: 1,
          //                         spreadRadius: 1,
          //                         color: Colors.black.withOpacity(0.1))
          //                   ],
          //                   color: Colors.white,
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(10))),
          //               child: const Text(
          //                 'Nama',
          //                 textAlign: TextAlign.center,
          //               ),
          //             ),
          //             Container(
          //               padding: const EdgeInsets.all(15),
          //               height: 50,
          //               width: 100,
          //               decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                         blurRadius: 1,
          //                         spreadRadius: 1,
          //                         color: Colors.black.withOpacity(0.1))
          //                   ],
          //                   color: Colors.white,
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(0))),
          //               child: const Text(
          //                 'Nim',
          //                 textAlign: TextAlign.center,
          //               ),
          //             ),
          //             Container(
          //               padding: const EdgeInsets.all(15),
          //               height: 50,
          //               width: 150,
          //               decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                         blurRadius: 1,
          //                         spreadRadius: 1,
          //                         color: Colors.black.withOpacity(0.1))
          //                   ],
          //                   color: Colors.white,
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(0))),
          //               child: const Text(
          //                 'Jumlah',
          //                 textAlign: TextAlign.center,
          //               ),
          //             ),
          //             Container(
          //               padding: const EdgeInsets.all(15),
          //               height: 50,
          //               width: 150,
          //               decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                         blurRadius: 1,
          //                         spreadRadius: 1,
          //                         color: Colors.black.withOpacity(0.1))
          //                   ],
          //                   color: Colors.white,
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(0))),
          //               child: const Text(
          //                 'Ukuran',
          //                 textAlign: TextAlign.center,
          //               ),
          //             ),
          //             Container(
          //               padding: const EdgeInsets.all(15),
          //               height: 50,
          //               width: 150,
          //               decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                         blurRadius: 1,
          //                         spreadRadius: 1,
          //                         color: Colors.black.withOpacity(0.1))
          //                   ],
          //                   color: Colors.white,
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(0))),
          //               child: const Text(
          //                 'Harga',
          //                 textAlign: TextAlign.center,
          //               ),
          //             ),
          //             Container(
          //               padding: const EdgeInsets.all(3),
          //               height: 50,
          //               width: 150,
          //               decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                         blurRadius: 1,
          //                         spreadRadius: 1,
          //                         color: Colors.black.withOpacity(0.1))
          //                   ],
          //                   color: Colors.white,
          //                   borderRadius: const BorderRadius.only(
          //                       topRight: Radius.circular(10))),
          //               child: const Column(
          //                 children: [
          //                   Text(
          //                     'Informasi',
          //                     textAlign: TextAlign.center,
          //                   ),
          //                   Text(
          //                     'Tambahan',
          //                     textAlign: TextAlign.center,
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          //         child: Row(
          //           children: [
          //             Container(
          //               height: 100,
          //               width: 150,
          //               decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                         blurRadius: 1,
          //                         spreadRadius: 1,
          //                         color: Colors.black.withOpacity(0.1))
          //                   ],
          //                   color: Colors.white,
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(0))),
          //             ),
          //             Container(
          //               height: 100,
          //               width: 100,
          //               decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                         blurRadius: 1,
          //                         spreadRadius: 1,
          //                         color: Colors.black.withOpacity(0.1))
          //                   ],
          //                   color: Colors.white,
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(0))),
          //             ),
          //             Container(
          //               height: 100,
          //               width: 150,
          //               decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                         blurRadius: 1,
          //                         spreadRadius: 1,
          //                         color: Colors.black.withOpacity(0.1))
          //                   ],
          //                   color: Colors.white,
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(0))),
          //             ),
          //             Container(
          //               height: 100,
          //               width: 150,
          //               decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                         blurRadius: 1,
          //                         spreadRadius: 1,
          //                         color: Colors.black.withOpacity(0.1))
          //                   ],
          //                   color: Colors.white,
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(0))),
          //             ),
          //             Container(
          //               height: 100,
          //               width: 150,
          //               decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                         blurRadius: 1,
          //                         spreadRadius: 1,
          //                         color: Colors.black.withOpacity(0.1))
          //                   ],
          //                   color: Colors.white,
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(0))),
          //             ),
          //             Container(
          //               height: 100,
          //               width: 150,
          //               decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                         blurRadius: 1,
          //                         spreadRadius: 1,
          //                         color: Colors.black.withOpacity(0.1))
          //                   ],
          //                   color: Colors.white,
          //                   borderRadius: const BorderRadius.only(
          //                       topRight: Radius.circular(0))),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
