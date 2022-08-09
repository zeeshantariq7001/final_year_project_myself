import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project_myself/constants/constants.dart';

///Globall
FirebaseFirestore firestore = FirebaseFirestore.instance;

///Class Firebase Operations
class FirebaseServicesTask {
  static Future<void> addNotesData(String ndate, String ntime) async {
    firestore.collection("DateTime").add({
      "time": ntime,
      "date": ndate,
    }).whenComplete(() => showToastMsg("Date time Added Successfully!"));
  }

  static Future<void> deleteNotes(String id) async {
    await firestore.collection("DateTime").doc(id).delete();
  }

  static Future<void> updateNotes(
    String id,
    String time,
    String date,
  ) async {
    await firestore.collection("DateTime").doc(id).update({
      "time": time,
      "date": date,
    }).whenComplete(() => showToastMsg("datetime Successfully!"));
  }
}
