import 'package:flutter/material.dart';

class SizeHelper {
  SizeHelper(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
  }

  double height = 0.0;
  double width = 0.0;

  double heightCustom(double percent) => height * percent / 100;

  double widthCustom(double percent) => width * percent / 100;
}
