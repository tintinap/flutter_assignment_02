import 'package:flutter/material.dart';
import './gui/todolist_screen.dart';


void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      initialRoute: "/",
      routes : {
        "/" : (context) => TodoListScreen(),
      }
    );
  }
}


