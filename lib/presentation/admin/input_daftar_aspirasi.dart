import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/admin/daftar_aspirasi.dart';
import 'package:hmtk_app/utils/color_pallete.dart';

import '../../widget/button.dart';

class InputAspirasi extends StatelessWidget {
  const InputAspirasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: ColorPallete.greenprim,
        ),
        child: Stack(
          children: [
            IconButton(
              padding: const EdgeInsets.fromLTRB(20, 130, 0, 0),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop(
                  MaterialPageRoute(
                    builder: (context) => const DaftarAspirasi(),
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 200, 30, 0),
              height: double.infinity,
              width: double.infinity,
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(140.0),
                  1: FlexColumnWidth(),
                },
                children: [
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Nama',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 30,
                        child: const TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'NIM',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 30,
                        child: const TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Judul',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 100,
                        child: const TextField(
                          maxLines: 3,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Isi Tanggapan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 100,
                        child: const TextField(
                          maxLines: 3,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    )
                  ]),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'Data disimpan!',
                    btnOkOnPress: () {
                      // Navigator.pop(context);
                    },
                  ).show();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 180),
                  child: MyButton(
                    txt: 'Submit',
                    height: 45,
                  ),
                ),
              ),
            )
            // Other widgets in your container...
          ],
        ),
      ),
    );
  }
}
