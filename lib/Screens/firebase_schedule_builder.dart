import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moimapp/Screens/schedule_create.dart';
import 'package:moimapp/helper/constants.dart';
import 'dart:developer' as developer;

class FireStoreSchedule extends StatefulWidget{
  @override
  FireStoreScheduleState createState() => FireStoreScheduleState();
}

class FireStoreScheduleState extends State<FireStoreSchedule>{
  List<String> weekdayFullName;
  Map<String,int> weekdayInt;
  List<Map<String,dynamic>> scheduleBlocks;
  List<Widget> scheduleViews;
  Set<DocumentReference> myCourses;
  CollectionReference courses;
  CollectionReference userCourses;

  Future loadSchedule(BuildContext context) async {
    weekdayFullName = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
    weekdayInt = {'Monday':0, 'Tuesday':1, 'Wednesday':2, 'Thursday':3, 'Friday':4,};
    scheduleBlocks = [];
    scheduleViews = [
      Container(
        child: Table(
          defaultVerticalAlignment:
          TableCellVerticalAlignment.middle,
          border: TableBorder.all(color: Colors.grey[350]),
          columnWidths: {
            0: FractionColumnWidth(0.05),
            1: FractionColumnWidth(0.19),
            2: FractionColumnWidth(0.19),
            3: FractionColumnWidth(0.19),
            4: FractionColumnWidth(0.19),
            5: FractionColumnWidth(0.19),
            6: FractionColumnWidth(0.19)
          },
          //build table here.
          children: scheduleTableBuilder(8,7,context),
        ),
      )
    ];
    myCourses = new Set();
    courses = Firestore.instance
        .collection(Constants.myCollege)
        .document('path')
        .collection('courses');
    userCourses = Firestore.instance
        .collection(Constants.myCollege)
        .document('path')
        .collection('users')
        .document(Constants.myEmail)
        .collection('courseSchedule');
    await userCourses.getDocuments().then((QuerySnapshot document){
      document.documents.forEach((course) async {

        //debug reading
        developer.log(course.documentID);

        myCourses.add(courses.document(course.documentID));
        CollectionReference courseDays = userCourses.
            document(course.documentID).
            collection('weekdays');
        await courseDays.getDocuments().then((QuerySnapshot days){
          days.documents.forEach((day){

            developer.log(day.documentID);

            Map<String,dynamic> blockInfo = blockPositionInfoConverter(
              context,
              course.documentID,
              day.documentID,
              day.data["start_time"],
              day.data["end_time"]
            );
            scheduleBlocks.add(blockInfo);
          });
        });
      });
    });
    await Future.delayed(Duration(milliseconds: 3000));
  }

  Map<String,dynamic> blockPositionInfoConverter(BuildContext context, String name, String weekday, String start, String end) {

    developer.log(name);
    developer.log(weekday);
    developer.log(start);
    developer.log(end);

    Map<String, dynamic> blockInfo = {
      'course_name': name,
      'verticalPositionRatio': null,
      'horizontalPositionRatio': null,
      'heightRatio': null,
    };

    String endTime = end.split(" ")[0];
    double endHour = double.parse(endTime.split(":")[0]);
    double endMinute = double.parse(endTime.split(":")[1]);
    String endAmPm = end.split(" ")[1];
    String startTime = start.split(" ")[0];
    double startHour = double.parse(startTime.split(":")[0]);
    double startMinute = double.parse(startTime.split(":")[1]);
    String startAmPm = start.split(" ")[1];

    if(endAmPm == "PM"){
      endHour += 12;
    }
    if(startAmPm == "PM"){
      startHour += 12;
    }

    endHour += endMinute/60;
    startHour += startMinute/60;

    developer.log(endHour.toString());
    developer.log(startHour.toString());

    blockInfo['heightRatio'] = endHour - startHour;

    developer.log(blockInfo['heightRatio'].toString());

    blockInfo['horizontalPositionRatio'] = weekdayInt[weekday];

    developer.log(blockInfo['horizontalPositionRatio'].toString());

    blockInfo['verticalPositionRatio'] = startHour;

    developer.log(blockInfo['verticalPositionRatio'].toString());

    scheduleViews.add(scheduleBlock(context,blockInfo));
    developer.log("there are " + scheduleViews.length.toString() + " blocks now");

    return blockInfo;
  }

  Widget loadingScreen(){
    return Center(
      child: CircularProgressIndicator()
    );
  }

