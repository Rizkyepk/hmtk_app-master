import 'dart:convert';
import 'dart:io';
import 'package:hmtk_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hmtk_app/widget/activity.dart';
import 'package:hmtk_app/widget/drawer.dart';
import 'package:hmtk_app/utils/color_pallete.dart' show ColorPallete;

class DataPesanan extends StatefulWidget {
  const DataPesanan({super.key});

  @override
  State<DataPesanan> createState() => _DataPesananState();
}

class _DataPesananState extends State<DataPesanan> {
  late List<Map<String, dynamic>> _transactionData = [];

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
        if (!success) {
          throw Exception("Not success");
        }

        final List<Map<String, dynamic>> datalab =
            List<Map<String, dynamic>>.from(data["lab_posts"]);

        setState(() {
          _transactionData = datalab;
        });
      } else {
        throw Exception("error");
      }
    } catch (e) {
      print('Error fetching products: $e');
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
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Nama')),
                DataColumn(label: Text('Aksi')),
                DataColumn(label: Text('Jumlah')),
                DataColumn(label: Text('Ukuran')),
                DataColumn(label: Text('Informasi')),
              ],
              rows: _transactionData.map((transaction) {
                return DataRow(
                  cells: [
                    DataCell(Text(transaction["name"] ?? '')),
                    DataCell(Text(transaction["quantity"] ?? '')),
                    DataCell(Text(transaction["size"] ?? '')),
                    DataCell(Text(transaction['orders']["description"] ?? '')),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<http.Response> fetchData() async {
    try {
      // Map<String, dynamic> params = {'nim': nim};

      var response = await http.get(
        Uri(
          scheme: 'https',
          host: 'myhmtk.jeyy.xyz',
          // path: '/student/$nim/transactions',
          // queryParameters: params,
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
