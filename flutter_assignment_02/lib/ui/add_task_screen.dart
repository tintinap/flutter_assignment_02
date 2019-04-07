import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/ui/todolist_screen.dart';
import '../model/todo.dart';

class AddTaskScreen extends StatefulWidget {
  

  @override
  State<StatefulWidget> createState() {
    return AddTask();
  }

}

class AddTask extends State<AddTaskScreen> {
  final TodoProvider _todoStorage = TodoProvider();
  final TextEditingController _subjectController = TextEditingController();
  final  _formkey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    _todoStorage.open('todo.db');
    return Scaffold(
      appBar : AppBar(
        title: Text("New Subject"),
      ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: 'Subject'),
                  controller: _subjectController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill subject';
                    }
                  },
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      Todo data = Todo();
                      data.title = _subjectController.text;
                      data.done = false;
                      print('going to insert '+ _subjectController.text);
                      await  _todoStorage.insert(data);
                    //   TodoListState.todoList.add(data);
                      print('added data');
                      Navigator.pop(context);
                    }
                  }
                )
              ],
            ),
          ),
        // ]
      ),
    );
  }

}


