import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:frontend/Classes/NoticeModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/UserB.dart';
import 'package:frontend/Widgets/NoticeBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_core/core.dart';

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
    TextEditingController messageController = TextEditingController();

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
                          docLink: widget.model.docLink),
                      Expanded(
                        child: Container(
                          height: 750.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.people_alt_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "Discussions",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.sp),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                SenderBlock(),
                                RecievedBlock(),
                                Container(
                                  height: 50.h,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.r)),
                                            child: Center(
                                              child: TextField(
                                                controller: messageController,
                                                cursorColor: Colors.white,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.sp),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Type your Snadesh here ...",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12.sp),
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Container(
                                          height: 50.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              color: Colors.blueAccent.shade700,
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.send,
                                                  color: Colors.white,
                                                  size: 13.sp,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  "Send",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.sp),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.w, right: 5.w),
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.black,
                                            size: 20.sp,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.w, right: 10.w),
                                          child: Icon(
                                            Icons.file_copy,
                                            color: Colors.black,
                                            size: 20.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class SenderBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
          child: Flexible(
            child: Container(
              constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
                child: Column(
                  children: [
                    Text(
                      "Hello nkcndanv kvndklnvlfnvfndkbnfdkbmnfdkl klnvgjrnrneionreiobnreobjreiboienbvorenoi",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "8 : 10 PM",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class RecievedBlock extends StatefulWidget {
  const RecievedBlock({Key? key}) : super(key: key);

  @override
  _RecievedBlockState createState() => _RecievedBlockState();
}

class _RecievedBlockState extends State<RecievedBlock> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
          child: Flexible(
            child: Container(
              constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
                child: Column(
                  children: [
                    Text(
                      "Hello nkcndanv kvndklnvlfnvfndkbnfdkbmnfdkl klnvgjrnrneionreiobnreobjreiboienbvorenoi",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "8 : 10 PM",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
    ;
  }
}
