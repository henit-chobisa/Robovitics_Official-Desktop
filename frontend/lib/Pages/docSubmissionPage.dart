import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/Task.dart';
import 'package:frontend/Classes/UserB.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';

class docSubmissionPage extends StatefulWidget {
  docSubmissionPage({required this.currentUser, required this.model});

  Task model;
  UserB currentUser;
  @override
  _docSubmissionPageState createState() => _docSubmissionPageState();
}

class _docSubmissionPageState extends State<docSubmissionPage> {
  String filePath = 'Choose your file';
  String Status = "Submit";
  TextEditingController commentController = TextEditingController();
  var file;
  final cloudinary =
      Cloudinary("146921317957316", "dMy6eCEsZ0YpupA_FoMaR_z_sEo", "ddglxo0l3");
  void getFile() async {
    try {
      final xtypegroup = XTypeGroup(label: 'document', extensions: ['pdf']);
      final openedFile = await openFile(acceptedTypeGroups: [xtypegroup]);
      var data = await openedFile?.readAsBytes();
      if (data != null) {
        var completedFile = File.fromRawPath(data);
        setState(() {
          filePath = openedFile!.path;
          file = completedFile;
        });
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> upload() async {
    if (file == null) {
      setState(() {
        filePath = "Please Select your file";
      });
    } else {
      setState(() {
        Status = "Uploading Document";
      });
      final response = await cloudinary.uploadFile(
          fileName:
              "${widget.currentUser.email}-${widget.currentUser.userName}",
          filePath: filePath,
          resourceType: CloudinaryResourceType.auto,
          folder: "${widget.model.title}-Submissions");
      if (response.isSuccessful) {
        var fileURL = response.secureUrl;
        setState(() {
          Status = "Adding Submission";
        });
        var body = {
          "taskID": widget.model.id,
          "userID": widget.currentUser.id,
          "comment": commentController.text,
          "docLink": fileURL
        };
        var result = await http.post(
            Uri.parse("http://127.0.0.1:1000/api/tasks/addSubmission"),
            body: jsonEncode(body),
            headers: {"content-type": "application/json"});
        if (result.statusCode == 200) {
          setState(() {
            Status = "Submitted";
            Navigator.pop(context);
          });
        }
      } else {
        setState(() {
          filePath = "Sorry, file selection error, Contact your mentor!";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Add your submission",
                  style: TextStyle(color: Colors.white, fontSize: 35.sp),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            filePath,
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: getFile,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Center(
                            child: Text(
                              "Open Explorer",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Center(
                  child: TextField(
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write your comment here",
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                upload();
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                  child: Text(
                    Status,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
