import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/activityAlert.dart';
import 'package:frontend/Classes/radioButton.dart';
import 'package:frontend/Pages/EventPage.dart';
import 'package:frontend/Pages/NoticePage.dart';
import 'package:frontend/Pages/TaskPage.dart';
import 'package:frontend/Pages/landingPage.dart';
import 'package:keyboard_shortcuts/keyboard_shortcuts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Classes/User.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var columnFlex = 25;
  bool menuVisible = true;

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

  List<RadioButton> radioButtons = [
    RadioButton(
        title: "Updates",
        icon: CupertinoIcons.antenna_radiowaves_left_right,
        isPressed: true,
        associatedPage: landingPage()),
    RadioButton(
        title: "Tasks",
        icon: CupertinoIcons.timer,
        isPressed: false,
        associatedPage: landingPage()),
    RadioButton(
        title: "Meetings",
        icon: CupertinoIcons.desktopcomputer,
        isPressed: false,
        associatedPage: landingPage()),
    RadioButton(
        title: "Events",
        icon: CupertinoIcons.calendar_badge_minus,
        isPressed: false,
        associatedPage: landingPage()),
    RadioButton(
        title: "Appliers",
        icon: CupertinoIcons.person_add,
        isPressed: false,
        associatedPage: landingPage()),
    RadioButton(
        title: "Notices",
        icon: CupertinoIcons.chat_bubble_text,
        isPressed: false,
        associatedPage: landingPage()),
    RadioButton(
        title: "Core",
        icon: Icons.people_alt_outlined,
        isPressed: false,
        associatedPage: landingPage())
  ];

  var user;
  var currentPageIndex = 0;
  List<Widget> pages = [
    landingPage(),
    TaskPage(),
    landingPage(),
    eventPage(),
    landingPage(),
    NoticePage(),
    landingPage()
  ];

  void connectUser() async {
    var userData = await getUser();
    setState(() {
      user = jsonDecode(userData!.toString());
    });
  }

  bool getPressedStatus(int index) {
    if (currentPageIndex == index) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectUser();
  }

  @override
  Widget build(BuildContext context) {
    connectUser();
    return KeyBoardShortcuts(
      keysToPress: {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyM},
      onKeysPressed: () {
        setState(() {
          menuVisible = !menuVisible;
        });
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: Row(
            children: [
              Visibility(
                visible: menuVisible,
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 5.w, bottom: 5.h),
                  child: Container(
                    height: double.maxFinite,
                    width: 190,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('images/brandLogoBlack.png'),
                          height: 120,
                        ),
                        Text(
                          "User",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.w, right: 10.w, top: 10.h, bottom: 20.h),
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                                color: Colors.black,
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
                                        color: Colors.white, fontSize: 12.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Menu",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: radioButtons.length,
                            itemBuilder: (_, index) {
                              return MenuButtons(
                                heading: radioButtons[index].title,
                                icon: radioButtons[index].icon,
                                isPressed: getPressedStatus(index),
                                associatedPage: landingPage(),
                                ontap: () {
                                  setState(() {
                                    currentPageIndex = index;
                                  });
                                },
                              );
                            }),
                        MenuButtons(
                          icon: CupertinoIcons.xmark,
                          heading: "LogOut",
                          isPressed: false,
                          associatedPage: landingPage(),
                          ontap: () {
                            print("Hello World");
                          },
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
              ),
              pages[currentPageIndex],
              // KeyBoardShortcuts(
              //
              // )
            ],
          )),
    );
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
      required this.isPressed,
      required this.associatedPage,
      required this.ontap});

  final IconData icon;
  final String heading;
  final bool isPressed;
  final Widget associatedPage;
  final ontap;

  Color backgroundColor() {
    if (isPressed == true) {
      return Colors.blue.shade800;
    } else {
      return Colors.white;
    }
  }

  Color getTextColor() {
    if (isPressed == true) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
              color: backgroundColor(),
              borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 30.sp,
                  color: getTextColor(),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  heading,
                  style: TextStyle(color: getTextColor(), fontSize: 15.sp),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
