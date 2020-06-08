import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoListBuilder extends StatefulWidget{
  final AsyncSnapshot<QuerySnapshot> snapshot;
  TodoListBuilder({@required this.snapshot});
  @override
  TodoListBuilderState createState() => TodoListBuilderState();
}

class TodoListBuilderState extends State<TodoListBuilder>{
  @override
  Widget build(BuildContext context) {
    return null;
  }
}

List<String> completedTaskListBuilder (CollectionReference firebaseCollection, List<String> list) {
  firebaseCollection.getDocuments().then((snapshot) {
    for(DocumentSnapshot doc in snapshot.documents){
      list.add(doc['name']);
    }
  });
  return list;
}
