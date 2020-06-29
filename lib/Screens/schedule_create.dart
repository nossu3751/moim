import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moimapp/helper/constants.dart';
import 'package:moimapp/widgets/timepicker.dart';

import 'firebase_schedule_builder.dart';
typedef DoRebuild = void Function();
class CreateSchedule extends StatefulWidget{
//  final Function refresh;
//  @override
//  CreateSchedule({@required this.refresh});
  final DoRebuild callback;
  CreateSchedule(this.callback);
  @override
  CreateScheduleState createState() => CreateScheduleState();
}

class CreateScheduleState extends State<CreateSchedule>{
  CollectionReference userCourses = Firestore.instance.
      collection(Constants.myCollege).
      document('path').
      collection('users').
      document(Constants.myEmail).
      collection('courseSchedule');

  CollectionReference courses = Firestore.instance.
      collection(Constants.myCollege).
      document('path').
      collection('courses');

  List<DropdownMenuItem> weekdays;
  String selectedWeekday;
  final TextEditingController courseTitle = TextEditingController();
  final TextEditingController courseCode = TextEditingController();
  final TextEditingController professorName = TextEditingController();
  final TextEditingController startTime = TextEditingController();
  final TextEditingController endTime = TextEditingController();

  @override
  void initState(){
    super.initState();
    weekdays = [];
    List<String> weekdayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    for(String wd in weekdayNames){
      weekdays.add(
        DropdownMenuItem(
          child: Text(wd),
          value: wd,
        )
      );
    }
  }

  Future setCourseData() async {
    await courses.document(courseCode.text).setData({
      'course_code': courseCode.text,
      'course_title': courseTitle.text,
      'professor_name': professorName.text,
    });
    await courses.document(courseCode.text).collection('weekdays').document(selectedWeekday).setData({
      'start_time': startTime.text,
      'end_time': endTime.text,
    });
  }

  Future setUserCourseData() async{
    await userCourses.document(courseCode.text).setData({
      'course_code': courseCode.text,
      'course_title': courseTitle.text,
      'professor_name': professorName.text,
    });
    await userCourses.document(courseCode.text).collection('weekdays').document(selectedWeekday).setData({
      'start_time': startTime.text,
      'end_time': endTime.text,
    });
  }

  Widget scheduleForm(){
    return Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            TextField(
                controller: courseTitle,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'Course Title'
                )
            ),
            TextField(
                controller: courseCode,
                decoration: InputDecoration(
                    labelText: 'Course Code'
                )
            ),
            TextField(
                controller: professorName,
                decoration: InputDecoration(
                    labelText: 'Professor Name'
                )
            ),
            BasicTimeField(controller: startTime),
            BasicTimeField(controller: endTime),
            DropdownButton(
                isExpanded: true,
                itemHeight: 70,
                dropdownColor: Colors.white,
                style: TextStyle(color: Colors.black),
                items: weekdays,
                onChanged: (currentValue) {
                  setState(() {
                    selectedWeekday = currentValue;
                  });
                },
                value: selectedWeekday,
                hint: new Text(
                  "Choose Category",
                )
            )
          ],
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        title: Text("Create Schedule", style: TextStyle(color: Colors.white),)
      ),
      body: scheduleForm(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Future.wait([
            setCourseData(),
            setUserCourseData(),
          ]);
//          widget.refresh(context);
          widget.callback();
          Navigator.pop(context);
        },
        child: Icon(Icons.check, color: Colors.yellow[300]),
        backgroundColor: Colors.lightBlue,
        elevation: 0
      ),
    );
  }
}

