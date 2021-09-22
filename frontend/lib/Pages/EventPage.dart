import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/Classes/Event.dart';
import 'package:frontend/Classes/contributionModel.dart';
import 'package:frontend/Classes/registrationModel.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';

class eventPage extends StatefulWidget {
  const eventPage({Key? key}) : super(key: key);

  @override
  _eventPageState createState() => _eventPageState();
}

class _eventPageState extends State<eventPage> {
  Future<List<ContributionModel>> getUserContributions() async {
    var response = await http.get(Uri.parse(
        "http://127.0.0.1:1000/api/events/getUserContributions?userID=61471e22ef7cc52173e32dc4"));
    List<dynamic> data = await jsonDecode(response.body);
    // print(data.elementAt(0)['contributors']);
    List<ContributionModel> contributions =
        data.map((data) => ContributionModel.fromJson(data)).toList();
    return contributions;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 40.w, top: 40.h, right: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "E v e n t s",
                style: TextStyle(color: Colors.white, fontSize: 50.sp),
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Your Contributions",
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: getUserContributions(),
                  builder:
                      (_, AsyncSnapshot<List<ContributionModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Loading(
                          indicator: BallSpinFadeLoaderIndicator(),
                          size: 30.sp,
                        ),
                      );
                    } else {
                      return Container(
                        height: 200.h,
                        width: double.maxFinite,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) {
                              return ContributionTile(
                                  snapshot.data!.elementAt(index));
                            }),
                      );
                    }
                  }),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Events",
                style: TextStyle(color: Colors.white, fontSize: 30.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 300.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r)),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image(
                              image: AssetImage('images/brandLogo.jpg'),
                              height: 40.h,
                              width: 40.w,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'Equinox',
                            style: TextStyle(
                                fontSize: 30.sp, fontFamily: 'Futura'),
                          )
                        ],
                      ),
                    ],
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

class ContributionTile extends StatelessWidget {
  ContributionTile(this._contributionModel);

  final ContributionModel _contributionModel;

  @override
  Widget build(BuildContext context) {
    Future<registrationModel> getRegistrationDetails(
        String registrationID) async {
      var response = await http.get(Uri.parse(
          "http://127.0.0.1:1000/api/events/getRegistrationDetail?registrationID=${registrationID}"));
      dynamic data = await jsonDecode(response.body);
      registrationModel registration = registrationModel.fromJson(data);
      return registration;
    }

    getRegistrationDetails("61486149554297508b64c5d0");
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      child: Container(
        height: 200.h,
        width: 400.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        _contributionModel.eventName,
                        style: TextStyle(color: Colors.black, fontSize: 25.sp),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        width: 80.w,
                        height: 1.h,
                        color: Colors.black,
                      )
                    ],
                  ),
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18.r),
                    child: Image(
                      image: NetworkImage(_contributionModel.eventLogo),
                      height: 36.h,
                      width: 36.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '+${_contributionModel.points}',
                    style: TextStyle(
                        color: Colors.green.shade800, fontSize: 70.sp),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                    width: 2.w,
                    height: 50.h,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _contributionModel.type,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      FutureBuilder(
                          future: getRegistrationDetails(
                              _contributionModel.registrationDetails),
                          builder:
                              (_, AsyncSnapshot<registrationModel> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Loading(
                                  indicator: BallSpinFadeLoaderIndicator(),
                                  size: 30.sp,
                                  color: Colors.black,
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  Text(
                                    snapshot.data!.attendeeName,
                                    style: TextStyle(
                                        color: Colors.blue.shade800,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                  Text(
                                    snapshot.data!.platform,
                                    style: TextStyle(
                                        color: Colors.pink.shade800,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                        letterSpacing: 2),
                                  ),
                                ],
                              );
                            }
                          })
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
