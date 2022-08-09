import 'package:final_year_project_myself/screens/all_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider {
  Future<bool>? LogInWithPhone(BuildContext context, String phone) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    TextEditingController otpc = TextEditingController();

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (AuthCredential credential) async {
          UserCredential result = await _auth.signInWithCredential(credential);
          Navigator.pop(context);
          User? user = result.user;
          if (user != null) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
              return AdminScreen();
            }), (route) => false);
          } else {
            Fluttertoast.showToast(msg: "user is not signed in");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(msg: e.toString());
        },
        codeSent: (String? verificationcode, int? token) {
          showDialog(
              context: context,
              builder: (c) {
                return AlertDialog(
                  title: Text("Enter OTP"),
                  content: Column(
                    children: [
                      TextField(
                        controller: otpc,
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () async {
                          final code = otpc.text;
                          AuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationcode.toString(),
                                  smsCode: code);
                          UserCredential result =
                              await _auth.signInWithCredential(credential);
                          User? user = result.user;
                          if (user != null) {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (_) {
                              return AdminScreen();
                            }), (route) => false);

                            print("success");
                          } else {
                            Fluttertoast.showToast(msg: "error");
                          }
                        },
                        child: Text("verify"))
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (id) => {});
  }
}
// keytool -list -v -keystore "Dell\.android\debug.keystore"-alias androiddebugkey -storepass android -keypass android