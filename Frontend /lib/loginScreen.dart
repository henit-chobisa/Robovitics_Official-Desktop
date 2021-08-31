import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            height: 300.h,
            width: 900.w,
            child: Image(
              image: AssetImage('images/1.jpg'),
            ),
          ),
          Center(
            child: GlassmorphicContainer(
                width: 500.w,
                height: 500.h,
                borderRadius: 20.sp,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFF75035).withAlpha(30),
                      Color(0xFFffffff).withAlpha(50),
                    ],
                    stops: [
                      0.3,
                      1,
                    ]),
                border: 4,
                blur: 1,
                borderGradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color(0xFF4579C5).withAlpha(100),
                      Color(0xFFFFFFF).withAlpha(55),
                      Color(0xFFF75035).withAlpha(10),
                    ],
                    stops: [
                      0.06,
                      0.95,
                      1
                    ])),
          ),
        ],
      ),
    );
  }
}
