import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimapp/widgets/completedTaskList.dart';
import 'package:moimapp/widgets/task.dart';
import 'package:moimapp/widgets/timepicker.dart';
import 'package:moimapp/widgets/todolist.dart';
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
      title: 'Todo App',
      initialRoute: '/',
      routes: {
//        '/': (context) => TodoScaffold(),
//        '/': (context) => TodoScaffold(tasks: tasks, onToggle: onTaskToggled,),
        '/': (context) => DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                  title: const Text('Todo List'),
                  bottom: TabBar(
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
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskContentController = TextEditingController();
  final TextEditingController taskDateTimeController = TextEditingController();

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
              TextField(
                  autofocus: true,
                  controller: taskTitleController,
                  decoration: InputDecoration(
                      labelText: 'Enter your task item name.'
                  )
              ),
              TextField(
                autofocus: true,
                controller: taskContentController,
                decoration: InputDecoration(
                  labelText: 'Describe your task item.'
                )
              ),
              BasicDateTimeField(
                controller:taskDateTimeController,
              ),
            ]
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () async{
          await collection.add({
            'name': taskTitleController.text,
            'content': taskContentController.text,
            'due_time': taskDateTimeController.text,
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
