import 'package:flutter/material.dart';
import 'package:moimapp/newCourse.dart';
import 'package:moimapp/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moimapp/services/database.dart';


class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  static List<String> semester;
  final CollectionReference semesterCollection = Firestore.instance.collection('Semesters');
  @override
  void initState(){
    super.initState();
    semester = [];
  }

  String dropdownValue = '';
  List<String> courses = [
    "COSI 21A",
    "MUSIC 2B",
    "PHIL 110A",
    "COSI 127B",
  ];

  List<double> score = [
    2.0,
    3.0,
    4.0,
    3.4,
  ];

//  List<String> semesters = [
//    'Spring 2018',
//    'Fall 2018',
//    'Spring 2019',
//    'Fall 2019',
//  ];

  List<String> semesters(CollectionReference reference, List<String> list) {
    reference.getDocuments().then((snapshot) async{
      for(DocumentSnapshot temp in snapshot.documents){
        list.add(temp["name"] + " " + temp["year"]);
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white12,
          title: DropdownButton(
            dropdownColor: Colors.black,
            iconSize: 30,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
            value: dropdownValue,
            items: semesters(semesterCollection, semester).map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
          ),
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
}
