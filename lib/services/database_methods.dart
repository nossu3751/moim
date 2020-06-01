import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  uploadUserInfo(String college, userMap) {
    Firestore.instance
        .collection(college)
        .document('path')
        .collection('users')
        .add(userMap);
  }
}
