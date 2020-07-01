import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

import 'package:moimapp/helper/constants.dart';

class ClassInfo extends StatefulWidget{
  final String documentID;

  @override
  ClassInfo(this.documentID);
  @override
  ClassInfoState createState() => ClassInfoState();
}

class ClassInfoState extends State<ClassInfo>{

  Widget loadingScreen(){
    return Center(
      child: CircularProgressIndicator()
    );
  }

  Widget courseScaffold(DocumentSnapshot course){
    return Scaffold(
      appBar: AppBar(
        title: Text(course.documentID)
      ),
      body: Center(
        child: Column(
          children: <Widget>[

          ]
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(Constants.myCollege)
          .document('path')
          .collection('courses')
          .where("course_code",isEqualTo:widget.documentID)
          .snapshots(),
      builder: (context,snapshot) {
        if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
          return loadingScreen();
        } else {
          return courseScaffold(snapshot.data.documents[0]);
        }
      }
    );
  }
}