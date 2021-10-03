import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoticeButton extends StatelessWidget {
  NoticeButton(
      {required this.buttonTitle,
      required this.buttonColor,
      required this.titleColor,
      this.onTap});

  final String buttonTitle;
  final Color buttonColor;
  final Color titleColor;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        height: 40.h,
        width: 120.w,
        child: Center(
          child: Text(
            buttonTitle,
            style: TextStyle(color: titleColor, fontSize: 12.sp),
          ),
        ),
      ),
    );
  }
}
