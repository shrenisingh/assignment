import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showToast(String? message) {
  Get.showSnackbar(
    GetBar(
      message: message,
      borderRadius: 100,
      forwardAnimationCurve: Curves.linear,
      margin: const EdgeInsets.all(20),
      animationDuration: const Duration(milliseconds: 100),
      backgroundColor: const Color(0xFF003F3E),
      duration: const Duration(seconds: 3),
    ),
  );
}
