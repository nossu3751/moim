import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moimapp/widgets/dateTimePicker.dart';
import 'package:moimapp/widgets/highlight_text.dart';
import 'package:moimapp/widgets/icon_button.dart';
import 'package:moimapp/widgets/round_button.dart';
import 'package:moimapp/widgets/taskList.dart';
import 'package:moimapp/widgets/timepicker.dart';
import 'package:moimapp/widgets/todo.dart';
import 'package:moimapp/widgets/todoapp.dart';
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: appName,
  home: Todo(),
  theme: ThemeData.light().copyWith(
      inputDecorationTheme:
      InputDecorationTheme(border: OutlineInputBorder()),
      dividerColor: Colors.transparent
  ),
  localizationsDelegates: [
//     ... app-specific localization delegate[s] here
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('en'), // English
    const Locale('es'), // Spanish
    const Locale('fr'), // French
    const Locale('zh'), // Chinese
  ],
));
//void main() {
//  runApp(TimeHomePage());
//}
//
//class MyApp extends StatelessWidget {
//
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: DateTimePicker(),
//      routes:{
//        '/create': (context) => TodoCreate(onCreate:onTaskCreated,),
//      }
//    );
//  }
//}
//
//class MyHomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.lightBlue[100],
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
//            IconButton(
//              icon: Icon(
//                Icons.notifications,
//                color: Colors.black,
//              ),
//              onPressed: () {
//                {}
//                ;
//              },
//            ),
//          ],
//        ),
//        body: Container(
//          alignment: Alignment.center,
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              HighlightText(
//                  text: 'Write a Post .',
//                  fontStyle:
//                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
//              SizedBox(height: 20),
//              RoundedButton(
//                text: 'Submit',
//                fontColor: Colors.grey[900],
//              ),
//              SizedBox(height: 20),
//              RoundIconButton(
//                icon: Icon(
//                  Icons.edit,
//                  color: Colors.grey[900],
//                ),
//              ),
//            ],
//          ),
//        ),
//        bottomNavigationBar: BottomNavigationBar(
//          items: [
//            BottomNavigationBarItem(
//              icon: Icon(Icons.home),
//              title: Text('Home'),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.question_answer),
//              title: Text('Feed'),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.calendar_today),
//              title: Text('Schedule'),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.more_horiz),
//              title: Text('More'),
//            ),
//          ],
//          type: BottomNavigationBarType.fixed,
//          selectedItemColor: Colors.black,
//          unselectedItemColor: Colors.black,
//          showSelectedLabels: false,
//          showUnselectedLabels: false,
//        ));
//  }
//}
