import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference semesterCollection =
      Firestore.instance.collection('Semesters');

  Future updateSemester(String semester) async {
    return await semesterCollection.document(uid).setData({
      'semester' : semester
    });
  }
}
