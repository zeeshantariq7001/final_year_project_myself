import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  FlutterLocalNotificationsPlugin? fltrnotfication;
  @override
  void initState() {
    super.initState();

    var androidInitialize = AndroidInitializationSettings("ic_launcher");
    var initializationSettings = InitializationSettings(
      android: androidInitialize,
    );
    fltrnotfication = FlutterLocalNotificationsPlugin();
    fltrnotfication!.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
      "channel",
      "dbesttech",
      importance: Importance.max,
    );
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);

    var scheduledTime = DateTime.now().add(Duration(seconds: 10));
    fltrnotfication!.zonedSchedule(
      1,
      "Task Scheduled",
      "Done",
      _scheduleDaily(
        Time(20, 15, 05),
      ),
      generalNotificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidAllowWhileIdle: true,
    );
  }

  tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.UTC);
    final scheduledDate = tz.TZDateTime(tz.UTC, now.year, now.month, now.day);
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days: 1))
        : scheduledDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
        onPressed: () {
          _showNotification();
        },
        child: Text("ShowNot"),
      ),
    );
  }

  Future notificationSelected(String? payload) async {}
}
