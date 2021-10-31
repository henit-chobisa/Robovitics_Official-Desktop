import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class docSubmissionPage extends StatefulWidget {
  const docSubmissionPage({Key? key}) : super(key: key);

  @override
  _docSubmissionPageState createState() => _docSubmissionPageState();
}

class _docSubmissionPageState extends State<docSubmissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Add your submission",
                  style: TextStyle(color: Colors.white, fontSize: 35.sp),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
