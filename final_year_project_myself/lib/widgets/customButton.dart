import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  String? text;
  double? fontSize;
  Color? buttonColor;
  Color? textColor;
  VoidCallback? onTap;

  CustomButton({
    Key? key,
    this.text,
    this.fontSize,
    this.buttonColor,
    this.textColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size s = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.white : Colors.teal,
          ),
          height: 50,
          width: 250,
          child: Center(
            child: Text(
              text ?? "text",
              style: GoogleFonts.salsa(
                textStyle: TextStyle(
                  color: Get.isDarkMode ? Colors.black : Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
