import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    Key? key,
    required this.onCreate,
    required this.onCancel,
  }) : super(key: key);
  final VoidCallback onCreate;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onCancel,
          style: ElevatedButton.styleFrom(
            elevation: 15,
            shadowColor: Colors.black45,
            padding: const EdgeInsets.all(0.0),
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Ink(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff434343),
                  Color(0xff0044000),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Container(
              padding: EdgeInsets.all(2.h),
              child: Center(
                child: Text(
                  'CANCEL',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onCreate,
          style: ElevatedButton.styleFrom(
            elevation: 15,
            shadowColor: Colors.black45,
            padding: const EdgeInsets.all(0.0),
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Ink(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff434343),
                  Color(0xff000000),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Container(
              padding: EdgeInsets.all(2.h),
              child: Center(
                child: Text(
                  'CREATE',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
