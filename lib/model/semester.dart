import 'package:cloud_firestore/cloud_firestore.dart';
import 'course.dart';

class Semester {
  String id;
  String name;
  List courses;

  Semester.fromMap(Map<String, dynamic> data){
    id = data['id'];
    name = data['name'];
    courses = data['courses'];
  }
}