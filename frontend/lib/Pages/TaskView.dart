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
              child: Flexible(
                child: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  color: Colors.redAccent, fontSize: 25.sp),
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
                                      color: Colors.yellowAccent,
                                      fontSize: 30.sp,
                                      // fontWeight: FontWeight.bold
                                    ),
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
                                  Divider(
                                    color: Colors.grey,
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
                                    height: 150.h,
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount:
                                            widget.model.assignedTo.length,
                                        itemBuilder: (_, index) {
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(right: 20.w),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.r),
                                                    child: Image(
                                                        image: NetworkImage(
                                                            widget.model
                                                                .assignedTo
                                                                .elementAt(
                                                                    index)
                                                                .photoURL),
                                                        fit: BoxFit.cover,
                                                        height: 100.h,
                                                        width: 100.w)),
                                                Text(
                                                  widget.model.assignedTo
                                                      .elementAt(index)
                                                      .userName,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.sp),
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    height: 20.sp,
                                  ),
                                  Text(
                                    "Document References",
                                    style: TextStyle(
                                        color: Colors.blue.shade200,
                                        fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: widget
                                          .model.referencingDocumentLink.length,
                                      itemBuilder: (_, index) {
                                        return Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade800,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.w),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 6,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Text(
                                                        widget.model
                                                            .referencingDocumentLink
                                                            .elementAt(0),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.r)),
                                                    child: Center(
                                                      child: Text(
                                                        "Copy URL",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.sp),
                                                      ),
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(16.sp),
                                child: Container(
                                  height: 450.h,
                                  width: 450.w,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(225.r),
                                      border: Border.all(
                                          color: Colors.white, width: 3.sp)),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.sp),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Center(
                          child: Text(
                            "Ask your mentor!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.sp,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Container(
                          height: 700.h,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: Colors.blue.shade200,
                              )),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: ListView.builder(itemBuilder: (_, index) {
                              return QuestionTile();
                            }),
                          ),
                        ),
                      ],
                    ),
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

class QuestionTile extends StatelessWidget {
  const QuestionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question 1 -> How can we be able to do this task it is literally very very hard and the duration of completion is also very low",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Expanded(flex: 2, child: Container()),
              Container(
                height: 300.h,
                width: 1.w,
                color: Colors.white,
              ),
              Expanded(
                flex: 20,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                  child: Container(
                      height: 300.h,
                      width: double.maxFinite,
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (_, index) {
                            return CommentTile();
                          })),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  const CommentTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.grey.shade800,
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 12.h),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image(
                      image: NetworkImage(
                          "https://res.cloudinary.com/ddglxo0l3/image/upload/v1631262965/ProfileImages/opaarbwrc6qg7pdifxwz.png"),
                      height: 24.h,
                      width: 24.h,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Henit Chobisa",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                  Spacer(),
                  Text(
                    "henitchobisa0885@gmail.com",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "I believe in infinite energy and I beileve in a broader vision to change the world. Hence I believe that every thing can be achieved with patience and strength and You guys have enough time for this, you can do it!, Believe in yourself guys I have a lots of expectations from you guys, You guys will be the next board members and if you are not able to handle such small problems how will you handle the club",
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
