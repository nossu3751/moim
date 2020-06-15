import 'package:flutter/material.dart';
import 'package:moimapp/Screens/schedule.dart';
import 'package:moimapp/Screens/welcome/signup.dart';
import 'package:moimapp/Screens/welcome/welcome_screen.dart';
import 'package:moimapp/Screens/homepage.dart';
import 'package:moimapp/widgets/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SchedulePage(),
    );
  }
}
