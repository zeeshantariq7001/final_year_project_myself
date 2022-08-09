import "package:cloud_firestore/cloud_firestore.dart";
import 'package:final_year_project_myself/constants/constants.dart';
import 'package:final_year_project_myself/firebase/firebasenotepad.dart';
import 'package:final_year_project_myself/notepad/add_data.dart';
import 'package:final_year_project_myself/widgets/custom_prog_indicator.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import "package:google_fonts/google_fonts.dart";

class ShowDataScreen extends StatefulWidget {
  const ShowDataScreen({Key? key}) : super(key: key);

  @override
  State<ShowDataScreen> createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Get.isDarkMode ? Colors.black : Colors.white),
        title: Text(
          "My Notes",
          style: TextStyle(color: Get.isDarkMode ? Colors.black : Colors.white),
        ),
        backgroundColor: Get.isDarkMode ? Colors.white : Colors.teal,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: (() {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddDataScreen();
          }));
        }),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("Notes").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final v = snapshot.data!.docs[index];
                return Dismissible(
                  direction: DismissDirection.startToEnd,
                  background: const Icon(Icons.delete),
                  key: UniqueKey(),
                  onDismissed: (_) {
                    FirebaseServices.deleteNotes(v.id).whenComplete(
                      () => showToastMsg("Notes Deleted Successfully!"),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    child: ExpansionTile(
                      leading: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.edit)),
                      title: Text(
                        "${v["title"]}".toUpperCase(),
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      children: [
                        myDivider,
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SelectableText(
                              "Details",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        myDivider,
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SelectableText(
                            "${v["details"]}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        myDivider
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return CustomProgressIndicator(
              textMessage: "Loading...",
            );
          }
        },
      ),
    );
  }
}
