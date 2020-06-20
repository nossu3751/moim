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
import 'package:moimapp/widgets/todo_create_category.dart';

class TodoScaffold extends StatefulWidget{
  @override
  TodoScaffoldState createState() => TodoScaffoldState();
}

class TodoScaffoldState extends State<TodoScaffold>{
  CollectionReference completeTodo;
  CollectionReference incompleteTodo;
  Stream<QuerySnapshot> todoBuilder;

  @override
  void initState(){
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

  Future _todoListRefresh() async{
    todoBuilder = incompleteTodo.orderBy('due_time').snapshots();
  }

//  Widget _todoRefresh(BuildContext context){
//    return RefreshIndicator(
//      onRefresh: () async {
//        setState(() {
//          _todoListRefresh();
//        });
//        Future.delayed(Duration(milliseconds: 1500));
//      },
//      child: StreamBuilder<QuerySnapshot>(
//          stream: todoBuilder,
//          builder: (BuildContext context, AsyncSnapshot snapshot){
//            if(snapshot.hasError){
////          return _errorScaffold(context, snapshot);
//              return Center(
//                  child: Text("StreamBuilder snapshot error")
//              );
//            }else{
//              if(snapshot.connectionState == ConnectionState.done){
//                return Container(
//                    decoration: BoxDecoration(
//                        color: Colors.white
//                    ),
//                    constraints: BoxConstraints.expand(),
//                    child: ListView(
//                      children: snapshot.data.documents.map((DocumentSnapshot document){
//                        if(snapshot.data == null) {
//                          return Text('No data to show');
//                        }else{
//                          return Dismissible(
//                              child: Padding(
//                                padding: EdgeInsets.all(0),
//                                child: Container(
//                                    decoration: BoxDecoration(
//                                      color: Colors.white,
//                                    ),
//                                    height: 90,
//                                    child: Card(
//                                        elevation: 0,
//                                        color: Colors.transparent,
//                                        child: Center(
//                                            child: ListTile(
//                                                title: Text(document['name']),
//                                                trailing: document['due_time'] == null || document['due_time'] == ""?
//                                                Text("not specified", style:TextStyle(color: Colors.grey, fontSize: 10)):
//                                                HighlightText(text:dDay(document['due_time']), fontStyle:TextStyle(color: Colors.grey, fontSize: 10))
//                                            )
//                                        )
//                                    )
//                                ),
//                              ),
//                              key: Key(document.documentID.toString()),
//                              onDismissed: (direction) async {
//
//                                if(direction == DismissDirection.startToEnd){
//                                  await completeTodo.add({
//                                    'name': document['name'],
//                                    'content': document['content'],
//                                    'due_time': "",
//                                    'year': "",
//                                    'month': "",
//                                    'date': "",
//                                    'hour': "",
//                                    'minute': "",
//                                    'completed_on': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString(),
//                                    'completed_weekday': DateFormat("EEEE").format(DateTime.now()).toString()
//                                  });
//                                  await incompleteTodo.document(document.documentID).delete();
//                                }else if(direction == DismissDirection.endToStart){
//                                  await incompleteTodo.document(document.documentID).delete();
//                                }
//                              },
//                              background: Padding(
//                                padding: EdgeInsets.all(0),
//                                child: Container(
//                                  decoration: BoxDecoration(
//                                    borderRadius: new BorderRadius.all(Radius.circular(0)),
//                                    color: Colors.green,
//                                  ),
//                                  child: Icon(Icons.check, color: Colors.white),
//                                ),
//                              ),
//                              secondaryBackground: Padding(
//                                  padding: EdgeInsets.all(0),
//                                  child: Container(
//                                    decoration: BoxDecoration(
//                                      borderRadius: new BorderRadius.all(Radius.circular(0)),
//                                      color: Colors.red,
//                                    ),
//                                    child: Icon(Icons.cancel, color: Colors.white),
//                                  )
//                              )
//                          );
//                        }
//                      }).toList(),
//                    )
//                );
//              }else{
////            return _errorScaffold(context, snapshot);
//                return Center(
//                    child: Text("Streambuilder not connected")
//                );
//              }
//            }
//          }
//      )
//    );
//  }
//
//  Widget _todoListBuilder(BuildContext context){
//    return StreamBuilder<QuerySnapshot>(
//      stream: todoBuilder,
//      builder: (BuildContext context, AsyncSnapshot snapshot){
//        if(snapshot.hasError){
////          return _errorScaffold(context, snapshot);
//          return Center(
//            child: Text("StreamBuilder snapshot error")
//          );
//        }else{
//          if(snapshot.connectionState == ConnectionState.done){
//            return Container(
//                decoration: BoxDecoration(
//                    color: Colors.white
//                ),
//                constraints: BoxConstraints.expand(),
//                child: ListView(
//                  children: snapshot.data.documents.map((DocumentSnapshot document){
//                    if(snapshot.data == null) {
//                      return Text('No data to show');
//                    }else{
//                      return Dismissible(
//                          child: Padding(
//                            padding: EdgeInsets.all(0),
//                            child: Container(
//                                decoration: BoxDecoration(
//                                  color: Colors.white,
//                                ),
//                                height: 90,
//                                child: Card(
//                                    elevation: 0,
//                                    color: Colors.transparent,
//                                    child: Center(
//                                        child: ListTile(
//                                            title: Text(document['name']),
//                                            trailing: document['due_time'] == null || document['due_time'] == ""?
//                                            Text("not specified", style:TextStyle(color: Colors.grey, fontSize: 10)):
//                                            HighlightText(text:dDay(document['due_time']), fontStyle:TextStyle(color: Colors.grey, fontSize: 10))
//                                        )
//                                    )
//                                )
//                            ),
//                          ),
//                          key: Key(document.documentID.toString()),
//                          onDismissed: (direction) async {
//
//                            if(direction == DismissDirection.startToEnd){
//                              await completeTodo.add({
//                                'name': document['name'],
//                                'content': document['content'],
//                                'due_time': "",
//                                'year': "",
//                                'month': "",
//                                'date': "",
//                                'hour': "",
//                                'minute': "",
//                                'completed_on': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString(),
//                                'completed_weekday': DateFormat("EEEE").format(DateTime.now()).toString()
//                              });
//                              await incompleteTodo.document(document.documentID).delete();
//                            }else if(direction == DismissDirection.endToStart){
//                              await incompleteTodo.document(document.documentID).delete();
//                            }
//                          },
//                          background: Padding(
//                            padding: EdgeInsets.all(0),
//                            child: Container(
//                              decoration: BoxDecoration(
//                                borderRadius: new BorderRadius.all(Radius.circular(0)),
//                                color: Colors.green,
//                              ),
//                              child: Icon(Icons.check, color: Colors.white),
//                            ),
//                          ),
//                          secondaryBackground: Padding(
//                              padding: EdgeInsets.all(0),
//                              child: Container(
//                                decoration: BoxDecoration(
//                                  borderRadius: new BorderRadius.all(Radius.circular(0)),
//                                  color: Colors.red,
//                                ),
//                                child: Icon(Icons.cancel, color: Colors.white),
//                              )
//                          )
//                      );
//                    }
//                  }).toList(),
//                )
//            );
//          }else{
////            return _errorScaffold(context, snapshot);
//            return Center(
//              child: Text("Streambuilder not connected")
//            );
//          }
//        }
//      }
//    );
//  }
  Widget _errorScaffold(BuildContext context, AsyncSnapshot snapshot){
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      )
    );
  }

  Widget _todoBuilder(BuildContext context, AsyncSnapshot snapshot){
    return StreamBuilder<QuerySnapshot>(
        stream: todoBuilder,
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
                        await _todoListRefresh();
                        await Future.delayed(Duration(milliseconds: 1500));
                        developer.log("Refreshed");
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
                                      ),
                                      height: 90,
                                      child: Card(
                                          elevation: 0,
                                          color: Colors.transparent,
                                          child: Center(
                                              child: ListTile(
                                                  title: Text(document['name']),
                                                  trailing: document['due_time'] == null || document['due_time'] == ""?
                                                  Text("not specified", style:TextStyle(color: Colors.grey, fontSize: 10)):
                                                  HighlightText(text:dDay(document['due_time']), fontStyle:TextStyle(color: Colors.grey, fontSize: 10))
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
      body: FutureBuilder(
        future:_todoUserSetting(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
//              return _errorScaffold(context, snapshot);
              return Center(
                child: Text("future builder snapshot error")
              );
            }
            return _todoBuilder(context, snapshot);
          }
//          return _errorScaffold(context, snapshot);
          return Center(
            child: Text("no connection")
          );
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
//            onTap: () => Navigator.pushNamed(context, '/create_category')
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TodoCreateCategory()
              )
            )
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
  );
}