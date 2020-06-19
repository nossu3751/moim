import 'package:flutter/material.dart';
import 'package:moimapp/Screens/messages/message_home.dart';
import 'package:moimapp/Screens/welcome/sign_in.dart';
import 'package:moimapp/helper/helperfunctions.dart';
import 'package:moimapp/Screens/schedule.dart';
import 'package:moimapp/Screens/welcome/sign_up.dart';

//import 'package:moimapp/Screens/welcome/welcome_screen.dart';
import 'package:moimapp/Screens/homepage.dart';
import 'package:moimapp/widgets/completedTaskList.dart';
import 'package:moimapp/widgets/taskList.dart';
import 'package:moimapp/widgets/todo.dart';
import 'package:moimapp/widgets/todo_create_category.dart';
import 'package:moimapp/widgets/todolist.dart';

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

  Future getLog () async {
    userLoggedIn = await HelperFunctions.getUserLogInPreference();
  }

//  getLoggedInState() async {
//    await HelperFunctions.getUserLogInPreference().then((val) {
//      setState(() {
//        userLoggedIn = val;
//      });
//    });
//  }

  Widget _errorMessage(BuildContext context, AsyncSnapshot snapshot) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
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
      home: FutureBuilder(
        future: getLog(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return _errorMessage(context, snapshot);
            }
            return userLoggedIn ? MyHomePage() : SignIn();
          }
          return _errorMessage(context, snapshot);
        },
      ),
//      initialRoute: userLoggedIn? '/': '/signIn',
//      routes: {
////        '/': (context) => TodoScaffold(),
////        '/': (context) => TodoScaffold(tasks: tasks, onToggle: onTaskToggled,),
//        '/todo': (context) => DefaultTabController(
//            length: 2,
//            child: Scaffold(
//                appBar: AppBar(
//                    leading: IconButton(
//                      icon: Icon(Icons.arrow_back),
//                      iconSize: 30.0,
//                      tooltip: "Back",
//                      onPressed: () {
//                        Navigator.pop(context, true);
//                      },
//                    ),
//                    elevation: 0,
////                  title: const Text('Todo List'),
//                    title: Image.asset('assets/images/moim_white.png', fit: BoxFit.fitHeight, height: 35),
//                    bottom: TabBar(
//                        indicatorColor: Color(0XFFFFF684),
//                        tabs: <Widget> [
//                          Tab(
//                              text: "Tasks",
//                              icon: Icon(Icons.note)
//                          ),
//                          Tab(
//                              text: "Complete",
//                              icon: Icon(Icons.check)
//                          )
//                        ]
//                    )
//                ),
//                body: TabBarView(
//                    children: <Widget> [
//                      TodoScaffold(),
//                      CompletedTasksList()
//                    ]
//                )
//            )
//        ),
//        '/create': (context) => TodoCreate(onCreate: onTaskCreated,),
//        '/create_category': (context) => TodoCreateCategory(),
//        '/signIn': (context) => SignIn(),
//        '/': (context) => MyHomePage(),
//      },
//
      //home: SchedulePage(),
    );
  }
}
