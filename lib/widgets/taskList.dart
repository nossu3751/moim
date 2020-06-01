import 'package:flutter/material.dart';
import 'package:moimapp/widgets/task.dart';

List<Task> tasks =  List();

void onTaskCreated(String name){
  tasks.add(Task(name));
}