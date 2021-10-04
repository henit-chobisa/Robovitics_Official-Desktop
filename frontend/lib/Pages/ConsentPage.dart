import 'dart:convert';
import 'package:frontend/Widgets/NoticeBox.dart';
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

  @override
  void initState() {
    LoadPreviousConcents();
    // TODO: implement initState
    super.initState();
  }

  void LoadPreviousConcents() async {
    var response = await http.get(Uri.parse(
        "http://127.0.0.1:1000/api/notice/getConcents?noticeID=${widget.model.id}"));
    var decoded = jsonDecode(response.body) as List<dynamic>;
    print(decoded);
    var decodedConcents = decoded.map((e) => ConcentModel.fromJson(e)).toList();
    decodedConcents.forEach((element) {
      setState(() {
        concents.add(element);
      });
    });
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
                          ),
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
