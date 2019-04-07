import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar :AppBar(
        title: Text('Todo'),
        actions: <IconButton>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => AddTaskPage(_updateList),
                  ));
            },
          ),
        ],
      )
    );
  }

}
