import 'dart:ui';
import 'package:final_year_project_myself/otp_login/otplogin.dart';
import 'package:final_year_project_myself/screens/all_screens.dart';
import 'package:final_year_project_myself/screens/signupscreen.dart';
import 'package:final_year_project_myself/services/themeservices.dart';
import 'package:final_year_project_myself/utils/textstyles.dart';
import 'package:final_year_project_myself/widgets/button.dart';
import 'package:final_year_project_myself/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassword = true;
  bool isRetypePassword = true;
  FocusNode? passwordFocus;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otp = TextEditingController();

  var globalKey = GlobalKey<FormState>();

  saveform(BuildContext context) async {
    if (globalKey.currentState!.validate()) {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    }
    FirebaseAuth auth = FirebaseAuth.instance;
    var u = auth.currentUser!.uid;
    if (u != null) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) {
        return AdminScreen();
      }), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appbar(),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  "assets/a1.jpg",
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
                          "Login ",
                          style: MyStyles.boldstyle,
                        ),
                        Text(
                          "To Continue ",
                          style: MyStyles.boldstyle,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Form(
                          key: globalKey,
                          child: Column(
                            children: [
                              MyTextField(
                                controller: email,
                                hintText: "Enter email...",
                                preIcon: const Icon(Icons.email),
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "Badly formatted";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              MyTextField(
                                controller: password,
                                inputAction: TextInputAction.next,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "Badly formatted";
                                  } else {
                                    return null;
                                  }
                                },
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
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MyButton(
                                btext: "LOG IN",
                                onPress: () {
                                  saveform(context);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: const Text(
                                  "OR",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              MyTextField(
                                controller: otp,
                                inputAction: TextInputAction.next,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "Enter Phone Number";
                                  } else {
                                    return null;
                                  }
                                },
                                focusNode: passwordFocus,
                                hintText: "Enter phone number...",
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Get.isDarkMode
                                        ? Colors.black
                                        : const Color(0xfffe0eef1),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (otp != null) {
                                        final phone = ("+92" + otp.text);
                                        AuthProvider()
                                            .LogInWithPhone(context, phone);
                                      }
                                    },
                                    child: const Text(
                                      "Sign in with OTP",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                              //             "Sign in with Google",
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
                                    "Don't have an account?",
                                    style: TextStyle(color: Colors.teal),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return SignUpScreen();
                                      }));
                                    },
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              )
            ],
          )),
    );
  }

  _appbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
          print("tapped");
        },
        child: Icon(
            Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round_outlined,
            size: 25,
            color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}
