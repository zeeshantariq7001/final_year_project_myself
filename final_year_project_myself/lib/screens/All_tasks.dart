// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({Key? key}) : super(key: key);

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  final Stream<QuerySnapshot> tasksStream =
      FirebaseFirestore.instance.collection('AllTasks').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: tasksStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> Snapshot) {
          if (Snapshot.hasError) {
            print("Something went wrong");
          }
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List storeDocs = [];
          Snapshot.data?.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storeDocs.add(a);
          }).toList();
          return Scaffold(
            backgroundColor: Colors.white.withOpacity(0.7),
            appBar: AppBar(
              iconTheme: IconThemeData(
                  color: Get.isDarkMode ? Colors.black : Colors.white),
              title: Text(
                "Added Tasks",
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.black : Colors.white),
              ),
              backgroundColor: Get.isDarkMode ? Colors.white : Colors.teal,
              centerTitle: true,
            ),
            body: Stack(children: [
              Container(
                height: double.infinity,
                child: Image.asset(
                  "assets/added_tasks.jpg",
                  fit: BoxFit.fitHeight,
                ),
              ),
              ListView(children: [
                Column(
                  children: [
                    for (var i = 0; i < storeDocs.length; i++) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.grey.withOpacity(0.9),
                          child: ListTile(
                            tileColor: Colors.pink,
                            leading: Icon(Icons.person,
                                color: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.black),
                            title: Text(
                              storeDocs[i]['name'],
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.black
                                      : Colors.black),
                            ),
                            subtitle: Text(
                              storeDocs[i]['date'],
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.black
                                      : Colors.black),
                            ),
                            trailing: Text(
                              storeDocs[i]['time'],
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.black
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ]),
            ]),
          );
        });
  }
}
