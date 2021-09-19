import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/Event.dart';
import 'package:http/http.dart' as http;

class eventPage extends StatefulWidget {
  const eventPage({Key? key}) : super(key: key);

  @override
  _eventPageState createState() => _eventPageState();
}

class _eventPageState extends State<eventPage> {
  Future<void> getEvent() async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:1000/api/events/allEvents"));
    List<dynamic> data = await jsonDecode(response.body);
    List<Event> events = data.map((data) => Event.fromJson(data)).toList();
    print(events.length);
  }

  @override
  Widget build(BuildContext context) {
    getEvent();
    return Expanded(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 40.w, top: 40.h, right: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "E v e n t s",
                style: TextStyle(color: Colors.white, fontSize: 50.sp),
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Your Contributions",
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
              SizedBox(
                height: 10,
              ),
              ContributionTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class ContributionTile extends StatelessWidget {
  const ContributionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 400.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Vortex 360',
                      style: TextStyle(color: Colors.black, fontSize: 25.sp),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      width: 80.w,
                      height: 1.h,
                      color: Colors.black,
                    )
                  ],
                ),
                SizedBox(
                  width: 170.w,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(18.r),
                  child: Image(
                    image: NetworkImage(
                        'https://res.cloudinary.com/ddglxo0l3/image/upload/v1630584083/ProfileImages/nopx6nmt8fs70qhlgxsp.png'),
                    height: 36.h,
                    width: 36.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '+5',
                  style:
                      TextStyle(color: Colors.green.shade800, fontSize: 70.sp),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  width: 2.w,
                  height: 50.h,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Registration Contribution',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Aman Bansal',
                      style: TextStyle(
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
                    ),
                    Text(
                      '@Instagram',
                      style: TextStyle(
                          color: Colors.pink.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          letterSpacing: 2),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
