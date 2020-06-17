import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Widgets/icon_button.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:moimapp/Screens/schedule.dart';
import 'package:moimapp/helper/constants.dart';
import 'package:moimapp/helper/helperfunctions.dart';
import 'package:moimapp/justin_main.dart';
import 'package:moimapp/widgets/todo.dart';

import '../calculator.dart';
import 'messages/message_home.dart';

//

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 500,
              child: Column(
                  children:<Widget>[
                    GestureDetector(
                      child: Icon(Icons.border_all, color: Colors.lightBlue, size:100),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Calculator()),
                        );
                      },
                    ),
                    GestureDetector(
                        child: Icon(Icons.check, color:Colors.lightBlue, size:100),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Todo()),
                          );
                        }
                    ),
                  ]
              )
          ),
          HighlightText(
              text: 'HomePage .',
              fontStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ],
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    JustinHomePage(),
    SchedulePage(),
    MessageHome(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    setState(() {
      isLoading = true; //Data is loading
    });
    Constants.myUsername = await HelperFunctions.getUserNamePreference();
    Constants.myCollege = await HelperFunctions.getUserCollegePreference();
    Constants.myEmail = await HelperFunctions.getUserEmailPreference();
    Constants.myFirstname = await HelperFunctions.getUserFirstNamePreference();
    setState(() {
      //Data has loaded
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.blue[50],
//          actions: <Widget>[
//            // action button
//            IconButton(
//              icon: Icon(
//                Icons.person_outline,
//                color: Colors.black,
//              ),
//              onPressed: () {
//                {}
//                ;
//              },
//            ),
//            IconButton(
//              icon: Icon(
//                Icons.search,
//                color: Colors.black,
//              ),
//              onPressed: () {
//                {}
//                ;
//              },
//            ),
//            // IconButton(
//            //   icon: Icon(
//            //     Icons.notifications,
//            //     color: Colors.black,
//            //   ),
//            //   onPressed: () {
//            //     {}
//            //     ;
//            //   },
//            // ),
//          ],
//        ),
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
          currentIndex: _currentIndex,
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
