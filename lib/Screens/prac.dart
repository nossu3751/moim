import 'package:flutter/material.dart';

import 'package:moimapp/Screens/homepage.dart';

class Practice extends StatefulWidget {
  @override
  _PracticeState createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double tableTopHeight = size.height * 0.03;
    double tableBodyHeight = size.height * 0.05;

    double tableInsideBodyHeight = tableBodyHeight / 12;
    return Scaffold(
  
        body: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(children: <Widget>[
      GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyHomePage();
            }));
          },
          child: Text('Home')),
      Text(
        'Timetable',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      SizedBox(height: 20),
      Center(
          child: Column(children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                        child: Text('8', style: TextStyle(fontSize: 11)),
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
                        child: Text('9', style: TextStyle(fontSize: 11)),
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
              left: size.width * 0.05,
              top: size.height * 0.03,
              child: Container(
                width: size.width * 0.95,
                height: size.height * 0.97,
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(color: Colors.amber
                      // bottom: BorderSide(color: Colors.grey),
                      // top: BorderSide(color: Colors.grey),
                      // right: BorderSide(color: Colors.grey),
                      // left: BorderSide(color: Colors.grey),
                      ),
                  columnWidths: {
                    0: FractionColumnWidth(0.2),
                    1: FractionColumnWidth(0.2),
                    2: FractionColumnWidth(0.2),
                    3: FractionColumnWidth(0.2),
                    4: FractionColumnWidth(0.2),
                    5: FractionColumnWidth(0.2)
                  },
                  children: [
                    TableRow(children: [
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                        ),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                        ),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                        ),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                        ),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                        ),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                        ),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                        ),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                        ),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                        ),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                        ),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                        ),
                      ]),
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                          color: Colors.blue,
                        ),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          height: tableInsideBodyHeight,
                        ),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                      Column(children: [
                        Container(height: tableInsideBodyHeight),
                      ]),
                    ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ]))
    ])));
    // );
  }
}
