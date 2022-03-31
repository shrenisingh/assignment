
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final String? hintText;
  final Color hintTextColor;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Color textColor;
  final Color backGroundColor;
  final ValueChanged<DateTime?> onChanged;
  final String? dateFormatPattern;
  final Widget? trailing;

  const CustomDatePicker({
    Key? key,
    this.hintText,
    this.textColor = const Color(0xFFFFFFFF),
    this.backGroundColor = Colors.red,
    required this.onChanged,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.hintTextColor = const Color(0xff808080),
    this.dateFormatPattern,
    this.trailing,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? result = await datePicker(
          context,
          widget.initialDate ?? DateTime.now(),
          widget.firstDate ?? DateTime(1900),
          widget.lastDate ?? DateTime(2300),
          widget.textColor,
          widget.backGroundColor,
        );
        if (result != null) {
          setState(() => selectedDate =
              DateFormat(widget.dateFormatPattern ?? 'd LLLL y')
                  .format(result));
          widget.onChanged(result);
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              selectedDate == null ? '${widget.hintText}' : "$selectedDate",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 14,
                color: selectedDate == null
                    ? widget.hintTextColor
                    : widget.backGroundColor,
              ),
            ),
          ),
          widget.trailing ?? const SizedBox()
        ],
      ),
    );
  }

  Future<DateTime?> datePicker(
      BuildContext context,
      DateTime initialDate,
      DateTime firstDate,
      DateTime lastDate,
      Color textColor,
      Color backGroundColor) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: backGroundColor,
              onSecondary: textColor,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}