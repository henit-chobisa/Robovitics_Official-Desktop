import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: Padding(
        padding: EdgeInsets.only(left: 40.w, top: 40.h, right: 40.w),
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notices",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.sp,
                  fontFamily: "Futura",
                  letterSpacing: 3),
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 750.h,
              width: 450.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10.r)),
              child: Padding(
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          letterSpacing: 2),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "When you’re looking for ways to get to know the “true you,” meditation is a powerful practice of mindfulness you can try to help you along your path to self-discovery. In general, meditation promotes self-discovery by letting you focus all your attention inwards and ",
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 600,
                      width: 500,
                      child: SfPdfViewer.network(
                          'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    ));
  }
}
