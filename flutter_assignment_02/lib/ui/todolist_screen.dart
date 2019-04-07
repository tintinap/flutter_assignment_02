import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';
import 'package:flutter_assignment_02/ui/completed_content.dart';
import 'package:flutter_assignment_02/ui/task_content.dart';

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
  List<Widget> _content = [Task(), Completed()];


  @override
  Widget build(BuildContext context) {

     final List icons = <Widget>[
      IconButton(
          icon: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, "/addTask");
            },
          ),
      IconButton(
          icon: Icon(Icons.delete),
          onPressed: () async {
            for(var item in completedList){
              print(item.id);
              await _todoStorage.delete(item.id);
            }
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

      body: _content[_currentIndex],

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
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      
    );
  }

}
