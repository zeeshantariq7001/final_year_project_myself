import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:final_year_project_myself/constants/constants.dart';
import 'package:final_year_project_myself/firebase/taskfirebase.dart';
import 'package:final_year_project_myself/screens/All_tasks.dart';
import 'package:final_year_project_myself/screens/loginscreen.dart';
import 'package:final_year_project_myself/screens/signupscreen.dart';
import 'package:final_year_project_myself/services/themeservices.dart';
import 'package:final_year_project_myself/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterLocalNotificationsPlugin? notify;
  @override
  void initState() {
    super.initState();
    var androidinitialize = new AndroidInitializationSettings("ic_launcher");
    var initializationSetting = new InitializationSettings(
      android: androidinitialize,
    );
    FlutterLocalNotificationsPlugin().initialize(initializationSetting);
    _speech = stt.SpeechToText();

    _listen();
    void onRecognitionResult() => setState(() => _taskC.text = _text);
  }

  void onRecognitionResult() => setState(() => _taskC.text = _text);

  Future _shownotification() async {
    var details = new AndroidNotificationDetails('channelId', 'channelName',
        importance: Importance.high,
        color: Colors.red,
        playSound: true,
        icon: '@mipmap/ic_launcher');

    var generalNotificationDetails = new NotificationDetails(android: details);
    await FlutterLocalNotificationsPlugin().show(
        0,
        'Notification',
        Get.isDarkMode ? "New task has been added" : "New task has been added",
        generalNotificationDetails);
  }

  Future _shownotificationtheme() async {
    var details = new AndroidNotificationDetails('channelId', 'channelName',
        importance: Importance.high,
        color: Colors.red,
        playSound: true,
        icon: '@mipmap/ic_launcher');

    var generalNotificationDetails = new NotificationDetails(android: details);
    await FlutterLocalNotificationsPlugin().show(
        0,
        'Notification',
        Get.isDarkMode ? "Light mode enabled" : "Dark  mode enabled",
        generalNotificationDetails);
  }

  @override
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskC = TextEditingController();
  final TextEditingController _dateC = TextEditingController();
  final TextEditingController _timeC = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController time = TextEditingController();

  String task = '';
  String dat = '';

  String tim = '';

  String? darktheme = 'DARK THEME';
  String? lighttheme = "LIGHT THEME";
  CollectionReference AllTasks =
      FirebaseFirestore.instance.collection('AllTasks');
  Future<void> addUser() {
    return AllTasks.add({'name': task, 'date': dat, 'time': tim})
        .then((value) => print("user added"))
        .catchError((error) => print("failed to delete user $error"));
  }

  clearText() {
    _taskC.clear();
    _dateC.clear();
    _timeC.clear();
    _text.replaceAll(_text, "");
  }

  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = '';
  double _confidence = 1.0;
  saveForm() async {
    await FirebaseServicesTask.addNotesData(
      time.text.trim(),
      date.text.trim(),
    ).onError((error, stackTrace) {
      showToastMsg(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Get.isDarkMode ? Colors.black : Colors.white),
        title: Text(
          "Task Reminder",
          style: TextStyle(color: Get.isDarkMode ? Colors.black : Colors.white),
        ),
        backgroundColor: Get.isDarkMode ? Colors.white : Colors.teal,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return AllTasksScreen();
                }));
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: Drawer(
        child: Container(
          height: double.infinity,
          width: 100,
          color: Get.isDarkMode ? Colors.black : Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Container(
                  height: 80,
                  width: 80,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _shownotificationtheme();
                        ThemeServices().switchTheme();
                      });
                    },
                    child: Icon(
                      Get.isDarkMode
                          ? Icons.wb_sunny_outlined
                          : Icons.nightlight_round_outlined,
                      size: 80,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              Get.isDarkMode
                  ? Text(
                      "DARK MODE",
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.white),
                    )
                  : Text(
                      "LIGHT MODE",
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.white),
                    ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return LoginScreen();
                  }));
                },
                child: Container(
                  color: Get.isDarkMode
                      ? Colors.white
                      : Colors.teal.withOpacity(0.5),
                  child: ListTile(
                    leading: Image.asset("assets/login.png"),
                    title: Text(
                      "Login Page",
                      style: DarkStyles().boldstyle,
                    ),
                    subtitle: Text(
                      "For Authentication",
                      style: DarkStyles().boldstyle,
                    ),
                    trailing: Icon(
                      Icons.email,
                      color: Get.isDarkMode ? Colors.black : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return SignUpScreen();
                  }));
                },
                child: Container(
                  color: Get.isDarkMode
                      ? Colors.white
                      : Colors.teal.withOpacity(0.5),
                  child: ListTile(
                    leading: Image.asset("assets/signupp.png"),
                    title: Text(
                      "Sign Up Page",
                      style: DarkStyles().boldstyle,
                    ),
                    subtitle: Text(
                      "For Authentication",
                      style: DarkStyles().boldstyle,
                    ),
                    trailing: Icon(
                      Icons.email,
                      color: Get.isDarkMode ? Colors.black : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return null!();
                  }));
                },
                child: Container(
                  color: Get.isDarkMode
                      ? Colors.white
                      : Colors.teal.withOpacity(0.5),
                  child: ListTile(
                    leading: Icon(Icons.task,
                        size: 60,
                        color: Get.isDarkMode ? Colors.black : Colors.black),
                    title: Text(
                      "All Tasks",
                      style: DarkStyles().boldstyle,
                    ),
                    subtitle: Text(
                      "Added Tasks",
                      style: DarkStyles().boldstyle,
                    ),
                    trailing: Icon(
                      Icons.person_pin_circle_sharp,
                      color: Get.isDarkMode ? Colors.black : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return null!;
                  }));
                },
                child: Container(
                  color: Get.isDarkMode
                      ? Colors.white
                      : Colors.teal.withOpacity(0.5),
                  child: ListTile(
                    leading: Icon(Icons.done_all,
                        size: 60,
                        color: Get.isDarkMode ? Colors.black : Colors.black),
                    title: Text(
                      "Completed Tasks",
                      style: DarkStyles().boldstyle,
                    ),
                    subtitle: Text(
                      "Tasks info.",
                      style: DarkStyles().boldstyle,
                    ),
                    trailing: Icon(
                      Icons.done,
                      color: Get.isDarkMode ? Colors.black : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return null!;
                  }));
                },
                child: Container(
                  color: Get.isDarkMode
                      ? Colors.white
                      : Colors.teal.withOpacity(0.5),
                  child: ListTile(
                    leading: Icon(Icons.notes,
                        size: 60,
                        color: Get.isDarkMode ? Colors.black : Colors.black),
                    title: Text(
                      "NotePad ",
                      style: DarkStyles().boldstyle,
                    ),
                    subtitle: Text(
                      "Write your personal notes.",
                      style: DarkStyles().boldstyle,
                    ),
                    trailing: Icon(
                      Icons.note_add,
                      color: Get.isDarkMode ? Colors.black : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return null!;
                  }));
                },
                child: Container(
                  color: Get.isDarkMode
                      ? Colors.white
                      : Colors.teal.withOpacity(0.5),
                  child: ListTile(
                    leading: Icon(Icons.note_alt_sharp,
                        size: 60,
                        color: Get.isDarkMode ? Colors.black : Colors.black),
                    title: Text(
                      "My Notes ",
                      style: DarkStyles().boldstyle,
                    ),
                    subtitle: Text(
                      "See your personal notes.",
                      style: DarkStyles().boldstyle,
                    ),
                    trailing: Icon(
                      Icons.note_alt,
                      color: Get.isDarkMode ? Colors.black : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return null!;
                  }));
                },
                child: Container(
                  color: Get.isDarkMode
                      ? Colors.white
                      : Colors.teal.withOpacity(0.5),
                  child: ListTile(
                    leading: Icon(Icons.person_pin_circle_sharp,
                        size: 60,
                        color: Get.isDarkMode ? Colors.black : Colors.black),
                    title: Text(
                      "About",
                      style: DarkStyles().boldstyle,
                    ),
                    subtitle: Text(
                      "App Info.",
                      style: DarkStyles().boldstyle,
                    ),
                    trailing: Icon(
                      Icons.info_outline,
                      color: Get.isDarkMode ? Colors.black : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/add_task.jpg",
              fit: BoxFit.fill,
            )),
        ListView(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  "Add Task",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Get.isDarkMode ? Colors.black : Colors.black,
                  ),
                ),
              ),
              DigitalClock(
                areaDecoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.transparent
                        : Colors.transparent),
                areaAligment: AlignmentDirectional.center,
                hourMinuteDigitDecoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Colors.transparent),
                hourMinuteDigitTextStyle: TextStyle(
                    fontSize: 20,
                    color: Get.isDarkMode ? Colors.black : Colors.black),
                secondDigitTextStyle: TextStyle(
                    fontSize: 15,
                    color: Get.isDarkMode ? Colors.black : Colors.black),
                digitAnimationStyle: Curves.fastOutSlowIn,
                amPmDigitTextStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              _listen();
                              onRecognitionResult();
                            },
                            icon: Icon(
                              _isListening ? Icons.mic : Icons.mic_none,
                              color: _isListening ? Colors.red : Colors.blue,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.task,
                            color: Get.isDarkMode ? Colors.black : Colors.black,
                          ),
                          border: InputBorder.none,
                          labelText: "Enter your task",
                          labelStyle: TextStyle(
                            color: Get.isDarkMode ? Colors.black : Colors.black,
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        controller: _taskC,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "please enter task";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black, width: 2)),
                      margin: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                      child: TextFormField(
                        validator: (v) {
                          if (!_dateC.text.contains("-") ||
                              !_dateC.text.contains("-")) {
                            return "Date format not true";
                          }
                          return null;
                        },
                        controller: _dateC,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.date_range,
                            color: Get.isDarkMode ? Colors.black : Colors.black,
                          ),
                          border: InputBorder.none,
                          labelText: "Enter date (28-10-1999)",
                          labelStyle: TextStyle(
                            color: Get.isDarkMode ? Colors.black : Colors.black,
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black, width: 2)),
                      margin: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                      child: TextFormField(
                        validator: (v) {
                          if (!_timeC.text.contains(":")) {
                            return "Time format not true";
                          }
                          return null;
                        },
                        controller: _timeC,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.timelapse,
                            color: Get.isDarkMode ? Colors.black : Colors.black,
                          ),
                          border: InputBorder.none,
                          labelText: "Enter time (12:30)",
                          labelStyle: TextStyle(
                            color: Get.isDarkMode ? Colors.black : Colors.black,
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DateTimePicker(
                controller: time,
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 60,
                width: 180,
                child: MaterialButton(
                  color: Get.isDarkMode ? Colors.white : Colors.teal,
                  shape: StadiumBorder(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(
                        () {
                          task = _taskC.text;
                          dat = _dateC.text;
                          tim = _timeC.text;
                          addUser();
                          clearText();
                          _shownotification();
                          saveForm();
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 25,
                        color: Get.isDarkMode ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ]),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(onStatus: (val) {
        print("onStatus: $val");
      }, onError: (val) {
        print("onError: $val");
      });
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech!.listen(onResult: (val) {
          setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          });
        });
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speech!.stop();
    }
  }
}
