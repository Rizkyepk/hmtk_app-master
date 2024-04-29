import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/color_pallete.dart';
import 'package:hmtk_app/widget/button.dart';
import 'package:hmtk_app/widget/template_page.dart';

//buat edit pw di profile

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _SignInState();
}

class _SignInState extends State<ResetPassword>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var fullname = TextEditingController();
  var nim = TextEditingController();
  var notelp = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyPage(
          widget: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Image.asset('assets/LOGO TK.png'),
          ),
          Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ColorPallete.greenprim),
                ),
                Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: ColorPallete.greenprim),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'RESET PASSWORD',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPallete.greenprim),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorPallete.greenprim.withOpacity(0.3),
                  ),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorPallete.greenprim.withOpacity(0.3),
                  ),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Password Changed!',
                        btnOkOnPress: () {
                          Navigator.pop(context);
                        },
                      ).show();
                    },
                    child: MyButton(
                      txt: 'Reset',
                      height: 45,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
