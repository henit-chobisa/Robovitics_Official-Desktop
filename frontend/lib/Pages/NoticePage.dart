import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/NoticeModel.dart';
import 'package:frontend/Classes/UserB.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class NoticeBox extends StatefulWidget {
  NoticeBox({required this.model, required this.currentUser});

  UserB currentUser;
  NoticeModel model;

  @override
  _NoticeBoxState createState() => _NoticeBoxState();
}

class _NoticeBoxState extends State<NoticeBox> {
  Color acknowledgement = Colors.white;
  Color acknowledgementBorder = Colors.blue;
  bool isAcknowledged = false;

  @override
  Widget build(BuildContext context) {
    bool getAcknowStatus() {
      for (var i = 0; i < widget.model.AcknowledgeBy.length; i++) {
        if (widget.model.AcknowledgeBy[i].userID == widget.currentUser.id) {
          return true;
        }
      }
      return false;
    }

    Color getAcknowledgementBgColor() {
      if (getAcknowStatus() || isAcknowledged) {
        return Colors.green;
      } else {
        return Colors.blueAccent;
      }
    }

    void getStatus() {}

    String getAcknowString() {
      if (getAcknowStatus() || isAcknowledged) {
        return "Acknowledged!";
      } else {
        return "Acknowledge";
      }
    }

    void ConfirmAcknowledgement() async {
      print(widget.model.id);
      print(widget.currentUser.id);
      print(widget.currentUser.userName);
      var body = {
        "noticeID": widget.model.id,
        "userBID": widget.currentUser.id
      };
      var headers = {"Content-Type": "application/json"};
      var response = await http.post(
          Uri.parse("http://127.0.0.1:1000/api/notice/createAcknow"),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        setState(() {
          isAcknowledged = true;
        });
      }
    }

    getStatus();
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Container(
        height: 750.h,
        width: 450.w,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.model.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.h,
              ),
              Expanded(
                child: Text(
                  widget.model.description,
                  style:
                      TextStyle(color: Colors.grey.shade800, fontSize: 12.sp),
                ),
              ),
              // Text(
              //   "${model.timeStamp.hour} : ${model.timeStamp.minute}, ${model.timeStamp.day}-${model.timeStamp.month}-${model.timeStamp.year}",
              //   style: TextStyle(color: Colors.grey.shade800),
              // ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                flex: 10,
                child: Container(
                  height: 550.h,
                  width: 500.w,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: SfPdfViewer.network(
                          "http://www.pdf995.com/samples/pdf.pdf")
                      // child: PdfViewer.openAsset(model.docLink),
                      ),
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
                    buttonColor: Colors.yellow.shade700,
                    titleColor: Colors.black,
                    onTap: () => print("Hello Discussions"),
                  ),
                  NoticeButton(
                    buttonTitle: getAcknowString(),
                    buttonColor: getAcknowledgementBgColor(),
                    titleColor: Colors.white,
                    onTap: () {
                      ConfirmAcknowledgement();
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
          color: buttonColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        height: 40.h,
        width: 120.w,
        child: Center(
          child: Text(
            buttonTitle,
            style: TextStyle(color: titleColor, fontSize: 12.sp),
          ),
        ),
      ),
    );
  }
}
