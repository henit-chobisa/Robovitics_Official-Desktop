import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class eventPage extends StatefulWidget {
  const eventPage({Key? key}) : super(key: key);

  @override
  _eventPageState createState() => _eventPageState();
}

class _eventPageState extends State<eventPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 40.w, top: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "E v e n t s",
                style: TextStyle(color: Colors.white, fontSize: 50.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
