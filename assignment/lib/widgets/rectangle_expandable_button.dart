import 'package:assignment/utils/helpers/style.dart';
import 'package:flutter/material.dart';


class RectangleExpandableButton extends StatelessWidget {
  final Color? backgrounColor;
  final String? label;
  final Color color;
  final double borderRadius;
  final Function()? onTap;
  final double height;
  final double? width;
  final Color? borderColor;
  final double elevation;
  final double borderWidth;
  final double? fontSize;
  final String? fontFamily;

  const RectangleExpandableButton({
    Key? key,
    this.color = const Color(0xffffffff),
    this.backgrounColor,
    this.borderRadius = 5,
    this.label,
    this.onTap,
    this.height = 50,
    this.width,
    this.borderColor,
    this.elevation = 0,
    this.borderWidth = 1,
    this.fontSize,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialStateProperty<Size?>? style(value) =>
        MaterialStateProperty.all(value);
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        minimumSize: style(
          Size(width ?? MediaQuery.of(context).size.width, height),
        ),
        elevation: MaterialStateProperty.all(elevation),
        backgroundColor: MaterialStateProperty.all(
          backgrounColor ?? Colors.red,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderWidth,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        // padding: MaterialStateProperty.all(paddingLTRB(40, 15, 40, 15)),
      ),
      child: Text(
        "$label",
        style: TextStyle(
          fontFamily: fontFamily ?? 'Avenir-Next',
          fontWeight: FontWeight.bold,
          fontSize: fontSize ?? 16,
          color: color,
        ),
      ),
    );
  }
}
