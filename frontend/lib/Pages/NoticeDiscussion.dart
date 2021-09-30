import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/Classes/NoticeModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/UserB.dart';
import 'package:frontend/Widgets/NoticeBox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticeDiscussion extends StatefulWidget {
  NoticeDiscussion({required this.model});

  NoticeModel model;
  @override
  _NoticeDiscussionState createState() => _NoticeDiscussionState();
}

class _NoticeDiscussionState extends State<NoticeDiscussion> {
  Future<UserB> getCurrentUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.get("UserB");
    print(user);
    var userJson = jsonDecode(user.toString());
    UserB currentUser = UserB.fromJson(userJson);
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCurrentUser(),
        builder: (context, AsyncSnapshot<UserB> snapshot) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                widget.model.title,
                style: TextStyle(color: Colors.black),
              ),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      NoticeBox(
                          model: widget.model,
                          currentUser: snapshot.data!,
                          docLink: widget.model.docLink)
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
