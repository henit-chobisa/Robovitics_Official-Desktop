import 'dart:convert';
import 'package:frontend/Widgets/NoticeBox.dart';
import 'package:frontend/homeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/Classes/ConcentModel.dart';
import 'package:frontend/Classes/NoticeModel.dart';
import 'package:frontend/Classes/UserB.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoticeConsentPage extends StatefulWidget {
  NoticeConsentPage({required this.model, required this.filePath});

  NoticeModel model;
  String filePath;
  @override
  _NoticeConsentPageState createState() => _NoticeConsentPageState();
}

class _NoticeConsentPageState extends State<NoticeConsentPage> {
  Future<UserB> getCurrentUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.get("UserB");
    var userJson = jsonDecode(user.toString());
    UserB currentUser = UserB.fromJson(userJson);
    return currentUser;
  }

  List<ConcentModel> concents = [];
  TextEditingController consentController = TextEditingController();

  @override
  void initState() {
    LoadPreviousConcents();
    super.initState();
  }

  void LoadPreviousConcents() async {
    var response = await http.get(Uri.parse(
        "http://127.0.0.1:1000/api/notice/getConcents?noticeID=${widget.model.id}"));
    var decoded = jsonDecode(response.body) as List<dynamic>;
    var decodedConcents = decoded.map((e) => ConcentModel.fromJson(e)).toList();
    decodedConcents.forEach((element) {
      setState(() {
        concents.add(element);
      });
    });
  }

  void addConcent(String Consent) async {
    var body = {
      "noticeID": widget.model.id,
      "concent": Consent,
    };
    var headers = {"Content-Type": "application/json"};
    var response = await http.post(
        Uri.parse("http://127.0.0.1:1000/api/notice/addConcent"),
        body: jsonEncode(body),
        headers: headers);
    if (response.statusCode == 200) {
      var decodedData = await jsonDecode(response.body);
      ConcentModel concent = ConcentModel.fromJson(decodedData);
      setState(() {
        concents.add(concent);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCurrentUser(),
        builder: (context, AsyncSnapshot<UserB> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(
                "Loading",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontStyle: FontStyle.italic),
              ),
            );
          } else {
            var currentUser = snapshot.data!;
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => homePage(currentPageIndex: 5)));
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
                          docLink: widget.model.docLink,
                          isRowVisible: false,
                          preLoadedFilePath: widget.filePath,
                        ),
                        Expanded(
                          child: Container(
                              height: 750.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Consents',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 30.sp),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: concents.length,
                                          itemBuilder: (_, index) {
                                            return ConsentWidget(
                                              concentModel:
                                                  concents.elementAt(index),
                                              currentUser: currentUser,
                                            );
                                          }),
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(25.r)),
                                      child: Padding(
                                        padding: EdgeInsets.all(5.sp),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                constraints: BoxConstraints(
                                                    maxHeight: 100),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r)),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 10.w,
                                                    right: 10.w,
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: TextField(
                                                      maxLines: null,
                                                      cursorColor: Colors.black,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12.sp),
                                                      controller:
                                                          consentController,
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          errorBorder:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          focusedErrorBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          disabledBorder:
                                                              InputBorder.none,
                                                          hintText:
                                                              "Raise your consent here...",
                                                          hintStyle: TextStyle(
                                                              color: Colors.grey
                                                                  .shade700,
                                                              fontSize: 13.sp)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  addConcent(
                                                      consentController.text);
                                                  setState(() {
                                                    consentController.text = "";
                                                  });
                                                },
                                                child: Container(
                                                  height: 50.h,
                                                  decoration: BoxDecoration(
                                                      color: Colors
                                                          .blueAccent.shade700,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r)),
                                                  child: Center(
                                                    child: Text(
                                                      "Raise!",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.sp),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}

class ConsentWidget extends StatefulWidget {
  ConsentWidget({required this.concentModel, required this.currentUser});

  ConcentModel concentModel;
  UserB currentUser;

  @override
  _ConsentWidgetState createState() => _ConsentWidgetState();
}

class _ConsentWidgetState extends State<ConsentWidget> {
  bool upvoteVisible = true;
  bool downvoteVisible = true;
  Color upvoteColor = Colors.grey;
  Color downvoteColor = Colors.grey;

  @override
  void initState() {
    checkCurrentUserVote();
    // TODO: implement initState
    super.initState();
  }

  void Upvoted() {
    setState(() {
      upvoteColor = Colors.green;
      downvoteVisible = false;
    });
  }

  void Downvoted() {
    setState(() {
      downvoteColor = Colors.redAccent;
      upvoteVisible = false;
    });
  }

  void checkCurrentUserVote() {
    if (widget.concentModel.UpvotedBy.contains(widget.currentUser.id)) {
      Upvoted();
    } else if (widget.concentModel.DownvotedBy
        .contains(widget.currentUser.id)) {
      Downvoted();
    }
  }

  void addUpvote() async {
    if (upvoteColor != Colors.green) {
      var body = {
        "concentID": "${widget.concentModel.id}",
        "UserID": "${widget.currentUser.id}"
      };
      var headers = {
        "Content-Type": "application/json",
      };
      var response = await http.post(
          Uri.parse("http://127.0.0.1:1000/api/notice/addUpvote"),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        widget.concentModel.Upvotes++;
        Upvoted();
      }
    }
  }

  void addDownvote() async {
    if (downvoteColor != Colors.redAccent) {
      var body = {
        "concentID": "${widget.concentModel.id}",
        "UserID": "${widget.currentUser.id}"
      };
      var headers = {
        "Content-Type": "application/json",
      };
      var response = await http.post(
          Uri.parse("http://127.0.0.1:1000/api/notice/addDownvote"),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        widget.concentModel.Downvotes++;
        Downvoted();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
      child: Flexible(
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r), color: Colors.black),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  constraints: BoxConstraints(minWidth: 100.w, maxWidth: 700.w),
                  child: Text(
                    widget.concentModel.Concent,
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    addUpvote();
                  },
                  child: Visibility(
                    visible: upvoteVisible,
                    child: Container(
                      child: Icon(
                        Icons.thumb_up_alt_outlined,
                        color: upvoteColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  widget.concentModel.Upvotes.toString(),
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 15.w,
                ),
                GestureDetector(
                  onTap: () {
                    addDownvote();
                  },
                  child: Visibility(
                    visible: downvoteVisible,
                    child: Container(
                      child: Icon(
                        Icons.thumb_down_alt_outlined,
                        color: downvoteColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  widget.concentModel.Downvotes.toString(),
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
