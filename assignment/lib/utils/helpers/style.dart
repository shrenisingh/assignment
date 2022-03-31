import 'package:flutter/material.dart';

const Color greyColor = Color(0xffE5E5E5);
const Color greyColor2 = Color(0xffC4C4C4);
const Color greyColor3 = Color(0xff808080);


SizedBox gapTop(double height) => SizedBox(height: height);

SizedBox gapRight(double width) => SizedBox(width: width);

EdgeInsets paddingAll(double value) => EdgeInsets.all(value);

EdgeInsets paddingLTRB(double left, double top, double right, double bottom) {
  return EdgeInsets.fromLTRB(left, top, right, bottom);
}

List<BoxShadow> defaultBoxShadow = <BoxShadow>[
  const BoxShadow(
    color: greyColor,
    blurRadius: 15.0,
    spreadRadius: 5.0,
  )
];

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: "Avenir",
  dividerColor: Colors.transparent,
);
