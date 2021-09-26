import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/NoticeModel.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
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

  @override
  Widget build(BuildContext context) {
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
                builder: (_, AsyncSnapshot<List<NoticeModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                            child: Text(
                          "Loading...",
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.sp),
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
                              model: snapshot.data!.elementAt(index),
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
}

class NoticeBox extends StatelessWidget {
  NoticeBox({required this.model});

  NoticeModel model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Container(
        height: 750.h,
        width: 450.w,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: TextStyle(
                    color: Colors.white, fontSize: 20.sp, letterSpacing: 2),
              ),
              SizedBox(
                height: 5.h,
              ),
              Expanded(
                child: Text(
                  model.description,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 550.h,
                width: 500.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: SfPdfViewer.network(model.docLink),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NoticeButton(
                    buttonColor: Colors.red,
                    buttonTitle: "Raise Concent",
                    titleColor: Colors.white,
                    onTap: () {
                      print("Hello red");
                    },
                  ),
                  NoticeButton(
                    buttonTitle: "Discussions",
                    buttonColor: Colors.yellow,
                    titleColor: Colors.black,
                    onTap: () => print("Hello Discussions"),
                  ),
                  NoticeButton(
                    buttonTitle: "Acknowledge",
                    buttonColor: Colors.green,
                    titleColor: Colors.white,
                    onTap: () {
                      print("Acknowledged");
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NoticeButton extends StatelessWidget {
  NoticeButton(
      {required this.buttonTitle,
      required this.buttonColor,
      required this.titleColor,
      this.onTap});

  final String buttonTitle;
  final Color buttonColor;
  final Color titleColor;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.blueAccent)),
        height: 40.h,
        width: 120.w,
        child: Center(
          child: Text(
            buttonTitle,
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
        ),
      ),
    );
  }
}
