import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:moimapp/helper/helperfunctions.dart';

import 'highlight_text.dart';

class TodoCreateCategory extends StatefulWidget{
  @override
  TodoCreateCategoryState createState() => TodoCreateCategoryState();
}

class TodoCreateCategoryState extends State<TodoCreateCategory> {

  String userEmail;
  String collegeName;
  String firstName;
  String userId;

  CollectionReference courseCategory;

  TextEditingController categoryName = new TextEditingController();

  Future _userSetting() async {
    userEmail = await HelperFunctions.getUserEmailPreference();
    collegeName = await HelperFunctions.getUserCollegePreference();
    firstName = await HelperFunctions.getUserFirstNamePreference();
    userId = await HelperFunctions.getUserNamePreference();
    courseCategory = Firestore.instance.
      collection(collegeName).
      document('path').
      collection('users').
      document(userEmail).
      collection('todoCategory');
    developer.log(userEmail);
    developer.log(collegeName);
    developer.log(firstName);
    developer.log(userId);
    String isNull = courseCategory == null?"no data": "valid value";
    developer.log(isNull);
  }

  Widget _todoCategoryBuilder(BuildContext context, AsyncSnapshot snapshot){
    return StreamBuilder<QuerySnapshot>(
      stream: courseCategory.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text("has error")
          );
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
              child: CircularProgressIndicator()
          );
        }else{
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget> [
                  GestureDetector(
                    onTap: (){developer.log("tapped");},
                    child: Container(
                      height: 70,
                      child: Card(
                          elevation: 1,
                          color: Colors.yellow[300],
                          child: Center(
                              child: Icon(Icons.add_circle, color:Colors.lightBlue)
                          )
                      )
                    )
                  ),
                  Expanded(
                      child: ListView(
                          children: snapshot.data.documents.map((DocumentSnapshot document){
                            if(snapshot.data == null) {
                              return Text('No data to show');
                            }else{
                              return Padding(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    height: 90,
                                    child: Card(
                                        elevation: 1,
                                        color: Colors.white,
                                        child: Center(
                                            child: ListTile(
                                              title: Text(document.documentID),
                                            )
                                        )
                                    )
                                ),
                              );
                            }
                          }).toList()
                      )
                  ),
                ]
              )
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Create a Todo Category'),
            backgroundColor: Colors.lightBlue,
            elevation: 0,
        ),
        body: FutureBuilder(
          future: _userSetting(),
          builder:(context, AsyncSnapshot snapshot){
            if(snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                    child: CircularProgressIndicator()
                );
              }
              return _todoCategoryBuilder(context, snapshot);
            }
            return Center(
                child: CircularProgressIndicator()
            );
          }
        )
    );
  }
}