import 'package:flutter/material.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Widgets/icon_button.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:moimapp/Screens/schedule.dart';
import 'package:moimapp/Screens/welcome/sign_in.dart';
import 'package:moimapp/helper/constants.dart';
import 'package:moimapp/helper/helperfunctions.dart';
import 'package:moimapp/justin_main.dart';
import 'package:moimapp/presentation/moim_icons.dart';
import 'package:moimapp/widgets/todo.dart';
import 'package:moimapp/services/auth.dart';

import '../calculator.dart';
import 'messages/message_home.dart';

//

class Home extends StatelessWidget{
  final AuthMethods authMethods = new AuthMethods();
  void _showUserInfo(BuildContext context, String userEmail, String userCollege){
    showDialog(
        context: context,
        builder:(context){
          return AlertDialog(
            title: Text("User Info"),
            content: Column(
              children: <Widget>[
                Text(userEmail),
                Text(userCollege),
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                onPressed: () {
                  authMethods.signOut();
                  HelperFunctions.saveUserLogInPreference(false);
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => SignIn()));
                },
              ),
              FlatButton(
                child: Text("Close"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ]
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/moim_white.png', fit: BoxFit.fitHeight, height: 35),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.black,
          ),
          onPressed: () {
            authMethods.signOut();
            HelperFunctions.saveUserLogInPreference(false);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignIn()));
          },
        ),
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          GestureDetector(
//            child: Image.asset('assets/images/moim_profile.png',fit: BoxFit.contain, height: 35),
            onTap: () async{
              String userCollege = await HelperFunctions.getUserCollegePreference();
              String userEmail = await HelperFunctions.getUserEmailPreference();
              _showUserInfo(context,userEmail,userCollege);
            },
            child: Icon(Moim.profile_icon, color: Colors.white, size: 60)
          )
        ],
      ),
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
                            MaterialPageRoute(builder: (context) => TodoPath()),
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
  AuthMethods authMethods = new AuthMethods();
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
//          leading: IconButton(
//            icon: Icon(
//              Icons.exit_to_app,
//              color: Colors.black,
//            ),
//            onPressed: () {
//              authMethods.signOut();
//              HelperFunctions.saveUserLogInPreference(false);
//              Navigator.pushReplacement(
//                  context, MaterialPageRoute(builder: (context) => SignIn()));
//            },
//          ),
//          actions: <Widget>[
//            // action button
//            IconButton(
//              icon: Icon(
//                Icons.person_outline,
//                color: Colors.black,
//              ),
//              onPressed: () {
//                {}
//              },
//            ),
//            IconButton(
//              icon: Icon(
//                Icons.search,
//                color: Colors.black,
//              ),
//              onPressed: () {
//                {
//                  print(Constants.myUsername);
//                }
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
        body: isLoading
            ? Center(child: Container(child: CircularProgressIndicator()))
            : _children[_currentIndex],
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
//        body: _children[_currentIndex],
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
              icon: Icon(Moim.home_icon_01),
              title: Text(
                'Home',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Moim.community_icon__1_),
              title: Text(
                'Feed',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Moim.calendar_icon_01),
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
