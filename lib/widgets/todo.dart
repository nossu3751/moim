import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimapp/widgets/calender_height_calculator.dart';
import 'package:moimapp/widgets/completedTaskList.dart';
import 'package:moimapp/widgets/task.dart';
import 'package:moimapp/widgets/timepicker.dart';
import 'package:moimapp/widgets/todo_create_category.dart';
import 'package:moimapp/widgets/todolist.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';


import 'package:moimapp/widgets/d_date_calculator.dart';
import 'package:moimapp/widgets/todolist_builder.dart';
import 'custom_card.dart';


class Todo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TodoState();
}

class TodoState extends State<Todo> {
  final List<Task> tasks = [];

  void onTaskCreated(String name){
    setState(() {
      tasks.add(Task(name));
    });
  }

  void onTaskToggled(Task task){
    setState((){
      task.setCompleted(!task.isCompleted());
    });
  }


  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      initialRoute: '/',
      routes: {
//        '/': (context) => TodoScaffold(),
//        '/': (context) => TodoScaffold(tasks: tasks, onToggle: onTaskToggled,),
        '/': (context) => DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    tooltip: "Back",
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  elevation: 0,
//                  title: const Text('Todo List'),
                  title: Image.asset('assets/images/moim_white.png', fit: BoxFit.fitHeight, height: 35),
                  bottom: TabBar(
                      indicatorColor: Color(0XFFFFF684),
                      tabs: <Widget> [
                        Tab(
                            text: "Tasks",
                            icon: Icon(Icons.note)
                        ),
                        Tab(
                            text: "Complete",
                            icon: Icon(Icons.check)
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
        ),
        '/create': (context) => TodoCreate(onCreate: onTaskCreated,),
        '/create_category': (context) => TodoCreateCategory(),
      },
  );
}
class TodoPractice extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Todo();
}

class TodoCreate extends StatefulWidget{
  final onCreate;
  TodoCreate({@required this.onCreate});
  @override
  _TodoCreateState createState() => _TodoCreateState();
}

class _TodoCreateState extends State<TodoCreate>{
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
  GlobalKey<AutoCompleteTextFieldState<String>> taskkey = new GlobalKey();

//  @override
//  void initState(){
//    super.initState();
//    completedCollection.getDocuments().then((snapshot) async {
//      for(DocumentSnapshot doc in snapshot.documents){
//        await completedTaskTitle.add(doc['name']);
//      }
//    });
//  }
//
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create a task')),
      body: Center(
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
//              TextField(
//                  autofocus: true,
//                  controller: taskTitleController,
//                  decoration: InputDecoration(
//                      labelText: 'Enter your task item name.'
//                  )
//              ),
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
          await collection.add({
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
//class TodoList extends StatefulWidget{
//  @override
//  _TodoListState createState() => _TodoListState();
//}
//
//class _TodoListState extends State<TodoList> {
//
//  void onTaskCreated(String name){
//    setState(() {
//      tasks.add(Task(name));
//    });
//  }
//
//  String input = "";
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context){
//    return Scaffold(
//      appBar: AppBar(
//        elevation: 0,
//        title: Text("Todo List"),
//      ),
//      floatingActionButton: _fabButton,
//      body: ListView.builder(
//
//          itemCount: tasks.length,
//          itemBuilder: (context,index) {
//            return ListTile(
//              title: Text(tasks[index].getName())
//            );
//          },
////        itemBuilder: (context, index) => Dismissible(
////          direction: DismissDirection.startToEnd,
////          onDismissed: (direction){
////            setState(() {
////              todos.removeAt(index);
////            });
////          },
////          key: Key(todos[index].getName()),
////          child: CustomCard(
////            title: todos[index].getName(),
////          ),
//
//        )
//      );
//
//  }
//
//  Widget get _fabButton => FloatingActionButton(
//    elevation: 0,
//    onPressed: () => Navigator.pushNamed(
//      context,
//      '/create'
//    ),
////      onPressed: () {
////        showDialog(
////          context: context,
////          builder: (BuildContext context){
////            return AlertDialog(
////              shape: RoundedRectangleBorder(
////                borderRadius:BorderRadius.all(Radius.circular(20))
////              ),
////              title: Text("Add Todo-item"),
////              content: TextField(
////                onChanged: (String value) {
////                  input = value;
////                }
////              ),
////              actions: <Widget>[
////                FlatButton(
////                  child: Text("Add"),
////                  onPressed: (){
////                    setState((){
////                      todos.add(input);
////                    });
////                    Navigator.of(context).pop();
////                  },
////                )
////              ]
////            );
////
////          }
////        );
////      },
//      child: Icon(Icons.add)
//  );
//}
