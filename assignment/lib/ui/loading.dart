import 'package:assignment/utils/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';


void showLoading() =>
    SmartDialog.showLoading(background: Colors.red, msg: "Please wait...");

void stopLoading() => SmartDialog.dismiss();

void dismissKeyboard(BuildContext context) => FocusScope.of(context).unfocus();
