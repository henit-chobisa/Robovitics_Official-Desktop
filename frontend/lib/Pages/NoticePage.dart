import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/NoticeModel.dart';
import 'package:frontend/Classes/UserB.dart';
import 'package:frontend/Widgets/NoticeBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  Future<List<NoticeModel>> getNotices() async {
    var response = await http
        .get(Uri.parse("http://127.0.0.1:1000/api/notice/getAllNotices"));
    var body = response.body;
    List<dynamic> jsonConvertible = await jsonDecode(body);
    List<NoticeModel> notices =
        jsonConvertible.map((data) => NoticeModel.fromJson(data)).toList();
    return notices;
  }

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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(
              "Loading",
              style: TextStyle(color: Colors.white),
            );
          } else {
            final UserB currentUser = snapshot.data!;
            return Expanded(
                child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 40.w, top: 40.h, right: 40.w),
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notices",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontFamily: "Futura",
                          letterSpacing: 3),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    FutureBuilder(
                        future: getNotices(),
                        builder:
                            (_, AsyncSnapshot<List<NoticeModel>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                    child: Text(
                                  "Loading...",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                )),
                              ],
                            );
                          } else {
                            return Container(
                              height: 750.h,
                              width: double.maxFinite,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (_, index) {
                                    return NoticeBox(
                                      currentUser: currentUser,
                                      model: snapshot.data!.elementAt(index),
                                      docLink: snapshot.data!
                                          .elementAt(index)
                                          .docLink,
                                    );
                                  }),
                            );
                          }
                        })
                  ],
                )),
              ),
            ));
          }
        });
  }
}
