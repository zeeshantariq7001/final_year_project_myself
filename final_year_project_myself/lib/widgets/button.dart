import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String? title;
  bool isLoginButton;
  VoidCallback? onPress;
  bool? isLoading;
  String? btext;

  MyButton(
      {this.title,
      this.isLoginButton = false,
      this.onPress,
      this.isLoading = false,
      @required this.btext});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            // BoxShadow(
            //   color: Colors.grey.withOpacity(0.5),
            //   spreadRadius: 5,
            //   blurRadius: 7,
            //   offset: Offset(0, 3),
            // ),
          ],
          color: isLoginButton == false ? Colors.teal : Colors.black,
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(
          //     color: isLoginButton == false ? Colors.black : Colors.black),
        ),
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
        width: double.infinity,
        child: Stack(children: [
          Visibility(
            visible: isLoading! ? false : true,
            child: Center(
              child: Text(
                "$btext",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Visibility(
            visible: isLoading!,
            child: Center(child: CircularProgressIndicator()),
          ),
        ]),
      ),
    );
  }
}
