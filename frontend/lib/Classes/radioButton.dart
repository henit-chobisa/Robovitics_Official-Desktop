import 'package:flutter/cupertino.dart';

class RadioButton {
  RadioButton(
      {required this.associatedPage,
      required this.title,
      required this.icon,
      required this.isPressed});

  final String title;
  final IconData icon;
  final bool isPressed;
  final Widget associatedPage;
}
