import 'package:final_year_project_myself/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextField extends StatefulWidget {
  TextEditingController? controller;
  String? hintText;
  String? Function(String?)? validate;
  bool isPassword;
  Widget? icon;
  Widget? preIcon;

  bool iconCheck;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;

  MyTextField(
      {this.hintText,
      this.controller,
      this.validate,
      this.isPassword = false,
      this.icon,
      this.iconCheck = false,
      this.inputAction,
      this.focusNode,
      this.preIcon});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      decoration: BoxDecoration(
        boxShadow: [
          // BoxShadow(
          //   color: Colors.grey.withOpacity(0.5),
          //   spreadRadius: 5,
          //   blurRadius: 7,
          //   offset: Offset(0, 3),
          // ),
        ],
        color: Get.isDarkMode ? Colors.black : Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        controller: widget.controller,
        validator: widget.validate,
        obscureText: widget.isPassword == false ? false : widget.isPassword,
        decoration: InputDecoration(
          prefixIcon: widget.preIcon,
          border: InputBorder.none,
          hintText: widget.hintText ?? 'hint text',
          suffixIcon: widget.icon,
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
