// ignore_for_file: prefer_const_constructors

import 'package:final_year_project_myself/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    _configureLocalTimezone();
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //         requestSoundPermission: false,
    //         requestBadgePermission: false,
    //         requestAlertPermission: false,
    //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");
    final InitializationSettings initializationSettings =
        InitializationSettings(
            // iOS: initializationSettingsIOS,
            android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(
      () => Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.amber,
            border: Border.all(color: Colors.red, width: 5)),
      ),
    );
  }

  // sheduledNotification() async {
  //   tz.initializeTimeZones();
  //   _configureLocalTimezone();
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       "scheduled time",
  //       "theme changes 5 seconds ago",
  //       // _convertTime(hour, minutes),
  //       tz.TZDateTime.now(tz.getLocation("Asia/Karachi"))
  //           .add(const Duration(seconds: 5)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               'your channel id', "your channel name")),
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.time,
  //       androidAllowWhileIdle: true);
  // }
  scheduledNotification(
      {required int hour, required int minutes, required Task task}) async {
    tz.initializeTimeZones();
    _configureLocalTimezone();

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "time to work  ",
        "time to write ",
        _convertTime(hour, minutes),
        // tz.TZDateTime.now(tz.getLocation("Asia/Karachi"))
        //     .add(const Duration(seconds: 5),),
        NotificationDetails(
          android: AndroidNotificationDetails(
            "channel id",
            'channel name',
            channelDescription: "description",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "Zeeshan Tariq",
        androidAllowWhileIdle: true);
  }

  tz.TZDateTime _convertTime(
    int hour,
    int minutes,
  ) {
    tz.initializeTimeZones();

    final tz.TZDateTime now = tz.TZDateTime.now(tz.getLocation("Asia/Karachi"));

    tz.TZDateTime scheduleDate = tz.TZDateTime(tz.getLocation("Asia/Karachi"),
        now.year, now.month, now.day, hour, minutes);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation("Asia/Karachi"));
  }
}
