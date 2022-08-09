import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyStyles {
  static const boldstyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.teal);
}

class DarkStyles {
  final boldstyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.black : Colors.black);
}
