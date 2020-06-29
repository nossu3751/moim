import 'package:flutter/material.dart';

import 'package:moimapp/Screens/homepage.dart';
import 'package:moimapp/Screens/schedule_create.dart';

class HeightScheduleBuilder extends StatefulWidget {
  @override
  _HeightScheduleBuilderState createState() => _HeightScheduleBuilderState();
}


class _HeightScheduleBuilderState extends State<HeightScheduleBuilder> {
  double iconSize = 40;

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

  List<TableRow> scheduleTableBuilder(int firstTime, int lastTime, double tableTopHeight, double tableBodyHeight){
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

    double tableInsideBodyHeight = tableBodyHeight / 12;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Timetable'),
        ),
        //     body: GridPaper(
        //   child: Container(),
        //   color: Colors.amber,
        // )
        body: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(children: <Widget>[
              Center(
                  child: Column(children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder.all(color: Colors.grey[350]
                            // bottom: BorderSide(color: Colors.grey),
                            // top: BorderSide(color: Colors.grey),
                            // right: BorderSide(color: Colors.grey),
                            // left: BorderSide(color: Colors.grey),
                            ),
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
                        children: scheduleTableBuilder(8,7,tableTopHeight,tableBodyHeight),
                      ),
                    ),
                    Positioned(
                        // if we pass in date / start time / length / info we can draw each tile
                        // if monday, size.width * 0.05 + size.width * 0.19*0
                        // if tuesday, size.width * 0.05 + size.width * 0.19*1
                        left: size.width * 0.05 + size.width * 0.76 * 1,
                        // if 8:00, size.height * 0.03
                        // if 8:05, size.height * 0.03 + tableInsideBodyHeight * 1,
                        // if 8:10, size.height * 0.03 + tableInsideBodyHeight * 2,
                        // if 9:00, size.height * 0.03 + tableInsideBodyHeight * 12
                        // 1 hour = tableInsideBodyHeight * 12
                        top: tableTopHeight + tableInsideBodyHeight * 0,
                        // tableBodyHeight represents the height for 5 mins
                        // if 60 mins class 60/5 = 12
                        // tableBodyHeight * 12
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width * 0.19,
                          height: tableInsideBodyHeight * 24,
                          color: Colors.pink[200],
                          child: Text('COMSC 225'),
                        )),
                    Positioned(
                        // if monday, size.width * 0.05 + size.width * 0.19*0
                        // if tuesday, size.width * 0.05 + size.width * 0.19*1
                        left: size.width * 0.05 + size.width * 0.19 * 3,
                        // if 8:00, size.height * 0.03
                        // if 8:05, size.height * 0.03 + tableInsideBodyHeight * 1,
                        // if 8:10, size.height * 0.03 + tableInsideBodyHeight * 2,
                        // if 9:00, size.height * 0.03 + tableInsideBodyHeight * 12
                        // 1 hour = tableInsideBodyHeight * 12
                        top: size.height * 0.03 + tableInsideBodyHeight * 18,
                        // tableBodyHeight represents the height for 5 mins
                        // if 60 mins class 60/5 = 12
                        // tableBodyHeight * 12
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width * 0.19,
                          height: tableInsideBodyHeight * 24,
                          color: Colors.pink[200],
                          child: Text('COMSC 225'),
                        )),
                    Positioned(
                        // if monday, size.width * 0.05 + size.width * 0.19*0
                        // if tuesday, size.width * 0.05 + size.width * 0.19*1
                        left: size.width * 0.05 + size.width * 0.19 * 0,
                        // if 8:00, size.height * 0.03
                        // if 8:05, size.height * 0.03 + tableInsideBodyHeight * 1,
                        // if 8:10, size.height * 0.03 + tableInsideBodyHeight * 2,
                        // if 9:00, size.height * 0.03 + tableInsideBodyHeight * 12
                        // 1 hour = tableInsideBodyHeight * 12
                        top: size.height * 0.03 + tableInsideBodyHeight * 36,
                        // tableBodyHeight represents the height for 5 mins
                        // if 60 mins class 60/5 = 12
                        // tableBodyHeight * 12
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width * 0.19,
                          height: tableInsideBodyHeight * 24,
                          color: Colors.amber,
                          child: Text('COMSC 225'),
                        )),
                    // Positioned(
                    //     // if monday, size.width * 0.05 + size.width * 0.19*0
                    //     // if tuesday, size.width * 0.05 + size.width * 0.19*1
                    //     left: size.width * 0.05 + size.width * 0.19 * 2,
                    //     // if 8:00, size.height * 0.03
                    //     // if 8:05, size.height * 0.03 + tableInsideBodyHeight * 1,
                    //     // if 8:10, size.height * 0.03 + tableInsideBodyHeight * 2,
                    //     // if 9:00, size.height * 0.03 + tableInsideBodyHeight * 12
                    //     // 1 hour = tableInsideBodyHeight * 12
                    //     top: size.height * 0.03 + tableInsideBodyHeight * 36,
                    //     // tableBodyHeight represents the height for 5 mins
                    //     // if 60 mins class 60/5 = 12
                    //     // tableBodyHeight * 12
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       width: size.width * 0.19,
                    //       height: tableInsideBodyHeight * 24,
                    //       color: Colors.amber,
                    //       child: Text('COMSC 225'),
                    //     )),
                    // returnPositioned(),
                  ],
                ),
              ]))
            ])),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
//                  builder: (context) => CreateSchedule()
              )
            );
          },
          child: Icon(Icons.create, color: Colors.yellow[300]),
          backgroundColor: Colors.lightBlue,
          elevation: 0
      ),
    );
  }
}

returnPositioned() {
  return Positioned(
      // if monday, size.width * 0.05 + size.width * 0.19*0
      // if tuesday, size.width * 0.05 + size.width * 0.19*1
      left: 80,
      // if 8:00, size.height * 0.03
      // if 8:05, size.height * 0.03 + tableInsideBodyHeight * 1,
      // if 8:10, size.height * 0.03 + tableInsideBodyHeight * 2,
      // if 9:00, size.height * 0.03 + tableInsideBodyHeight * 12
      // 1 hour = tableInsideBodyHeight * 12
      top: 80,
      // tableBodyHeight represents the height for 5 mins
      // if 60 mins class 60/5 = 12
      // tableBodyHeight * 12
      child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 40,
        color: Colors.amber,
        child: Text('COMSC 225'),
      ));
}
