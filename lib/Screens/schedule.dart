import 'package:flutter/material.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Screens/addCourse.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:moimapp/Widgets/Schedule/src/timetable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchedulePage extends StatefulWidget {
  final collection = Firestore.instance.collection('testcourse');

  SchedulePageState createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  final Duration duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            {}
          },
        ),
        title: HighlightText(
            text: '2020 Fall',
            fontStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCourse()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: widget.collection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: Container(child: CircularProgressIndicator()));
            default:
              return Material(
                animationDuration: duration,
                elevation: 8,
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                        ),
                        Container(
//                      margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(20),
                                border: Border.symmetric(
                                    vertical: BorderSide(width: 0.5))),
                            alignment: Alignment.center,
                            child: WeeklyTimeTable(
                              onValueChanged: (Map<int, List<int>> selected) {
                                print(selected);
                              },
                            )),
                        ListView(
                          shrinkWrap: true,
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            if (snapshot.data == null) {
                              return Text('No data to show');
                            } else {
                              return Card(
                                  child: ListTile(
                                title: Text(document['cname']),
                                trailing: Text(document['days'].toString()),
                              ));
                            }
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }
        },
      ),
//        bottomNavigationBar: BottomNavigationBar(
//          items: [
//            BottomNavigationBarItem(
//              icon: Icon(Icons.home),
//              title: Text(
//                'Home',
//              ),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.question_answer),
//              title: Text(
//                'Feed',
//              ),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.calendar_today),
//              title: Text(
//                'Schedule',
//              ),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.more_horiz),
//              title: Text('More'),
//            ),
//          ],
//          type: BottomNavigationBarType.fixed,
//          selectedItemColor: Colors.black,
//          unselectedItemColor: Colors.black,
//          showSelectedLabels: false,
//          showUnselectedLabels: false,
//        )
    );
  }
}
