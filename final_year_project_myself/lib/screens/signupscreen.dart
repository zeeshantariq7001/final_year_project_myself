// ignore_for_file: prefer_const_constructors
import 'dart:ui';

import 'package:final_year_project_myself/firebase/firebase.dart';
import 'package:final_year_project_myself/screens/homescreen.dart';
import 'package:final_year_project_myself/screens/loginscreen.dart';
import 'package:final_year_project_myself/utils/textstyles.dart';
import 'package:final_year_project_myself/widgets/button.dart';
import 'package:final_year_project_myself/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPassword = true;
  bool isRetypePassword = true;
  FocusNode? passwordFocus;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();

  TextEditingController name = TextEditingController();
  bool formStateLoading = false;

  var globalkey = GlobalKey<FormState>();
  submit() async {
    if (globalkey.currentState!.validate()) {
      if (password.text == repassword.text) {
        setState(() {
          formStateLoading = true;
        });
        String? accountstatus =
            await FirebaseService.createAccount(email.text, password.text);
        if (accountstatus != null) {
          ecoDialogue(accountstatus);
          setState(() {
            formStateLoading = false;
          });
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    }
  }

  saveform(BuildContext context) async {
    if (globalkey.currentState!.validate()) {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
    }
    FirebaseAuth auth = FirebaseAuth.instance;
    var u = auth.currentUser!.uid;
    if (u != null) {
      Navigator.push(context, MaterialPageRoute(builder: (c) {
        return LoginScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  "assets/a2.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                            // child: Container(
                            //   height: 200,
                            //   width: 200,
                            //   // child: Image.asset(
                            //   //   'assets/login.png',
                            //   //   fit: BoxFit.fill,
                            //   // ),
                            // ),
                            ),
                        const Text(
                          "Sign Up/Register ",
                          style: MyStyles.boldstyle,
                        ),
                        Text(
                          "To Continue ",
                          style: MyStyles.boldstyle,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Form(
                          key: globalkey,
                          child: Column(
                            children: [
                              MyTextField(
                                hintText: "Enter name...",
                                preIcon: const Icon(Icons.person),
                                validate: (v) {
                                  if (name.text.length < 3 &&
                                      name.text.isEmpty) {
                                    return "No name or Short name";
                                  }
                                  return null;
                                },
                                controller: name,
                              ),
                              MyTextField(
                                controller: email,
                                hintText: "Enter email...",
                                preIcon: const Icon(Icons.email),
                                validate: (v) {
                                  if (!email.text.contains("@gmail.com")) {
                                    return "Email badly formatted";
                                  }
                                  return null;
                                },
                              ),
                              MyTextField(
                                controller: password,
                                inputAction: TextInputAction.next,
                                focusNode: passwordFocus,
                                isPassword: isPassword,
                                hintText: "Enter Password...",
                                preIcon:
                                    const Icon(Icons.remove_red_eye_outlined),
                                icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPassword = !isPassword;
                                    });
                                  },
                                  icon: isRetypePassword
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                                validate: (v) {
                                  if (password.text.length < 7) {
                                    return "Password should be atleast 7 words";
                                  }
                                  return null;
                                },
                              ),
                              MyTextField(
                                controller: repassword,
                                inputAction: TextInputAction.next,
                                focusNode: passwordFocus,
                                isPassword: isPassword,
                                hintText: "reenter Password...",
                                preIcon:
                                    const Icon(Icons.remove_red_eye_outlined),
                                icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPassword = !isPassword;
                                    });
                                  },
                                  icon: isRetypePassword
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                                validate: (v) {
                                  if (password.text.length < 7) {
                                    return "Password should be atleast 7 words";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyButton(
                          btext: "REGISTER",
                          onPress: () {
                            // saveform(context);
                            submit();
                          },
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: const Text(
                        //     "OR",
                        //     style: TextStyle(color: Colors.black),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        //   child: Container(
                        //     height: 50,
                        //     width: double.infinity,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(40),
                        //       color: Get.isDarkMode
                        //           ? Colors.black
                        //           : const Color(0xfffe0eef1),
                        //     ),
                        //     child: MaterialButton(
                        //       onPressed: () {},
                        //       child: Row(
                        //         // ignore: prefer_const_literals_to_create_immutables
                        //         children: [
                        //           const Icon(
                        //             Icons.g_mobiledata,
                        //             size: 50,
                        //           ),
                        //           SizedBox(
                        //             width: 32,
                        //           ),
                        //           const Text(
                        //             "     Sign in with Google",
                        //             style: TextStyle(fontSize: 16),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(color: Colors.teal),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return LoginScreen();
                                }));
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
              )
            ],
          )),
      // body:
    );
  }

  Future<void> ecoDialogue(String error) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(error),
          actions: [
            MyButton(
              btext: "Press",
              title: 'CLOSE',
              onPress: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return LoginScreen();
                }));
              },
            ),
          ],
        );
      },
    );
  }
}
