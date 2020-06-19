import 'package:flutter/material.dart';
import 'package:moimapp/helper/helperfunctions.dart';
import 'package:moimapp/newCourse.dart';
import 'package:moimapp/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;
import 'package:moimapp/services/database.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<String> names = [];
  String dropdownValue;
  String selectedValue;
  String collegeName;
  String userEmail;

  Future _todoUserSetting() async {
    collegeName = await HelperFunctions.getUserCollegePreference();
    userEmail = await HelperFunctions.getUserEmailPreference();

    developer.log(collegeName);
    developer.log(userEmail);

    QuerySnapshot semester = await Firestore.instance
        .collection(collegeName)
        .document('path')
        .collection('users')
        .document(userEmail)
        .collection('courseList')
        .getDocuments();

    var list = semester.documents;
    for (DocumentSnapshot b in list) {
      names.add(b.documentID);
    }
    dropdownValue = names[0];
  }

  static List<String> semester;
  final CollectionReference semesterCollection =
      Firestore.instance.collection('Semesters');

  @override
  void initState(){
    super.initState();
  }
  List<double> score = [
    2.0,
    3.0,
    4.0,
    3.4,
  ];

  Widget errorScreen(BuildContext context, AsyncSnapshot snapshot) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Widget calc(BuildContext context, AsyncSnapshot snapshot) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white12,
          title: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection(collegeName)
                  .document('path')
                  .collection('users')
                  .document(userEmail)
                  .collection('courseList')
                  .snapshots(),
              builder: (context, snapshotOne) {
                if (!snapshotOne.hasData) {
                  return Text("Loading");
                } else {
                  List<DropdownMenuItem> items = [];
                  for (int i = 0; i < snapshotOne.data.documents.length; i++) {
                    DocumentSnapshot snap = snapshotOne.data.documents[i];
                    items.add(DropdownMenuItem(
                      child: Text(
                        snap.documentID,
//                          style:
                      ),
                      value: "${snap.documentID}",
                    ));
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DropdownButton(
                        dropdownColor: Colors.black,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        items: items,
                        onChanged: (currentValue) {
                          setState(() {
                            selectedValue = currentValue;
                          });
                        },
                        value: selectedValue,
                        hint: new Text(
                          "Choose Semester",
                          style: TextStyle(color: Colors.white),
                        )
                      ),
                    ],
                  );
                }
              }),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 30.0,
            tooltip: "Back",
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add_circle_outline),
                iconSize: 30.0,
                tooltip: "Add Term",
                onPressed: () {
                  print("Add");
                })
          ]),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 50.0,
            alignment: Alignment.centerLeft,
            child: ListTile(
              title: Text(
                'Your GPA :',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Text(
                '4.0',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          new Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: ListTile(
                        title: Text(
                          'Class Name',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          'Course Grade',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => course()),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 10,
                      color: Colors.white10,
                    );
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_circle_outline,
          size: 30,
        ),
        mini: true,
        backgroundColor: Colors.grey,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => newCourse()),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _todoUserSetting(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return errorScreen(context, snapshot);
            }
            return calc(context, snapshot);
          }
          return errorScreen(context, snapshot);
        });
  }
}
