import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule_db {
  static String Csubject = "";
  static String Ctitle = "";

  getCourse() async {
    return await Firestore.instance
        .collection('Mount Holyoke College')
        .document('path')
        .collection('Semester')
        .document('2020Fall')
        .collection('Course')
        .where('major', isGreaterThanOrEqualTo: Csubject)
//        .where('course_name', isGreaterThanOrEqualTo: Ctitle)
        .snapshots();
  }

  clearSearch() {
    Csubject = "";
    Ctitle = "";
  }
}