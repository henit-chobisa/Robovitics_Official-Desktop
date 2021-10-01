import 'dart:convert';
import 'package:frontend/Classes/DiscussionModel.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:frontend/Classes/NoticeModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/UserB.dart';
import 'package:frontend/Widgets/NoticeBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_core/core.dart';

class NoticeDiscussion extends StatefulWidget {
  NoticeDiscussion({required this.model});

  NoticeModel model;

  @override
  _NoticeDiscussionState createState() => _NoticeDiscussionState();
}

class _NoticeDiscussionState extends State<NoticeDiscussion> {
  Future<UserB> getCurrentUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.get("UserB");
    var userJson = jsonDecode(user.toString());
    UserB currentUser = UserB.fromJson(userJson);
    return currentUser;
  }

  late io.Socket socket;
  ScrollController scrollController = ScrollController();

  List<DiscussionModel> discussions = [];

  @override
  void initState() {
    Connect();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  void sortDiscussions() {
    discussions.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
  }

  void Connect() {
    socket = io.io(
        "http://127.0.0.1:1000/?roomID=${widget.model.id}", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.on('connect', (data) => print("connected"));
    socket.onConnect((data) {
      socket.on('text', (data) async {
        DiscussionModel discussion = DiscussionModel.fromJson(data);
        setState(() {
          discussions.add(discussion);
          sortDiscussions();
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 10), curve: Curves.easeInOut);
        });
      });
    });
  }

  void sendMessage(
    UserB currentUser,
    String payload,
    String messageType,
  ) {
    DiscussionModel discussion = DiscussionModel(
        id: "0",
        userInfo: currentUser,
        payload: payload,
        messageType: messageType,
        timeStamp: DateTime.now());
    var data = discussion.toJson();
    setState(() {
      discussions.add(discussion);
    });
    socket.emit('text', data);
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return FutureBuilder(
        future: getCurrentUser(),
        builder: (context, AsyncSnapshot<UserB> snapshot) {
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
                          docLink: widget.model.docLink),
                      Expanded(
                        child: Container(
                          height: 750.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.people_alt_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "Discussions",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.sp),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      controller: scrollController,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: discussions.length,
                                      itemBuilder: (_, index) {
                                        if (discussions
                                                .elementAt(index)
                                                .userInfo
                                                .id ==
                                            currentUser.id) {
                                          return SenderBlock(
                                              discussion:
                                                  discussions.elementAt(index));
                                        } else {
                                          return RecievedBlock(
                                              discussion:
                                                  discussions.elementAt(index));
                                        }
                                      }),
                                ),
                                sendingTab(
                                  messageController: messageController,
                                  onTap: () {
                                    if (messageController.text.isNotEmpty) {
                                      sendMessage(currentUser,
                                          messageController.text, "text");
                                      messageController.clear();
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class sendingTab extends StatelessWidget {
  const sendingTab({
    Key? key,
    required this.messageController,
    this.onTap,
  }) : super(key: key);

  final TextEditingController messageController;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20.r)),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 10.w),
                  child: Center(
                    child: TextField(
                      controller: messageController,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      decoration: InputDecoration(
                          hintText: "Type your Snadesh here ...",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12.sp),
                          focusedErrorBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 50.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Colors.blueAccent.shade700,
                    borderRadius: BorderRadius.circular(20.r)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 13.sp,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "Send",
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 5.w),
              child: Icon(
                Icons.image,
                color: Colors.black,
                size: 20.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 10.w),
              child: Icon(
                Icons.file_copy,
                color: Colors.black,
                size: 20.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SenderBlock extends StatelessWidget {
  SenderBlock({required this.discussion});

  DiscussionModel discussion;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(),
        Padding(
            padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
            child: Flexible(
              fit: FlexFit.tight,
              child: Container(
                constraints: BoxConstraints(minWidth: 100.w, maxWidth: 400.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        discussion.payload,
                        style: TextStyle(color: Colors.black, fontSize: 13.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        DateFormat.jm().format(discussion.timeStamp),
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }
}

class RecievedBlock extends StatefulWidget {
  RecievedBlock({required this.discussion});

  DiscussionModel discussion;

  @override
  _RecievedBlockState createState() => _RecievedBlockState();
}

class _RecievedBlockState extends State<RecievedBlock> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
          child: Flexible(
            child: Container(
              constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Image(
                            image: NetworkImage(
                                widget.discussion.userInfo.photoURL),
                            height: 30.h,
                            width: 30.w,
                          ),
                        ),
                        Spacer(),
                        Text(
                          widget.discussion.userInfo.userName,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 11.sp,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      widget.discussion.payload,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.discussion.userInfo.email,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 11.sp,
                              fontStyle: FontStyle.italic),
                        ),
                        Spacer(),
                        Text(
                          DateFormat.jm().format(widget.discussion.timeStamp),
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
    ;
  }
}
