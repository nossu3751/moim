import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Widgets/icon_button.dart';
import 'package:moimapp/Widgets/round_button.dart';

//
class MyHomePage extends StatelessWidget {
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HighlightText(
                text: 'HomePage .',
                fontStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          ],
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
