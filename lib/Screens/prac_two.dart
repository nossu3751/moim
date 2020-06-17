import 'package:flutter/material.dart';

import 'package:moimapp/Screens/homepage.dart';

class PracticeTwo extends StatefulWidget {
  @override
  _PracticeTwoState createState() => _PracticeTwoState();
}

class _PracticeTwoState extends State<PracticeTwo> {
  double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double tableTopHeight = size.height * 0.03;
    double tableBodyHeight = size.height * 0.05;

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
                        children: [
                          TableRow(children: [
                            Column(children: [
                              Container(),
                            ]),
                            Column(children: [
                              Container(
                                alignment: Alignment.center,
                                height: tableTopHeight,
                                width: 50,
                                child: Text('Mon'),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                alignment: Alignment.center,
                                height: tableTopHeight,
                                width: 50,
                                child: Text('Tue'),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                alignment: Alignment.center,
                                height: tableTopHeight,
                                width: 50,
                                child: Text('Wed'),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                alignment: Alignment.center,
                                height: tableTopHeight,
                                width: 50,
                                child: Text('Thur'),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                alignment: Alignment.center,
                                height: tableTopHeight,
                                width: 50,
                                child: Text('Fri'),
                              ),
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.topRight,
                                height: tableBodyHeight,
                                child:
                                    Text('8', style: TextStyle(fontSize: 11)),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                height: tableBodyHeight,
                              ),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.topRight,
                                height: tableBodyHeight,
                                child:
                                    Text('9', style: TextStyle(fontSize: 11)),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                height: tableBodyHeight,
                              ),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.topRight,
                                height: tableBodyHeight,
                                child: Text(
                                  '10',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                height: tableBodyHeight,
                              ),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.topRight,
                                height: tableBodyHeight,
                                child: Text(
                                  '11',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                height: tableBodyHeight,
                              ),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.topRight,
                                height: tableBodyHeight,
                                child: Text(
                                  '12',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                height: tableBodyHeight,
                              ),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.topRight,
                                height: tableBodyHeight,
                                child: Text(
                                  '1',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                height: tableBodyHeight,
                              ),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.topRight,
                                height: tableBodyHeight,
                                child: Text(
                                  '2',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                height: tableBodyHeight,
                              ),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.topRight,
                                height: tableBodyHeight,
                                child: Text(
                                  '3',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                height: tableBodyHeight,
                              ),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.topRight,
                                height: tableBodyHeight,
                                child: Text(
                                  '4',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                height: tableBodyHeight,
                              ),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.topRight,
                                height: tableBodyHeight,
                                child: Text(
                                  '5',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                height: tableBodyHeight,
                              ),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                            Column(children: [
                              Container(height: tableBodyHeight),
                            ]),
                          ]),
                        ],
                      ),
                    ),
                    Positioned(
                        // if we pass in date / start time / length / info we can draw each tile
                        // if monday, size.width * 0.05 + size.width * 0.19*0
                        // if tuesday, size.width * 0.05 + size.width * 0.19*1
                        left: size.width * 0.05 + size.width * 0.19 * 1,
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
            ])));
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
