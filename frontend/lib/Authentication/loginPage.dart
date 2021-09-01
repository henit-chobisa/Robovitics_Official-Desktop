import 'dart:convert';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:loading/loading.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordObscuretext = true;
  IconData passwordIcon = CupertinoIcons.lock;
  String firstName = "0000";
  String lastName = "0000";
  String imageURL = "nkdsnvlks";
  String designation = "knvkldsnvks";

  var counter = 1;
  var user;

  Future<void> login() async {
    setState(() {
      counter = 0;
    });
    var URL = Uri.parse("http://127.0.0.1:1000/api/authentication/login");
    var body = {
      'email': emailController.text.toString(),
      'password': passwordController.text.toString()
    };
    var header = {"content-type": "application/json"};
    var bodyToPush = jsonEncode(body);
    var response = await http.post(URL, headers: header, body: bodyToPush);
    var values = await jsonDecode(response.body);
    setState(() {
      lastName = values['lastName'];
      firstName = values['firstName'];

      imageURL = values['photoURL'];
      designation = values['department'];
      counter = 1;
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pages = [this.LoadingIndicatior(), this.firstpage(), UserInfoPage()];
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 70.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('images/brandLogo.jpg'),
                    height: 160.h,
                    width: 200.w,
                  ),
                  Container(
                    height: 490,
                    width: 425,
                    margin: EdgeInsets.only(bottom: 6.0.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(2.0, 5.0),
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: pages[counter],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Center UserInfoPage() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: Image(
            image: NetworkImage(imageURL),
            height: 180,
            width: 180,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "${firstName} ${lastName}",
          style: TextStyle(fontSize: 30, fontFamily: "futura"),
        ),
        Text(
          designation,
          style: TextStyle(color: Colors.grey.shade600),
        )
      ],
    ));
  }

  Center LoadingIndicatior() {
    return Center(
        child: Loading(
      indicator: BallSpinFadeLoaderIndicator(),
      size: 40.sp,
      color: Colors.black,
    ));
  }

  Column firstpage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hi there,\nWelcome to Robovitics, the official robotics club of Vellore institute of technology, olease log inside the application to gain advantage of robovitics resources and assets, if you don't have an asset, kindly register yourself, we will provide you the Access IDs within 24 hours\nThank you! ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'Futura',
          ),
        ),
        Divider(
          endIndent: 20.w,
          indent: 20.w,
          thickness: 0.2,
          color: Colors.black,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Sign in to Robovitics Official',
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        Divider(
          endIndent: 130.w,
          indent: 130.w,
          thickness: 0.3,
          color: Colors.black,
        ),
        SizedBox(
          height: 10,
        ),
        roboTextFeild(
          obscuretext: false,
          controller: emailController,
          placeholder: "Email registered with organisation",
          type: TextInputType.emailAddress,
        ),
        SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            roboTextFeild(
              obscuretext: passwordObscuretext,
              placeholder: "Password for this email address",
              controller: passwordController,
              type: TextInputType.visiblePassword,
            ),
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (passwordObscuretext == true) {
                          passwordObscuretext = false;
                          passwordIcon = CupertinoIcons.lock_open;
                        } else {
                          passwordObscuretext = true;
                          passwordIcon = CupertinoIcons.lock;
                        }
                      });
                    },
                    child: Icon(
                      passwordIcon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        Divider(
          endIndent: 120.w,
          indent: 120.w,
          thickness: 0.2,
          color: Colors.black,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            roboButtons(
              title: "Log in",
              ontap: () {
                login();
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 30,
                width: 1,
                color: Colors.black,
              ),
            ),
            roboButtons(
              title: "Join Request",
              ontap: () {
                print("Hello world");
              },
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          endIndent: 120.w,
          indent: 120.w,
          thickness: 0.2,
          color: Colors.black,
        ),
        Text(
          'roboVITics 2021',
          style: TextStyle(color: Colors.grey, fontSize: 8),
        )
      ],
    );
  }
}

class roboButtons extends StatelessWidget {
  const roboButtons({
    Key? key,
    required this.title,
    this.ontap,
  }) : super(key: key);

  final String title;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.indigo.shade600,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: "Futura",
                letterSpacing: 2),
          ),
        ),
      ),
    );
  }
}

class roboTextFeild extends StatelessWidget {
  const roboTextFeild(
      {required this.obscuretext,
      required this.placeholder,
      required this.controller,
      required this.type});

  final bool obscuretext;
  final String placeholder;
  final TextEditingController controller;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          cursorColor: Colors.white,
          obscureText: obscuretext,
          keyboardType: type,
          style: TextStyle(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
