import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimapp/helper/helperfunctions.dart';
import 'package:moimapp/widgets/calender_height_calculator.dart';
import 'package:moimapp/widgets/completedTaskList.dart';
import 'package:moimapp/widgets/task.dart';
import 'package:moimapp/widgets/timepicker.dart';
import 'package:moimapp/widgets/todo_create_category.dart';
import 'package:moimapp/widgets/todolist.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:developer' as developer;


import 'package:moimapp/widgets/d_date_calculator.dart';
import 'package:moimapp/widgets/todolist_builder.dart';
import 'custom_card.dart';

class TodoPath extends StatefulWidget{
  @override
  TodoPathState createState() => TodoPathState();
}

class TodoPathState extends State<TodoPath>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.lightBlue,
              elevation: 0,
              title: Image.asset('assets/images/moim_white.png', fit: BoxFit.fitHeight, height: 35),
              bottom: TabBar(
                  indicatorColor: Color(0XFFFFF684),
                  tabs: <Widget> [
                    Tab(
                        text: "Tasks",
                        icon: Icon(Icons.note, color: Colors.white)
                    ),
                    Tab(
                        text: "Complete",
                        icon: Icon(Icons.check, color: Colors.white)
                    )
                  ]
              )
          ),
          body: TabBarView(
              children: <Widget> [
                TodoScaffold(),
                CompletedTasksList()
              ]
          )
      )
    );
  }
}


class TodoCreate extends StatefulWidget{
  final onCreate;
  TodoCreate({@required this.onCreate});
  @override
  _TodoCreateState createState() => _TodoCreateState();
}

class _TodoCreateState extends State<TodoCreate>{
  CollectionReference completeTodo;
  CollectionReference incompleteTodo;
  CollectionReference todoCategory;

  List<String> todoCategoryList = [];

  final collection = Firestore.instance.collection('rhosung_tasks');
  final completedCollection = Firestore.instance.collection('rhosungCompletedTasks');
  final taskCategory = Firestore.instance.collection('rhosungTasksCategories');
  final TextEditingController taskTestController = TextEditingController();
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskContentController = TextEditingController();
  final TextEditingController taskDateTimeController = TextEditingController();
  AutoCompleteTextField searchTextField;
  static List<String> completedTaskTitle;
  static List<String> tasksCategory;
  var selectedCategory;

//  @override
  void initState() {
//    completedTaskTitle = completedTaskListBuilder(completedCollection, completedTaskTitle);
    super.initState();
    completedTaskTitle = [];
//    completedTaskTitle = completedTaskListBuilder(completedCollection, completedTaskTitle);
    tasksCategory = ["a","b","c","d"];

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
    todoCategory = Firestore.instance.collection(collegeName)
        .document('path')
        .collection('users')
        .document(userEmail)
        .collection('todoCategory');

    todoCategory.getDocuments().then((snapshot){
        for(DocumentSnapshot document in snapshot.documents){
          todoCategoryList.add(document.documentID);
        }
      }
    );

    String isNull = incompleteTodo == null ? "this is null":"this has data";
    developer.log(isNull);

    developer.log(todoCategoryList.length.toString());
    for(String s in todoCategoryList){
      developer.log(s);
    }
  }

  GlobalKey<AutoCompleteTextFieldState<String>> taskkey = new GlobalKey();

  Widget row(String str){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          str,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0
        ),
      ]
    );
  }

  Widget _todoForm(BuildContext context, AsyncSnapshot snapshot){
    return Center(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  searchTextField = AutoCompleteTextField<String>(
                    clearOnSubmit: false,
                    itemSubmitted: (item){
                      setState((){
                        searchTextField.textField.controller.text = item;
                      });
                    },
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    key: taskkey,
                    suggestions: completedTaskListBuilder(completedCollection, completedTaskTitle),
                    itemBuilder: (context, item){
                      return row(item);
                    },
                    itemSorter: (a,b){
                      return a.compareTo(b);
                    },
                    itemFilter: (item, query){
                      return item.toLowerCase().startsWith(query.toLowerCase());
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter your task item name.'
                    ),
                  ),
//
                  TextField(
                      autofocus: false,
                      controller: taskContentController,
                      decoration: InputDecoration(
                          labelText: 'Describe your task item.'
                      )
                  ),
                  BasicDateTimeField(
                    controller:taskDateTimeController,
                  ),
                  DropdownButton(
                    items: tasksCategory.map((value)=>
                        DropdownMenuItem(
                          child: Text(
                              value,
                              style: TextStyle(
                                  color: Colors.black
                              )
                          ),
                          value: value,
                        )
                    ).toList(),
                    onChanged: (selectedTasksCategory){
                      setState(() {
                        selectedCategory = selectedTasksCategory;
                      });
                    },
                    value: selectedCategory,
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    focusColor: Colors.lightBlue,
                    hint: Text(
                        "Select Category"
                    ),

                  ),
                  SizedBox(height: 40.0)
                ]
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Create a task')),
        body: FutureBuilder(
          future: _todoUserSetting(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                return Center(
                  child: CircularProgressIndicator()
                );
              }
              return _todoForm(context, snapshot);
            }
            return Center(
                child: CircularProgressIndicator()
            );
          }
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.done),
            onPressed: () async{
              DateTime dueTime = taskDateTimeController.text == ""?null:DateTime.parse(taskDateTimeController.text);
//          DateTime rightNow = DateTime.now();
//          String difference = dueTime.difference(rightNow).inDays.toString();
              String year = dueTime == null?"":dueTime.year.toString();
              String month = dueTime == null?"":dueTime.month.toString();
              String date = dueTime == null?"":dueTime.day.toString();
              String hour = dueTime == null?"":dueTime.hour.toString();
              String minute = dueTime == null?"":dueTime.minute.toString();
              await incompleteTodo.add({
                'name': searchTextField.textField.controller.text,
                'content': taskContentController.text,
                'due_time': taskDateTimeController.text,
                'category': selectedCategory,
                'year':year,
                'month': month,
                'date': date,
                'hour': hour,
                'minute': minute,
              });

              Navigator.pop(context);
            }
        )
    );
  }
}
