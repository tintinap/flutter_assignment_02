import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';
import 'package:flutter_assignment_02/ui/completed_content.dart';
import 'package:flutter_assignment_02/ui/task_content.dart';
import 'package:flutter_assignment_02/ui/temp_content.dart';

class TodoListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return TodoListState();
  }
}

class TodoListState extends State<TodoListScreen> {
  static List<Todo> todoList = [];
  static List<Todo> completedList = [];
  TodoProvider _todoStorage = TodoProvider();
  int _currentIndex = 0;
  List<Widget> _content = [Task(), Completed(), Temp()];
  static int temp = 0;


  @override
  Widget build(BuildContext context) {
     _todoStorage.open('todo.db');
     final List icons = <Widget>[
      IconButton(
          icon: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, "/addTask");
            temp = 0;
            },
          ),
      IconButton(
          icon: Icon(Icons.delete),
          onPressed: () async {
            await _todoStorage.delAllDone();
            temp = 1;
            setState(() {
              completedList = [];
            });
          },
      ),
    ];

    return Scaffold(
      appBar :AppBar(
        title: Text('Todo'),
        actions: <Widget>[ 
          _currentIndex == 0 ? icons[0] : icons[1],
        ],
      ),

      body: temp != 1 ? _content[_currentIndex] : _content[2],

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          //sets the background color of bottomNavigationBar
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem( icon: Icon(Icons.list), title: Text("Task"),),
            BottomNavigationBarItem( icon: Icon(Icons.check), title: Text("Completed"),),
          ],

          fixedColor: Colors.blue,
          currentIndex: _currentIndex,
          onTap: (int index) {
            temp = 0;
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      
    );
  }

}
