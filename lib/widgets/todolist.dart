import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:moimapp/helper/helperfunctions.dart';
import 'package:moimapp/widgets/d_date_calculator.dart';
import 'package:moimapp/widgets/highlight_text.dart';
import 'package:moimapp/widgets/task.dart';
import 'package:moimapp/widgets/custom_expansion_tile.dart';
import 'dart:developer' as developer;

import 'package:moimapp/widgets/todo.dart';

class TodoScaffold extends StatefulWidget{
//  final List<Task> tasks;
//  final onToggle;
//  final collection = Firestore.instance.collection('rhosung_tasks');
//  final completedCollection = Firestore.instance.collection('rhosungCompletedTasks');

//  TodoScaffold({@required this.tasks, @required this.onToggle});

  @override
  TodoScaffoldState createState() => TodoScaffoldState();
}

class TodoScaffoldState extends State<TodoScaffold>{
  CollectionReference completeTodo;
  CollectionReference incompleteTodo;
  Stream<QuerySnapshot> todoBuilder;

  @override
  void initState(){
//    _todoUserSetting();
    super.initState();
  }

  Future _todoUserSetting() async {
    String collegeName = await HelperFunctions.getUserCollegePreference();
    String userEmail = await HelperFunctions.getUserEmailPreference();
    String firstName = await HelperFunctions.getUserFirstNamePreference();
    String name = await HelperFunctions.getUserNamePreference();

    developer.log(collegeName);
    developer.log(userEmail);
    developer.log(firstName);
    developer.log(name);

    completeTodo = Firestore.instance.collection(collegeName)
        .document('path')
        .collection('users')
        .document(userEmail)
        .collection('completeTasks');
    incompleteTodo = Firestore.instance.collection(collegeName)
        .document('path')
        .collection('users')
        .document(userEmail)
        .collection('incompleteTasks');

    String isNull = incompleteTodo == null ? "this is null":"this has data";
    developer.log(isNull);
    todoBuilder = incompleteTodo.orderBy('due_time').snapshots();
  }

  Widget _errorScaffold(BuildContext context, AsyncSnapshot snapshot){
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      )
    );
  }

  Widget _todoBuilder(BuildContext context, AsyncSnapshot snapshot){
    return StreamBuilder<QuerySnapshot>(
      // list is ordered by due time
        stream: todoBuilder,
//        stream: incompleteTodo != null? incompleteTodo.orderBy('due_time').snapshots():widget.collection.orderBy('due_time').snapshots(),
//        stream: widget.collection.orderBy('due_time').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
              return Container(
                  child: Center(
                      child: CircularProgressIndicator()
                  )
              );
            default:
              return Container(
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  constraints: BoxConstraints.expand(),
                  child: RefreshIndicator(
                      onRefresh: () async{
                        await Future.delayed(Duration(milliseconds: 1500));
                        return null;
                      },
                      child: ListView(
                        children: snapshot.data.documents.map((DocumentSnapshot document){
                          if(snapshot.data == null) {
                            return Text('No data to show');
                          }else{
                            return Dismissible(
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
//                                    color: dDay(document['due_time']) == "overdue" ? Colors.redAccent: Colors.white,
                                      ),
                                      height: 90,
                                      child: Card(
                                          elevation: 0,
                                          color: Colors.transparent,
//                                      shape: RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.circular(0)
//                                      ),
                                          child: Center(
                                              child: ListTile(
                                                  title: Text(document['name']),
                                                  trailing: document['due_time'] == null || document['due_time'] == ""?
                                                  Text("not specified", style:TextStyle(color: Colors.grey, fontSize: 10)):
                                                  HighlightText(text:dDay(document['due_time']), fontStyle:TextStyle(color: Colors.grey, fontSize: 10))
//                                              trailing: Text(
////                                              document['due_time'] != null && document['due_time'] != ""?
////                                              document['due_time']:"not specified",
//                                                document['due_time'] != null && document['due_time'] != "" ?
//                                                (dDay(document['due_time'])):"not specified",
//                                                style: TextStyle(color: Colors.grey, fontSize: 10),
//                                              )
                                              )
                                          )
                                      )
                                  ),
                                ),
                                key: Key(document.documentID.toString()),
                                onDismissed: (direction) async {

                                  if(direction == DismissDirection.startToEnd){
                                    await completeTodo.add({
                                      'name': document['name'],
                                      'content': document['content'],
                                      'due_time': "",
                                      'year': "",
                                      'month': "",
                                      'date': "",
                                      'hour': "",
                                      'minute': "",
                                      'completed_on': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString(),
                                      'completed_weekday': DateFormat("EEEE").format(DateTime.now()).toString()
                                    });
                                    await incompleteTodo.document(document.documentID).delete();
                                  }else if(direction == DismissDirection.endToStart){
                                    await incompleteTodo.document(document.documentID).delete();
                                  }
                                },
                                background: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.all(Radius.circular(0)),
                                      color: Colors.green,
                                    ),
                                    child: Icon(Icons.check, color: Colors.white),
                                  ),
                                ),
                                secondaryBackground: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: new BorderRadius.all(Radius.circular(0)),
                                        color: Colors.red,
                                      ),
                                      child: Icon(Icons.cancel, color: Colors.white),
                                    )
                                )
//                        onDismissed:(direction){
//                          setState(() async{
//                            await widget.collection.document(document.documentID).delete();
//                          });
//                        }
                            );
                          }
                        }).toList(),
                      )
                  )
              );
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
//      body: incompleteTodo != null?
      body: FutureBuilder(
        future:_todoUserSetting(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return _errorScaffold(context, snapshot);
            }
            return _todoBuilder(context, snapshot);
          }
          return _errorScaffold(context, snapshot);
        },
      ),
      floatingActionButton: SpeedDial(
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.note_add, color: Colors.lightBlueAccent),
              backgroundColor: Colors.white,
              label: 'Add Item',
              labelStyle: TextStyle(fontSize: 18.0),
//              onTap: () => Navigator.pushNamed(context, '/create')
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TodoCreate()),
              )
          ),
          SpeedDialChild(
            child: Icon(Icons.library_add, color: Colors.lightBlueAccent),
            backgroundColor: Colors.white,
            label: 'Add Category',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Navigator.pushNamed(context, '/create_category')
          ),
          SpeedDialChild(
            child: Icon(Icons.share, color: Colors.lightBlueAccent),
            backgroundColor: Colors.white,
            label: 'Share',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ]

      )
//      floatingActionButton: FloatingActionButton(
//        elevation: 0,
//          onPressed: () => Navigator.pushNamed(context, '/create'),
//          child: Icon(Icons.add)
//      ),

  );
}