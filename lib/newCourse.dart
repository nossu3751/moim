import 'package:flutter/material.dart';

class newCourse extends StatefulWidget {
  @override
  _newCourseState createState() => _newCourseState();
}

class _newCourseState extends State<newCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white10,
      appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white12,
          title: Text('Add a Course'),
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
                icon: Icon(Icons.check_circle_outline),
                iconSize: 30.0,
                tooltip: "Add Term",
                onPressed: () {
                  print("Confirm");
                })
          ]),
      body: Column(
        children: <Widget>[
          TextFormField(
            style: TextStyle(color: Colors.black, fontSize: 20.0),
            decoration: InputDecoration(
              hintText: 'Enter Course Title',
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          TextFormField(

            style: TextStyle(color: Colors.black, fontSize: 20.0),
            decoration: InputDecoration(
              hintText: 'Enter Course Credit',
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          Container(
              alignment: Alignment.center,
              width: 1000,
              height: 60,
              color: Colors.white10,
              child: Text(
                'Course Weight :',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 250,
                    height: 48,
                    color: Colors.white,
                    child: Text(
                      '  Attendance:',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                Flexible(
                  child: TextFormField(
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Enter Weight',
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 250,
                    height: 48,
                    color: Colors.white,
                    child: Text(
                      '  Assignments:',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                Flexible(
                  child: TextFormField(
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Enter Weight',
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 250,
                    height: 48,
                    color: Colors.white,
                    child: Text(
                      '  Exams:',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                Flexible(
                  child: TextFormField(
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Enter Weight',
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 250,
                    height: 48,
                    color: Colors.white,
                    child: Text(
                      '  Project:',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                Flexible(
                  child: TextFormField(
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Enter Weight',
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                )
              ],
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

        },
      ),
    );
  }
}
