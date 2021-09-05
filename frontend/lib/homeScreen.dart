import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var columnFlex = 25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () {
                setState(() {
                  columnFlex = 10;
                });
              },
              child: Container(
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
              flex: columnFlex,
              child: Container(
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}
