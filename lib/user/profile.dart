import 'package:flutter/material.dart';
import 'package:moimapp/helper/helperfunctions.dart';

class UserPage extends StatefulWidget{
  @override
  UserPageState createState() => UserPageState();
}

class UserPageState extends State<UserPage>{
  String userName;
  String userEmail;
  String collegeName;

  Future _infoInit() async {
    userName = await HelperFunctions.getUserNamePreference();
    userEmail = await HelperFunctions.getUserEmailPreference();
    collegeName = await HelperFunctions.getUserCollegePreference();
  }

  Widget userScaffold(BuildContext context, AsyncSnapshot snapshot){
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
              userName
          ),
          backgroundColor: Colors.lightBlue,
        ),
        body:Center(
            child: Text("This is User Page")
        )
    );
  }

  Widget _errorScaffold(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text(
          "this is body"
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _infoInit(),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return _errorScaffold(context);
            }
            return userScaffold(context, snapshot);
          }
          return Center(
            child: CircularProgressIndicator()
          );
        }
    );
  }
}


