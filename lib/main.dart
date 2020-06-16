import 'package:flutter/material.dart';
import 'package:moimapp/Screens/welcome/sign_in.dart';
import 'package:moimapp/helper/helperfunctions.dart';
import 'package:moimapp/Screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
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
      home: userLoggedIn ? MyHomePage() : SignIn(),
    );
  }
}
