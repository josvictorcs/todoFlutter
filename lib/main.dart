import 'package:flutter/material.dart';
import 'package:todo/home.dart';

void main() {
  runApp(TodoApp());

}
class TodoApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'To Do',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: ToDoHome()
    );
  }
}

