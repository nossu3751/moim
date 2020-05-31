import 'package:flutter/material.dart';
import 'package:moim/Widgets/highlight_text.dart';
import 'package:moim/Widgets/icon_button.dart';
import 'package:moim/Widgets/round_button.dart';
import 'package:weekly_timetable/weekly_timetable.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

//
class SchedulePage extends StatelessWidget {
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
                {}
              },
            ),
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          child: WeeklyTimeTable(

          )
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              title: Text(
                'Feed',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text(
                'Schedule',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              title: Text('More'),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ));
  }
}
