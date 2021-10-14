import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/Task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(32.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assigned Task",
                style: TextStyle(
                    color: Colors.white, fontSize: 35.sp, fontFamily: "Futura"),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Core Task",
                style: TextStyle(
                    color: Colors.white, fontSize: 30.sp, fontFamily: "Futura"),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 570.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (_, index) => TaskTile(
                    taskModel: null,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Team Task",
                style: TextStyle(
                    color: Colors.white, fontSize: 30.sp, fontFamily: "Futura"),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 570.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (_, index) => TaskTile(
                    taskModel: null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class TaskTile extends StatelessWidget {
  TaskTile({this.taskModel});

  final Task? taskModel;

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
                  Text(
                    "Heading",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "+5",
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 20.sp,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Flexible(
                    child: Container(
                      height: 30.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade500),
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Center(
                        child: Text(
                          "Pending",
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                color: Colors.transparent,
                height: 50.h,
                child: Text(
                  "This is the task provided by robovitics, and on its completion you will get some points",
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
                    image: NetworkImage(
                        "https://res.cloudinary.com/ddglxo0l3/image/upload/v1634223313/ProfileImages/240806882_826048344768127_7284435366260518300_n_ihjkkp.jpg")),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
