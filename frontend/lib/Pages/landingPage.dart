import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class landingPage extends StatefulWidget {
  const landingPage({Key? key}) : super(key: key);

  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(left: 50.w, top: 50.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    "Greetings, Henit Chobisa",
                    style: TextStyle(color: Colors.white, fontSize: 30.sp),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
