import 'package:flutter/material.dart';
import 'package:moimapp/Screens/messages/message_home.dart';
import 'package:moimapp/Screens/welcome/signup.dart';
import 'package:moimapp/Screens/welcome/welcome_screen.dart';
import 'package:moimapp/Screens/homepage.dart';
import 'package:moimapp/helper/helperfunctions.dart';
import 'package:moimapp/widgets/todo.dart';

void main() {
  runApp(MyApp());
}

// check if the user is logged in or not when she opens the app
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLogInPreference().then((val) {
      setState(() {
        userLoggedIn = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userLoggedIn ? MessageHome() : WelcomeScreen(),
    );
  }
}
