import 'package:flutter/material.dart';
import 'package:moimapp/Screens/prac.dart';
import 'package:moimapp/Screens/prac_two.dart';
import 'package:moimapp/Screens/welcome/sign_in.dart';
import 'package:moimapp/helper/constants.dart';
import 'package:moimapp/widgets/highlight_text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PracticeTwo();
                }));
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                  ),
                  Text('스케줄 만들기 시도')
                ],
              )),
          HighlightText(
              text: Constants.myUsername,
              fontStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ],
      ),
    );
  }
}
