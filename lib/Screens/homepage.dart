import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Widgets/icon_button.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:moimapp/Screens/schedule.dart';

import 'messages/message_home.dart';

//
class MyHomePage extends StatefulWidget{
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HighlightText(
                text: 'HomePage .',
                fontStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          ],
    ),
    Text("Feed"),
    SchedulePage(),
    MessageHome(),
  ];

  void onTabTapped(int index){
    setState((){
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[50],
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: Colors.black,
              ),
              onPressed: () {
                {}
                ;
              },
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                {}
                ;
              },
            ),
            // IconButton(
            //   icon: Icon(
            //     Icons.notifications,
            //     color: Colors.black,
            //   ),
            //   onPressed: () {
            //     {}
            //     ;
            //   },
            // ),
          ],
        ),
        body: _children[_currentIndex],
//        body: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            HighlightText(
//                text: 'HomePage .',
//                fontStyle:
//                    TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
//          ],
//        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex:_currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
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
              icon: Icon(Icons.question_answer),
              title: Text('Message'),

            ),
          ],
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
        ));
  }
}
