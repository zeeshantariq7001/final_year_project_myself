import 'package:final_year_project_myself/screens/All_tasks.dart';
import 'package:final_year_project_myself/screens/homescreen.dart';
import 'package:flutter/material.dart';

class SelectTask extends StatefulWidget {
  const SelectTask({Key? key}) : super(key: key);

  @override
  State<SelectTask> createState() => _SelectTaskState();
}

class _SelectTaskState extends State<SelectTask> {
  var selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        PopupMenuButton(onSelected: (value) {
          // your logic
          setState(() {
            selectedItem = value.toString();
          });
          print(value);
          Navigator.pushNamed(context, value.toString());
        }, itemBuilder: (BuildContext bc) {
          return [
            PopupMenuItem(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return AllTasksScreen();
                        },
                      ),
                    );
                  },
                  child: Text("All Tasks")),
              value: '/All Tasks',
            ),
            PopupMenuItem(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return HomeScreen();
                        },
                      ),
                    );
                  },
                  child: Text("Add Tasks")),
              value: '/Add tasks',
            ),
            PopupMenuItem(
              child: Text("About Us"),
              value: '/about us',
            )
          ];
        }),
      ]),
    );
  }
}