  Widget scheduleBlock(BuildContext context, Map<String,dynamic> blockInfo){
    Size size = MediaQuery.of(context).size;
    double tableTopHeight = size.height * 0.03;
    double tableBodyHeight = size.height * 0.06;
    double tableMinuteHeight = tableBodyHeight / 12;

    developer.log("table top height is " + tableTopHeight.toString());

    String courseName = blockInfo['course_name'];
    double verticalPositionRatio = blockInfo['verticalPositionRatio'];
    int horizontalPositionRatio = blockInfo['horizontalPositionRatio'];
    double heightRatio = blockInfo['heightRatio'];

    developer.log("Building Positioned... course name is " + courseName);
    developer.log("Building Positioned... vertical position is " + verticalPositionRatio.toString());
    developer.log("Building Positioned... horizontal position is " + horizontalPositionRatio.toString());
    developer.log("Building Positioned... heightRatio is " + heightRatio.toString());

    return Positioned(
      left: size.width * 0.05 + size.width * 0.19 * horizontalPositionRatio,
      top: tableTopHeight + tableBodyHeight * (verticalPositionRatio - 8),
      child: GestureDetector(
        onTap: null,
        child: Container(
          alignment: Alignment.center,
          width: size.width * 0.19,
          height: tableBodyHeight * heightRatio,
          color: Colors.pink[200],
          child: Text(courseName)
        )
      )
    );
  }

  // Table Rows for Table

  TableRow tableRow(int rowLabel, double tableBodyHeight){
    List<Column> rows = [];
    rows.add(
        Column(children: [
          Container(
            padding: EdgeInsets.all(2),
            alignment: Alignment.topRight,
            height: tableBodyHeight,
            child: Text(
              rowLabel.toString(),
              style: TextStyle(fontSize: 11),
            ),
          ),
        ])
    );
    for(int i = 0; i < 5; i++){
      rows.add(
          Column(children: [
            Container(height: tableBodyHeight),
          ])
      );
    }
    return TableRow(children: rows);
  }

  List<TableRow> scheduleTableBuilder(int firstTime, int lastTime, BuildContext context){
    Size size = MediaQuery.of(context).size;
    double tableTopHeight = size.height * 0.03;
    double tableBodyHeight = size.height * 0.06;
    double tableMinuteHeight = tableBodyHeight / 12;

    List<TableRow> tableRows = [];
    List<String> weekdays = ["Mon","Tue","Wed","Thu","Fri"];
    List<Column> tableHead = [];
    tableHead.add(
        Column(children: [
          Container(),
        ])
    );

    for(int i = 0; i < weekdays.length; i++){
      tableHead.add(
          Column(children: [
            Container(
              alignment: Alignment.center,
              height: tableTopHeight,
              width: 50,
              child: Text(weekdays[i]),
            ),
          ])
      );
    }

    if(lastTime <= firstTime){
      lastTime+=12;
    }

    tableRows.add(
        TableRow(children: tableHead)
    );

    for(int i = firstTime; i <= lastTime; i++){
      List<Column> tableBody = [];
      tableBody.add(
          Column(children: [
            Container(
              padding: EdgeInsets.all(2),
              alignment: Alignment.topRight,
              height: tableBodyHeight,
              child:
              Text((i%12).toString(), style: TextStyle(fontSize: 11)),
            ),
          ])
      );
      for(int i = 0; i < weekdays.length; i++){
        tableBody.add(
            Column(children: [
              Container(height: tableBodyHeight),
            ])
        );
      }
      tableRows.add(
          TableRow(children: tableBody)
      );
    }
    return tableRows;
  }



  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double tableTopHeight = size.height * 0.03;
    double tableBodyHeight = size.height * 0.06;
    double tableMinuteHeight = tableBodyHeight / 12;



    return FutureBuilder(
      future: loadSchedule(context),
      builder: (context,snapshot){

        developer.log("there are " + scheduleViews.length.toString() + " positions built.");

        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError) return loadingScreen();
          return Scaffold(
            appBar:AppBar(
              title: Text(
                  "Course Schedule",
                  style: TextStyle(color: Colors.white)
              ),
              elevation: 0,
              backgroundColor: Colors.lightBlue,
            ),
            body: Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(children: <Widget>[
                  Center(
                      child: Column(children: <Widget>[
                        Stack(
                          children: scheduleViews,
                        ),
                      ]))
                ])),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateSchedule()
                    )
                );
              },
              child: Icon(Icons.create, color: Colors.yellow[300]),
              backgroundColor: Colors.lightBlue,
              elevation: 0
            ),
          );
        }
        return loadingScreen();
      }
    );
  }
}