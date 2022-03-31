import 'package:assignment/utils/helpers/style.dart';
import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final double? maxWidth;
  final String? Function(String?)? validator;
  final Function(String value)? onChanged;
  final bool obscureText;
  final double borderRadius;
  final double? hintFontSize;
  final TextInputType? keyBoardType;

  const CustomTextFormField(
      {Key? key,
      this.controller,
      this.hintText,
      this.validator,
      this.obscureText = false,
      this.borderRadius = 10,
      this.hintFontSize,
      this.onChanged,
      this.keyBoardType,
      this.maxWidth})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth ?? 300),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        keyboardType: keyBoardType,
        decoration: InputDecoration(
          contentPadding: paddingLTRB(20, 0, 0, 0),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(borderRadius)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(borderRadius)),
          hintText: hintText,
          hintStyle:
              TextStyle(color: const Color(0xff808080), fontSize: hintFontSize),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffC4C4C4)),
              borderRadius: BorderRadius.circular(borderRadius)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffC4C4C4)),
              borderRadius: BorderRadius.circular(borderRadius)),
        ),
      ),
    );
  }
}
