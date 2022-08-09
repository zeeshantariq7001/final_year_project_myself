// ignore_for_file: prefer_const_constructors

import 'package:final_year_project_myself/feedback/feedback.dart';
import 'package:final_year_project_myself/notepad/add_data.dart';
import 'package:final_year_project_myself/notepad/show_Data.dart';
import 'package:final_year_project_myself/reminder/reminder_page.dart';
import 'package:final_year_project_myself/screens/All_tasks.dart';
import 'package:final_year_project_myself/screens/about_screen.dart';
import 'package:final_year_project_myself/screens/completed_tasks.dart';
import 'package:final_year_project_myself/screens/homescreen.dart';
import 'package:final_year_project_myself/screens/loginscreen.dart';
import 'package:final_year_project_myself/screens/others_screen.dart';
import 'package:final_year_project_myself/screens/signupscreen.dart';
import 'package:final_year_project_myself/services/themeservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  FlutterLocalNotificationsPlugin? notify;
  @override
  void initState() {
    super.initState();
    var androidinitialize = AndroidInitializationSettings("ic_launcher");
    var initializationSetting = InitializationSettings(
      android: androidinitialize,
    );
    FlutterLocalNotificationsPlugin().initialize(initializationSetting);
  }

  Future _shownotificationtheme() async {
    var details = AndroidNotificationDetails('channelId', 'channelName',
        importance: Importance.high,
        color: Colors.red,
        playSound: true,
        icon: '@mipmap/ic_launcher');

    var generalNotificationDetails = NotificationDetails(android: details);
    await FlutterLocalNotificationsPlugin().show(
        0,
        'Notification',
        Get.isDarkMode ? "Light mode enabled" : "Dark  mode enabled",
        generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(children: [
          Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Get.isDarkMode ? Colors.black : Colors.teal),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   height: 80,
                      //   width: 80,
                      //   child: Image.asset(
                      //     "assets/a.png",
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          IconButton(
                            onPressed: () {
                              ThemeServices().switchTheme();
                              _shownotificationtheme();
                            },
                            icon: Icon(
                              Get.isDarkMode
                                  ? Icons.nightlight_outlined
                                  : Icons.wb_sunny_rounded,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Task Reminder",
                            style: TextStyle(
                              fontSize: 30,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return ReminderPage();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Add Task Page",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 25.0,
                            spreadRadius: 5.0,
                            offset: Offset(
                              15.0,
                              15.0,
                            ),
                          )
                        ],
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return AddDataScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "NotePad Page",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 25.0,
                            spreadRadius: 5.0,
                            offset: Offset(
                              15.0,
                              15.0,
                            ),
                          )
                        ],
                        color: Color.fromARGB(255, 214, 150, 216),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return ShowDataScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Notes",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 25.0,
                            spreadRadius: 5.0,
                            offset: Offset(
                              15.0,
                              15.0,
                            ),
                          )
                        ],
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return Contact();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "About",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 25.0,
                            spreadRadius: 5.0,
                            offset: Offset(
                              15.0,
                              15.0,
                            ),
                          )
                        ],
                        color: Colors.teal.withOpacity(0.6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return ReviewFeedback();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Feed Back",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 25.0,
                            spreadRadius: 5.0,
                            offset: Offset(
                              15.0,
                              15.0,
                            ),
                          )
                        ],
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return OtherScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Others",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 25.0,
                            spreadRadius: 5.0,
                            offset: Offset(
                              15.0,
                              15.0,
                            ),
                          )
                        ],
                        color: Colors.purple.withOpacity(0.6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
