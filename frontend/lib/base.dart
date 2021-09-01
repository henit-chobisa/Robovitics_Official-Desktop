import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';

class basePage extends StatefulWidget {
  @override
  _basePageState createState() => _basePageState();
}

class _basePageState extends State<basePage> {

  Future<void> checkHealth() async {
    const url = ""
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
