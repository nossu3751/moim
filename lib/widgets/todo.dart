import 'package:flutter/material.dart';

import 'custom_card.dart';

class TodoList extends StatefulWidget{
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        }
      ),
      body: ListView.separated(
        itemCount: 5,

        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index){
          return CustomCard(
            title: "hello",
            subtitle: "$index",
            imageURL: "",
          );
        }
      )
    );
  }
}