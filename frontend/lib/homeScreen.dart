import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/activityAlert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var columnFlex = 25;

  Future<String?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('User');
  }

  List<Activity> activities = [
    Activity(
        heading: "Meeting Scheduled",
        message:
            "Review meeting for summer projects has been scheduled for Sunday 5th, September, everyone need to review their current progress related to it, each department will be sent a time slot and a meeting link they have to join accordingly, Regards!!",
        buttonOneTitle: "Acknowledge",
        buttonTwoTitle: "Can't attend"),
    Activity(
        heading: "Event Added",
        message:
            "The event 'Vortex 360' has been added to the events tab, kindly check the targets and contribution details, the point list has alo be added to the files tab in the event",
        buttonOneTitle: "Check",
        buttonTwoTitle: "Appeal Prob."),
    Activity(
        heading: "Task Added",
        message:
            "New post up on social media on vortex 360, kindly review the targets regarding that",
        buttonOneTitle: "Do it...",
        buttonTwoTitle: "Appeal Prob"),
    Activity(
        heading: "Meeting Scheduled",
        message:
            "Review meeting for summer projects has been scheduled for Sunday 5th, September, everyone need to review their current progress related to it, each department will be sent a time slot and a meeting link they have to join accordingly, Regards!!",
        buttonOneTitle: "Acknowledge",
        buttonTwoTitle: "Can't attend"),
  ];

  var user;

  void connectUser() async {
    var userData = await getUser();
    setState(() {
      user = jsonDecode(userData!);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 5.w, bottom: 5.h),
              child: Container(
                height: double.maxFinite,
                width: 190,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('images/brandLogo.jpg'),
                      height: 120,
                    ),
                    Text(
                      "User",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 10.h, bottom: 20.h),
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: Image(
                                  image: NetworkImage(
                                    user['photoURL'],
                                  ),
                                  height: 30.h,
                                  width: 30.w,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "${user['firstName']} ${user['lastName']}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Menu",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MenuButtons(
                      icon: CupertinoIcons.antenna_radiowaves_left_right,
                      heading: "Updates",
                      selectionColor: Colors.blue.shade800,
                    ),
                    MenuButtons(
                      icon: CupertinoIcons.timer,
                      heading: "Tasks",
                      selectionColor: Colors.black,
                    ),
                    MenuButtons(
                      icon: CupertinoIcons.desktopcomputer,
                      heading: "Meetings",
                      selectionColor: Colors.black,
                    ),
                    MenuButtons(
                      icon: CupertinoIcons.calendar_badge_minus,
                      heading: "Events",
                      selectionColor: Colors.black,
                    ),
                    MenuButtons(
                      icon: CupertinoIcons.person_add,
                      heading: "Appliers",
                      selectionColor: Colors.black,
                    ),
                    MenuButtons(
                      icon: CupertinoIcons.chat_bubble_text,
                      heading: "Messages",
                      selectionColor: Colors.black,
                    ),
                    MenuButtons(
                      icon: Icons.people_alt_outlined,
                      heading: "Core",
                      selectionColor: Colors.black,
                    ),
                    MenuButtons(
                      icon: CupertinoIcons.xmark,
                      heading: "LogOut",
                      selectionColor: Colors.black,
                    ),
                    Spacer(),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                      indent: 50,
                      endIndent: 50,
                    ),
                    Text(
                      "roboVITics 2021",
                      style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.w, right: 10.w, top: 5.h, bottom: 5.h),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Greetings, ${user['firstName']} ${user['lastName']}...",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 700.w,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25.r),
                          child: Image(
                            image: NetworkImage(user['photoURL']),
                            height: 50.h,
                            width: 50.w,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.black,
                      width: 700.w,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "For you Today!!!",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: 1150.w,
                      height: 300.h,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return ActivityBox(
                                heading: activities[index].heading,
                                message: activities[index].message,
                                ButtonOneTitle:
                                    activities[index].buttonOneTitle,
                                ButtonTwoTitle:
                                    activities[index].buttonTwoTitle);
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Task Assigned to you...",
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              height: 40.h,
                              width: 400.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                      color: Colors.black, width: 2.w)),
                              child: Center(
                                  child: Text(
                                      "Complete the like target given to you")),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class ActivityBox extends StatelessWidget {
  ActivityBox(
      {required this.heading,
      required this.message,
      required this.ButtonOneTitle,
      required this.ButtonTwoTitle});

  final String heading;
  final String message;
  final String ButtonOneTitle;
  final String ButtonTwoTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 250.h,
        width: 400.w,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Text(
                message,
                style: TextStyle(color: Colors.grey, fontSize: 13.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.indigo, width: 2.w),
                    ),
                    height: 40.h,
                    width: 160.w,
                    child: Center(
                      child: Text(
                        ButtonOneTitle,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.indigo, width: 2.w),
                    ),
                    height: 40.h,
                    width: 170.w,
                    child: Center(
                      child: Text(
                        ButtonTwoTitle,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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

class MenuButtons extends StatelessWidget {
  const MenuButtons(
      {required this.heading,
      required this.icon,
      required this.selectionColor});

  final IconData icon;
  final String heading;
  final Color selectionColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
            color: selectionColor, borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 30.sp,
                color: Colors.white,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                heading,
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
