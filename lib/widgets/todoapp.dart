import 'package:flutter/material.dart';
import 'package:moimapp/widgets/task.dart';
import 'package:moimapp/widgets/taskList.dart';

class TodoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo')
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: tasks[index].getName(),
            );
          }
      )
    );
  }
}