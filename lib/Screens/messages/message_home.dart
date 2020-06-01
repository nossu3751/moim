import "package:flutter/material.dart";
import 'package:moimapp/Screens/welcome/welcome_screen.dart';
import 'package:moimapp/services/auth.dart';

class MessageHome extends StatefulWidget {
  @override
  _MessageHomeState createState() => _MessageHomeState();
}

class _MessageHomeState extends State<MessageHome> {
  AuthMethods authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.chevron_left),
        //   onPressed: () => Navigator.pop(context, false),
        // ),
        backgroundColor: Colors.white,
        title: Text('Messages'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      // body:
    );
  }
}
