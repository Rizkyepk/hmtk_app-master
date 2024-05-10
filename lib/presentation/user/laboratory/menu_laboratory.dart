import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/laboratory/menu_laboratory_detail.dart';
import 'package:hmtk_app/utils/lab_data.dart';

import '../../../widget/template_page.dart';
import '../drawer/drawer_user.dart';

class MenuLaboratory extends StatelessWidget {
  const MenuLaboratory({super.key});

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
      body: MyPage(
        widget: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            children: [
              const Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Laboratory',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'Computer Engineering',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 8,
                  child: Container(
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        )),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                          child: Image.asset(
                            'assets/dec-laboratory.png',
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                        ),
                        GridView.builder(
                          padding: const EdgeInsets.all(25),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 30.0,
                            mainAxisSpacing: 20.0,
                          ),
                          itemCount: LabData.laboratory.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MenuLaboratoryDetail(
                                              lab: LabData.laboratory[index]
                                                  ["lab"],
                                              gambar: LabData.laboratory[index]
                                                  ['gambar'],
                                              title: LabData.laboratory[index]
                                                  ['title'],
                                              deskripsi:
                                                  LabData.laboratory[index]
                                                      ['deskripsi'])));
                            },
                            child: SizedBox(
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        LabData.laboratory[index]['gambar'],
                                        height: 70,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        LabData.laboratory[index]['title'],
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 17),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
