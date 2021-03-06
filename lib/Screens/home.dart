import 'package:flutter/material.dart';
import 'package:moimapp/Screens/prac.dart';
import 'package:moimapp/Screens/height_schedule_builder.dart';
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
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hey ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            HighlightText(
                text: Constants.myFirstname,
                fontStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            SizedBox(
              height: 60,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HeightScheduleBuilder();
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
          ],
        ),
      ),
    );
  }
}
