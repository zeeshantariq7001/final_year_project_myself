// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({Key? key}) : super(key: key);

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Get.isDarkMode ? Colors.black : Colors.white),
        title: Text(
          "Completed Tasks",
          style: TextStyle(color: Get.isDarkMode ? Colors.black : Colors.white),
        ),
        backgroundColor: Get.isDarkMode ? Colors.white : Colors.teal,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: Image.asset(
              "assets/compl.jpg",
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
