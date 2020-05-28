import 'package:flutter/material.dart';

import 'custom_card.dart';

class TodoList extends StatefulWidget{
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List todos = List();
  String input = "";
  @override
  void initState() {
    super.initState();
    todos.add("Item1");
    todos.add("Item2");
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      floatingActionButton: _fabButton,
      body: ListView.builder(

        itemCount: todos.length,
        itemBuilder: (context, index) => Dismissible(
          direction: DismissDirection.startToEnd,
          onDismissed: (direction){
            setState(() {
              todos.removeAt(index);
            });
          },
          key: Key(todos[index]),
          child: CustomCard(
            title: todos[index],
            subtitle: "$index",
            imageURL: "",
          ),

        )
      )
    );
  }

  Widget get _fabButton => FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.all(Radius.circular(20))
              ),
              title: Text("Add Todo-item"),
              content: TextField(
                onChanged: (String value) {
                  input = value;
                }
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Add"),
                  onPressed: (){
                    setState((){
                      todos.add(input);
                    });
                    Navigator.of(context).pop();
                  },
                )
              ]
            );

          }
        );
      },
      child: Icon(Icons.add)
  );
}