import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/NoticeModel.dart';
import 'package:frontend/Classes/UserB.dart';
import 'package:frontend/Pages/ConsentPage.dart';
import 'package:frontend/Pages/NoticeDiscussion.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

import 'NoticeButton.dart';

class NoticeBox extends StatefulWidget {
  NoticeBox(
      {required this.model,
      required this.currentUser,
      required this.docLink,
      required this.isRowVisible,
      required this.preLoadedFilePath});

  UserB currentUser;
  NoticeModel model;
  String docLink;
  bool isRowVisible;
  String preLoadedFilePath;

  @override
  _NoticeBoxState createState() => _NoticeBoxState();
}

class _NoticeBoxState extends State<NoticeBox> {
  Color acknowledgement = Colors.white;
  Color acknowledgementBorder = Colors.blue;
  bool isAcknowledged = false;
  // bool _isLoading = true;
  // late PDFDocument document;
  String file = "";

  Future<String> loadPDF() async {
    var response = await http.get(Uri.parse(widget.docLink));
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/${widget.model.id}.pdf");
    await file.writeAsBytes(response.bodyBytes, flush: true);
    return file.path;
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.preLoadedFilePath == "") {
      loadPDF().then((value) => {
            setState(() {
              widget.preLoadedFilePath = value;
            })
          });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void getAcknowStatus() {
      for (var i = 0; i < widget.model.AcknowledgeBy.length; i++) {
        if (widget.model.AcknowledgeBy[i].id == widget.currentUser.id) {
          setState(() {
            isAcknowledged = true;
          });
        }
      }
    }

    Color getAcknowledgementBgColor() {
      if (isAcknowledged) {
        return Colors.green;
      } else {
        return Colors.blueAccent;
      }
    }

    String getAcknowString() {
      if (isAcknowledged) {
        return "Acknowledged!";
      } else {
        return "Acknowledge";
      }
    }

    void ConfirmAcknowledgement() async {
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

    getAcknowStatus();
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
                      child: widget.preLoadedFilePath != ""
                          ? SfPdfViewer.asset(widget.preLoadedFilePath)
                          : Center(
                              child: Text("Loading",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12.sp)))),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Visibility(
                visible: widget.isRowVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NoticeButton(
                      buttonColor: Colors.red,
                      buttonTitle: "Raise Concent",
                      titleColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => NoticeConsentPage(
                                      model: widget.model,
                                      filePath: widget.preLoadedFilePath,
                                    )));
                      },
                    ),
                    NoticeButton(
                      buttonTitle: "Discussions",
                      buttonColor: Colors.yellow.shade700,
                      titleColor: Colors.black,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => NoticeDiscussion(
                                    model: widget.model,
                                    filePath: widget.preLoadedFilePath,
                                  ))),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
