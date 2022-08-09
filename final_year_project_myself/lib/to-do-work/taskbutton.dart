import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const TaskButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 60,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.blue),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
