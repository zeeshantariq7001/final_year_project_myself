// ignore_for_file: prefer_const_constructors

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:final_year_project_myself/controllers/task_controllers.dart';
import 'package:final_year_project_myself/models/task_model.dart';
import 'package:final_year_project_myself/notification_services/notifications.dart';
import 'package:final_year_project_myself/services/themeservices.dart';
import 'package:final_year_project_myself/to-do-work/add_task_bar.dart';
import 'package:final_year_project_myself/to-do-work/task_tile.dart';
import 'package:final_year_project_myself/to-do-work/taskbutton.dart';
import 'package:final_year_project_myself/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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

  var notifyhelper;
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    notifyhelper = NotifyHelper();

    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(
            height: 10,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (i, index) {
              Task task = _taskController.taskList[index];
              if (task.repeat == 'Daily') {
                DateTime date =
                    DateFormat().add_jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                // notifyhelper._scheduledNotification(
                //     int.parse(myTime.toString().split(":")[0]),
                //     int.parse(myTime.toString().split(":")[1]),
                //     task);
                print(task);
                NotifyHelper().scheduledNotification(
                    hour: int.parse(myTime.toString().split(":")[0]),
                    minutes: int.parse(myTime.toString().split(":")[1]),
                    task: task);
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                            print('tapped');
                          },
                          child: TaskTile(task),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                            // print(task.startTime.toString());
                            // print(DateFormat("HH:mm").format(DateFormat()
                            //     .add_jm()
                            //     .parse(task.startTime.toString())));
                            // // print(task.title);

                            print('tapped');
                          },
                          child: TaskTile(task),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  _showBottomSheet(BuildContext context, task) {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? Colors.black : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
            ),
          ),
          Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: "Task Completed",
                  onTap: () {
                    _taskController.markTaskCompleted(task.id);
                    Get.back();
                  },
                  clr: Colors.blue,
                  context: context,
                ),
          _bottomSheetButton(
            label: "Delete task ",
            onTap: () {
              _taskController.delete(task);
              _taskController.getTasks();
              Get.back();
            },
            clr: Colors.red[300]!,
            context: context,
          ),
          SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
            label: "Close ",
            onTap: () {
              Get.back();
            },
            clr: Colors.red[300]!,
            isClose: true,
            context: context,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }

  _bottomSheetButton(
      {required String label,
      required Function() onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: isClose == true
              ? Get.isDarkMode
                  ? Colors.grey[600]
                  : Colors.grey[300]
              : clr,
          border: Border.all(
              width: 2, color: isClose == true ? Colors.transparent : clr),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(label,
                style: isClose
                    ? titleStyle
                    : titleStyle.copyWith(color: Colors.white))),
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.blue,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(
                    DateTime.now(),
                  ),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                )
              ],
            ),
          ),
          TaskButton(
              label: "+ Add Task",
              onTap: () {
                // _taskController.getTasks();

                return Get.to(() => AddTaskBar());
              })
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
          _shownotificationtheme();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/profile.png"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
