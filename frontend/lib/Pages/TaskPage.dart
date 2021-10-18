import 'dart:convert';
import 'package:frontend/Pages/TaskView.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/Task.dart';
import 'package:frontend/Classes/UserB.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Future<UserB> getCurrentUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.get("UserB");
    var userJson = jsonDecode(user.toString());
    UserB currentUser = UserB.fromJson(userJson);
    return currentUser;
  }

  Future<List<Task>> getUserTask(String userID) async {
    var response = await http.get(Uri.parse(
        "http://127.0.0.1:1000/api/tasks/getUserTask?userID=${userID}"));
    List<dynamic> decoded = await jsonDecode(response.body);
    List<Task> allTasks = decoded.map((data) => Task.fromJson(data)).toList();
    return allTasks;
  }

  @override
  void initState() {
    super.initState();
  }

  int getCoreTaskCount(List<Task> alltask) {
    var sum = 0;
    alltask.forEach((element) {
      if (element.isTeamTask == false) {
        sum++;
      }
    });
    print(sum);
    return sum;
  }

  int getTeamTaskCount(List<Task> alltask) {
    var sum = 0;
    // print(alltask.elementAt(0).isTeamTask);
    alltask.forEach((element) {
      if (element.isTeamTask == true) {
        sum++;
      }
    });
    print(sum);
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(32.sp),
          child: FutureBuilder<UserB>(
              future: getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    "Loading",
                    style:
                        TextStyle(color: Colors.grey.shade200, fontSize: 15.sp),
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Text(
                    "No Response from backend, Sorry!",
                    style:
                        TextStyle(color: Colors.grey.shade200, fontSize: 15.sp),
                  );
                }
                UserB currentUser = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assigned Task",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.sp,
                          fontFamily: "Futura"),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    FutureBuilder<List<Task>>(
                        future: getUserTask(currentUser.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(
                              "Loading",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.sp,
                                  fontStyle: FontStyle.italic),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return Text(
                              "No Response from backend, Sorry!",
                              style: TextStyle(
                                  color: Colors.grey.shade200, fontSize: 15.sp),
                            );
                          } else {
                            if (!snapshot.hasData) {
                              return Text(
                                "Sorry, error fetching data!",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.sp,
                                    fontStyle: FontStyle.italic),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Core Task",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.sp,
                                      fontFamily: "Futura"),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  height: 570.h,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      shrinkWrap: true,
                                      itemBuilder: (_, index) {
                                        if (snapshot.data!
                                                .elementAt(index)
                                                .isTeamTask ==
                                            false) {
                                          return TaskTile(
                                            currentUser: currentUser,
                                            taskModel:
                                                snapshot.data!.elementAt(index),
                                          );
                                        } else {
                                          return SizedBox(
                                            height: 0,
                                            width: 0,
                                          );
                                        }
                                      }),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Team Task",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.sp,
                                      fontFamily: "Futura"),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  height: 570.h,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (_, index) {
                                        if (snapshot.data!
                                                .elementAt(index)
                                                .isTeamTask ==
                                            true) {
                                          return TaskTile(
                                            currentUser: currentUser,
                                            taskModel:
                                                snapshot.data!.elementAt(index),
                                          );
                                        } else {
                                          return SizedBox(
                                            height: 0,
                                            width: 0,
                                          );
                                        }
                                      }),
                                ),
                              ],
                            );
                          }
                        }),
                  ],
                );
              }),
        ),
      ),
    ));
  }
}

class TaskTile extends StatelessWidget {
  TaskTile({required this.taskModel, required this.currentUser});

  final UserB currentUser;
  final Task taskModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 8.w),
      child: Container(
        height: 450.h,
        width: 400.w,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.grey.shade700),
            borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        taskModel.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text(
                    "+ ${taskModel.pointsAlloted}",
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 20.sp,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  // Flexible(
                  //   child: Container(
                  //     height: 30.h,
                  //     decoration: BoxDecoration(
                  //         border: Border.all(color: Colors.grey.shade500),
                  //         borderRadius: BorderRadius.circular(20.r)),
                  //     child: Center(
                  //       child: Text(
                  //         "Pending",
                  //         style:
                  //             TextStyle(color: Colors.white, fontSize: 12.sp),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                color: Colors.transparent,
                height: 50.h,
                child: Text(
                  taskModel.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              Flexible(
                child: Image(
                    width: double.maxFinite,
                    fit: BoxFit.contain,
                    image: NetworkImage(taskModel.bannerLink)),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TaskView(
                              model: taskModel,
                              currentUser: currentUser,
                            ))),
                child: Container(
                  height: 50.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Text(
                      "View Task",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
