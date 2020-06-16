import 'package:flutter/material.dart';

class TodoCreateCategory extends StatefulWidget{
  @override
  TodoCreateCategoryState createState() => TodoCreateCategoryState();
}

class TodoCreateCategoryState extends State<TodoCreateCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Create a task')),
        body: Text("this is category creation section")
    );
  }
}