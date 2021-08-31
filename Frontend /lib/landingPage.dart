import 'package:flutter/material.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'loginScreen.dart';

class landingPage extends StatefulWidget {
  const landingPage({Key? key}) : super(key: key);

  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'WE',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 60.sp),
              ),
              Lottie.asset('lottie/heart.json', height: 120.h, width: 150.w),
              Text(
                'roboVITics',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.tealAccent,
                    fontWeight: FontWeight.w100,
                    fontSize: 70.sp),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 120.h, bottom: 80.h),
              child: Center(child: BallClipRotateIndicator())),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => loginScreen(),
                  ),
                );
              },
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ))
        ],
      ),
    );
  }
}
