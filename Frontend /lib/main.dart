import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:lottie/lottie.dart';
import 'package:robovitics_official/landingPage.dart';
import 'package:robovitics_official/loginScreen.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle("Robovitcs Official");
    setWindowMinSize(Size(1300, 800));
  }
  runApp(LoadingPage());
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1440, 900),
        builder: () => MaterialApp(
            debugShowCheckedModeBanner: false, home: landingPage()));
  }
}
