import 'package:flutter/material.dart';

class newAssignment extends StatefulWidget {
  @override
  _newAssignmentState createState() => _newAssignmentState();
}

class _newAssignmentState extends State<newAssignment> {
  String dropdownValue = 'Attendance';
  List<String> categories = [
    'Attendance',
    'Assignments',
    'Exams',
    'Project',
  ];
  String dropDownValue1 = 'Default';
  List<String> weights = [
    'Default',
    'Custom',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white12,
          title: Text('Add an Assignment'),
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
                tooltip: "Add Assignment",
                onPressed: () {
                  print("Confirm");
                })
          ]),
      body: Column(
        children: <Widget>[
          SizedBox(
            child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 250,
                    height: 48,
                    color: Colors.white,
                    child: Text(
                      '  Assignment Name:',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                Flexible(
                  child: TextFormField(
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Enter Name',
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 250,
                    height: 48,
                    color: Colors.white,
                    child: Text(
                      '  Assignment Type',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 14),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    iconSize: 30,
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    value: dropdownValue,
                    items: categories.map<DropdownMenuItem<String>>((String value) {
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
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 250,
                    height: 48,
                    color: Colors.white,
                    child: Text(
                      '  Assignment Weight:',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 61),
                  child: DropdownButton(

                    dropdownColor: Colors.white,
                    iconSize: 30,
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    value: dropDownValue1,
                    items: weights.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropDownValue1 = newValue;
                      });
                    },
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
                      '  Grade:',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                Flexible(
                  child: TextFormField(
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Enter Grade',
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
    );
  }
}
