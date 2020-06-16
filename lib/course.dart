import 'package:flutter/material.dart';
import 'package:moimapp/newAssignment.dart';


class course extends StatefulWidget {
  @override
  _courseState createState() => _courseState();
}

class _courseState extends State<course> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white12,
        title: Text('Class Name'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          tooltip: "Back",
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 50.0,
            child: ListTile(
              title: Text(
                'Attendance :',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Text(
                '9.00%',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 40.0,
            child: ListTile(
              title: Text(
                'Participation :',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              trailing: Text(
                '9.00%',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 50.0,
            child: ListTile(
              title: Text(
                'Assignments :',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Text(
                '25.50%',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 40.0,
            child: ListTile(
              title: Text(
                'Programming Assignment 1 :',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              trailing: Text(
                '70.00%',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 40.0,
            child: ListTile(
              title: Text(
                'Programming Assignment 2 :',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              trailing: Text(
                '85.00%',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 40.0,
            child: ListTile(
              title: Text(
                'Problem Set 1 :',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              trailing: Text(
                '95.00%',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 40.0,
            child: ListTile(
              title: Text(
                'Problem Set 2 :',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              trailing: Text(
                '90.00%',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 50.0,
            child: ListTile(
              title: Text(
                'Exams :',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Text(
                '35.00%',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 40.0,
            child: ListTile(
              title: Text(
                'Midterm 1 :',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              trailing: Text(
                '90.00%',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 40.0,
            child: ListTile(
              title: Text(
                'Midterm 2 :',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              trailing: Text(
                '85.00%',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 50.0,
            child: ListTile(
              title: Text(
                'Project :',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Text(
                '16.00%',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            height: 40.0,
            child: ListTile(
              title: Text(
                'Project :',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              trailing: Text(
                '80.00%',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
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
            MaterialPageRoute(builder: (context) => newAssignment()),
          );
        },
      ),
    );
  }
}
