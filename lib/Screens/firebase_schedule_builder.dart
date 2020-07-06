import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moimapp/Screens/course_info.dart';
import 'package:moimapp/Screens/schedule_create.dart';
import 'package:moimapp/Screens/schedule_information.dart';
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
  Stream<List<Widget>> scheduleViewStream;
  Stream<List<Map<String, String>>> courseDataStream;
  List<Map<String,String>> courseData;
  int countBlocks;

  Future loadSchedule (BuildContext context) async {
    countBlocks = 0;
    weekdayFullName = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
    weekdayInt = {'Monday':0, 'Tuesday':1, 'Wednesday':2, 'Thursday':3, 'Friday':4,};
    scheduleBlocks = [];
    scheduleViews = [
      scheduleTable(context),
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

    await userCourses.getDocuments().then((QuerySnapshot document) async {

      for(DocumentSnapshot course in document.documents){
        developer.log(course.documentID);

        myCourses.add(courses.document(course.documentID));
        CollectionReference courseDays = userCourses.
        document(course.documentID).
        collection('weekdays');
        await courseDays.getDocuments().then((QuerySnapshot days) async {
          countBlocks += 1;
          for(DocumentSnapshot day in days.documents){
            developer.log(day.documentID);
//            courseData.add({course.documentID: day.documentID});
            await blockPositionInfoConverter(
                context,
                course.documentID,
                day.documentID,
                day.data["start_time"],
                day.data["end_time"]
            );
          }
        });
      }
    });
//    return courseData;
  }

  Widget scheduleTable(BuildContext context){
    return Container(
      child: Table(
        defaultVerticalAlignment:
        TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.lightBlueAccent),
        columnWidths: {
          0: FractionColumnWidth(0.05),
          1: FractionColumnWidth(0.19),
          2: FractionColumnWidth(0.19),
          3: FractionColumnWidth(0.19),
          4: FractionColumnWidth(0.19),
          5: FractionColumnWidth(0.19),
        },
        //build table here.
        children: scheduleTableBuilder(8,7,context),
      ),
    );
  }

  Future<List<Widget>> addScheduleView(BuildContext context, Map<String,dynamic>  blockInfo) async {
    int countScheduleView = scheduleViews.length;
    Size size = MediaQuery.of(context).size;
    double tableTopHeight = size.height * 0.03;
    double tableBodyHeight = size.height * 0.06;
    double tableMinuteHeight = tableBodyHeight / 12;


    String courseName = blockInfo['course_name'];
    double verticalPositionRatio = blockInfo['verticalPositionRatio'];
    int horizontalPositionRatio = blockInfo['horizontalPositionRatio'];
    double heightRatio = blockInfo['heightRatio'];

    scheduleViews.add(
        Positioned(
            left: size.width * 0.05 + size.width * 0.19 * horizontalPositionRatio,
            top: tableTopHeight + tableBodyHeight * (verticalPositionRatio - 8),
            child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new ClassInfo(courseName)
                    )
                  );
                },
                child: Container(
                    alignment: Alignment.center,
                    width: size.width * 0.19,
                    height: tableBodyHeight * heightRatio,
                    color: Colors.pink[200],
                    child: Text(courseName)
                )
            )
        )
    );

    return scheduleViews;
  }

  Future blockPositionInfoConverter(BuildContext context, String name, String weekday, String start, String end) async {

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

    scheduleBlocks.add(blockInfo);

    String endTime = end.split(" ")[0];
    double endHour = double.parse(endTime.split(":")[0]);
    double endMinute = double.parse(endTime.split(":")[1]);
    String endAmPm = end.split(" ")[1];
    String startTime = start.split(" ")[0];
    double startHour = double.parse(startTime.split(":")[0]);
    double startMinute = double.parse(startTime.split(":")[1]);
    String startAmPm = start.split(" ")[1];

    if(endAmPm == "PM" && endHour != 12){
      endHour += 12;
    }

    if(startAmPm == "PM" && startHour != 12){
      startHour += 12;
    }

    if(endAmPm == "AM" && endHour == 12){
      endHour -= 12;
    }

    if(startAmPm == "AM" && startHour == 12){
      startHour -= 12;
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

    scheduleViewStream = new Stream.fromFuture(addScheduleView(context, blockInfo));
//    scheduleViews.add(scheduleBlock(context,blockInfo));
    developer.log("there are " + scheduleViews.length.toString() + " blocks now");
    return blockInfo;
  }

  Widget loadingScreen(){
    return Center(
      child: CircularProgressIndicator()
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

    tableHead.add(Column(children: [Container(),]));

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

    if(lastTime <= firstTime) lastTime+=12;

    tableRows.add(TableRow(children: tableHead));

    for(int i = firstTime; i <= lastTime; i++){
      List<Column> tableBody = [];
      tableBody.add(
          Column(children: [
            Container(
              padding: EdgeInsets.all(2),
              alignment: Alignment.topRight,
              height: tableBodyHeight,
              child:
              Text((i == 12?i:i%12).toString(), style: TextStyle(fontSize: 11)),
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

    return FutureBuilder(
      future: loadSchedule(context),
      builder: (context,snapshot){

        developer.log(countBlocks.toString() + " blocks there when built");
        developer.log("there are " + scheduleBlocks.length.toString() + " positions built.");
        developer.log("there are " + scheduleViews.length.toString() + " positions built.");

        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            return loadingScreen();
          }else{
            return Scaffold(
              appBar:AppBar(
                title: Text(
                    "Course Schedule",
                    style: TextStyle(color: Colors.white)
                ),
                elevation: 0,
                backgroundColor: Colors.lightBlue,
              ),
              body: StreamBuilder(
                  stream: scheduleViewStream,
                  builder: (context, stream){
                    if(stream.hasError){
                      return loadingScreen();
                    }else if(stream.connectionState == ConnectionState.waiting){
                      return loadingScreen();
                    }else{
                      return Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                              children: <Widget>[
                                Center(
                                    child: Column(
                                        children: <Widget>[
                                          Stack(
                                            children: stream.data != null ? stream.data: <Widget>[scheduleTable(context)] ,
                                          ),
                                        ]
                                    )
                                )
                              ]
                          )
                      );
                    }
                  }
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateSchedule((){
                              setState((){

                              });
                            })
                        )
                    );
                  },
                  child: Icon(Icons.create, color: Colors.yellow[300]),
                  backgroundColor: Colors.lightBlue,
                  elevation: 0
              ),
            );
          }
        }else{
          return loadingScreen();
        }
      }
    );
  }
}