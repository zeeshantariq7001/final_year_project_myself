import 'package:final_year_project_myself/constants/constants.dart';
import 'package:final_year_project_myself/firebase/firebasenotepad.dart';
import 'package:final_year_project_myself/widgets/customButton.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get/get.dart';

class AddDataScreen extends StatefulWidget {
  @override
  State<AddDataScreen> createState() {
    return _AddDataScreenState();
  }
}

class _AddDataScreenState extends State<AddDataScreen> {
  ///key
  final formKey = GlobalKey<FormState>();

  ///Controllers
  TextEditingController titleC = TextEditingController();
  TextEditingController detailsC = TextEditingController();
  var text = "";

  ///SaveForm
  saveForm() async {
    if (formKey.currentState!.validate()) {
      await FirebaseServices.addNotesData(
        titleC.text.trim(),
        detailsC.text.trim(),
      ).onError((error, stackTrace) {
        showToastMsg(error.toString());
      });
    }
  }

  ///Disposing
  @override
  void dispose() {
    titleC.clear();
    titleC.dispose();
    detailsC.clear();
    detailsC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///Size
    final Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Get.isDarkMode ? Colors.black : Colors.white),
        title: Text(
          "Make your notes",
          style: TextStyle(color: Get.isDarkMode ? Colors.black : Colors.white),
        ),
        backgroundColor: Get.isDarkMode ? Colors.white : Colors.teal,
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            "assets/compl.jpg",
            fit: BoxFit.fill,
          ),
        ),
        Container(
          height: s.height,
          width: s.width,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.black38,
                      height: 0.5,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.9)),
                        child: TextFormField(
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.black : Colors.black,
                          ),
                          controller: titleC,
                          minLines: 1,
                          maxLines: 200,
                          validator: (_) {
                            if (_!.isEmpty) {
                              return "Field Should not be Empty";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.title,
                                color: Colors.black,
                              ),
                              hintText: "Title",
                              hintStyle: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.black38,
                      height: 0.5,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.9)),
                        child: TextFormField(
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.black : Colors.black,
                          ),
                          controller: detailsC,
                          minLines: 1,
                          maxLines: 200,
                          validator: (_) {
                            if (_!.isEmpty) {
                              return "Field Should not be Empty";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.description_sharp,
                                color: Colors.black,
                              ),
                              hintText: "Enter details",
                              hintStyle: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.black38,
                      height: 0.5,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      text: "Add Data",
                      textColor: Colors.white,
                      fontSize: 17,
                      buttonColor: Colors.blue,
                      onTap: () async {
                        await saveForm();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
