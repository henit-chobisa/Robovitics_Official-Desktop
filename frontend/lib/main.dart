import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/base.dart';

void main() {
  runApp(RoboviticsOfficial());
}

class RoboviticsOfficial extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1400, 900),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: basePage(),
      ),
    );
  }
}
