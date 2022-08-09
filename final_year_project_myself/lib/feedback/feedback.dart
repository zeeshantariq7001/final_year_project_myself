// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_slider/reviews_slider.dart';

class ReviewFeedback extends StatefulWidget {
  const ReviewFeedback({Key? key}) : super(key: key);

  @override
  State<ReviewFeedback> createState() => _ReviewFeedbackState();
}

class _ReviewFeedbackState extends State<ReviewFeedback> {
  int? selectedValue1;
  int? selectedValue2;

  void onChange1(int value) {
    setState(() {
      selectedValue1 = value;
    });
  }

  void onChange2(int value) {
    setState(() {
      selectedValue2 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Get.isDarkMode ? Colors.black : Colors.white),
        title: Text(
          "FeedBack",
          style: TextStyle(color: Get.isDarkMode ? Colors.black : Colors.white),
        ),
        backgroundColor: Get.isDarkMode ? Colors.white : Colors.teal,
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/fb.jpg",
              fit: BoxFit.fill,
            )),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Rate this application',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(height: 20),
              ReviewSlider(
                options: ['Terrible', 'Bad', 'Okay', 'Good', 'Great'],
                optionStyle: TextStyle(color: Colors.black),
                circleDiameter: 60,
                onChange: onChange1,
              ),
              Text(selectedValue1.toString()),
              SizedBox(height: 20),
              Text(selectedValue1.toString()),
              SizedBox(height: 20),
              Text(
                'Did you find your relateable features',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(height: 20),
              ReviewSlider(
                  optionStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  onChange: onChange2,
                  initialValue: 1,
                  options: ['Terrible', 'Bad', 'Okay', 'Good', 'Great']),
              Text(selectedValue2.toString()),
            ],
          ),
        ),
      ]),
    );
  }
}
