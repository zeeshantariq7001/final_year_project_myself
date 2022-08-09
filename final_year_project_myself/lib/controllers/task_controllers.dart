import 'dart:ffi';

import 'package:final_year_project_myself/models/task_model.dart';
import 'package:final_year_project_myself/sqf_db/db_helper.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  @override
  Void? onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
    // print(val);
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
