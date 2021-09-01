import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    height: 170.h,
                    width: 200.w,
                  ),
                  Container(
                    height: 500,
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
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
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
                            thickness: 1,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          roboTextFeild(
                            obscuretext: false,
                            placeholder: "Email registered with organisation",
                            controller: emailController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          roboTextFeild(
                              obscuretext: true,
                              placeholder: "Password for this email address",
                              controller: passwordController)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class roboTextFeild extends StatelessWidget {
  const roboTextFeild(
      {required this.obscuretext,
      required this.placeholder,
      required this.controller});

  final bool obscuretext;
  final String placeholder;
  final TextEditingController controller;

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
          keyboardType: TextInputType.emailAddress,
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
