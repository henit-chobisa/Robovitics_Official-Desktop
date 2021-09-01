import 'dart:async';
import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Authentication/loginPage.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';

class basePage extends StatefulWidget {
  @override
  _basePageState createState() => _basePageState();
}

class _basePageState extends State<basePage> {
  Future<void> checkHealth() async {
    var url = Uri.parse("http://127.0.0.1:1000/api/verification/");
    var response =
        await http.get(url, headers: {"content-type": "application/json"});

    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => loginPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => checkHealth());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage('images/brandLogo.jpg'),
              height: 400.h,
              width: 400.w,
            ),
          ),
          Loading(
            indicator: BallSpinFadeLoaderIndicator(),
            size: 40.sp,
          ),
        ],
      ),
    );
  }
}
