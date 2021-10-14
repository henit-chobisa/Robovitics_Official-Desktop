import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/base.dart';
import 'dart:io' show Platform;
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(Size(1300, 750));
    setWindowFrame(Rect.largest);
  }
  runApp(RoboviticsOfficial());
}

class RoboviticsOfficial extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1400, 900),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: basePage(),
      ),
    );
  }
}
