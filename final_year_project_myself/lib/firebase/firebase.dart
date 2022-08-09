import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Future<String?> createAccount(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-is-use") {
        return "Email allready in use";
      }
      if (e.code == "weak-password") {
        return "Password is too weak";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
