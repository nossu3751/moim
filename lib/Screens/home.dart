import 'package:flutter/material.dart';
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
          HighlightText(
              text: Constants.myUsername,
              fontStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ],
      ),
    );
  }
}
