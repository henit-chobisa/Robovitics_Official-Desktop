import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/Task.dart';
import 'package:http/http.dart';

class TaskView extends StatefulWidget {
  TaskView({required this.model});

  final Task model;
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: NetworkImage(widget.model.bannerLink),
                height: 500.h,
                width: 500.w,
                fit: BoxFit.contain,
              ),
              Image(image: AssetImage("images/brandLogoBlack.png"))
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 550.h),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              )),
                          Text(
                            "Last Date : ${widget.model.lastDate.day} / ${widget.model.lastDate.month} / ${widget.model.lastDate.year}",
                            style: TextStyle(
                                color: Colors.redAccent.shade100,
                                fontSize: 25.sp),
                          ),
                          Spacer(),
                          Container(
                            width: 200.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade800,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Center(
                                child: Text(
                              "Acknowledge",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Container(
                            width: 200.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                                color: Colors.green.shade800,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Center(
                                child: Text(
                              "Add Submission",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.model.title,
                                  style: TextStyle(
                                      color: Colors.blue.shade100,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  widget.model.description,
                                  maxLines: 5,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.sp,
                                ),
                                Text(
                                  "Assigned To",
                                  style: TextStyle(
                                      color: Colors.blue.shade200,
                                      fontSize: 20.sp),
                                ),
                                Container(
                                  height: 200.h,
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: 10,
                                      itemBuilder: (_, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.w, right: 20.w),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.r),
                                                  child: Image(
                                                      image: NetworkImage(widget
                                                          .model.assignedTo
                                                          .elementAt(0)
                                                          .photoURL),
                                                      fit: BoxFit.cover,
                                                      height: 100.h,
                                                      width: 100.w)),
                                              Text(
                                                widget.model.assignedTo
                                                    .elementAt(0)
                                                    .userName,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.sp),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(16.sp),
                              child: Container(
                                height: 300.h,
                                width: 400.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                        color: Colors.white, width: 1.sp)),
                                child: Padding(
                                  padding: EdgeInsets.all(8.sp),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Mentored By",
                                        style: TextStyle(
                                            color: Colors.blue.shade300,
                                            fontSize: 20.sp),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.sp),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          child: Image(
                                              height: 200.h,
                                              width: 200.h,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(widget
                                                  .model.mentor.photoURL)),
                                        ),
                                      ),
                                      Text(
                                        widget.model.mentor.userName,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp),
                                      ),
                                      Text(
                                        widget.model.mentor.email,
                                        style: TextStyle(
                                            color: Colors.grey.shade200,
                                            fontSize: 13.sp,
                                            letterSpacing: 1),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class MentorTile extends StatelessWidget {
//   const MentorTile({
//     Key? key,
//     required this.widget,
//     required this.widget,
//     required this.widget,
//   }) : super(key: key);
//
//   final TaskView widget;
//   final TaskView widget;
//   final TaskView widget;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.sp),
//       child: Container(
//         height: 300.h,
//         width: 400.w,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.r),
//             border: Border.all(color: Colors.white, width: 1.sp)),
//         child: Padding(
//           padding: EdgeInsets.all(8.sp),
//           child: Column(
//             children: [
//               Text(
//                 "Mentored By",
//                 style: TextStyle(color: Colors.blue.shade300, fontSize: 20.sp),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(8.sp),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(100.r),
//                   child: Image(
//                       height: 200.h,
//                       width: 200.h,
//                       fit: BoxFit.cover,
//                       image: NetworkImage(widget.model.mentor.photoURL)),
//                 ),
//               ),
//               Text(
//                 widget.model.mentor.userName,
//                 style: TextStyle(color: Colors.white, fontSize: 20.sp),
//               ),
//               Text(
//                 widget.model.mentor.email,
//                 style: TextStyle(
//                     color: Colors.grey.shade200,
//                     fontSize: 13.sp,
//                     letterSpacing: 1),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
