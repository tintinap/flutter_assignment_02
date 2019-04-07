import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';
import 'package:flutter_assignment_02/ui/todolist_screen.dart';

class Task extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskState();
  }

}

class TaskState extends State<Task> {
  TodoProvider _todoStorage = TodoProvider();

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: FutureBuilder<List<Todo>>(
        future: _todoStorage.getAllTask(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          TodoListState.todoList = [];
          if (snapshot.hasData) {
            for (var i in snapshot.data) {
              TodoListState.todoList.add(i);
            }
          return TodoListState.todoList.length != 0 ?
            ListView.builder(
              itemCount: TodoListState.todoList.length,
              itemBuilder: (BuildContext context, int index) {
                Todo item = TodoListState.todoList[index];
                return ListTile(
                  title: Text(item.title),
                  trailing: Checkbox(
                    onChanged: (bool done) async {
                        setState(() {
                          item.done = done;
                        });
                        _todoStorage.update(item);
                      },
                    value: item.done,
                  ),
                );
              }
            ): Center (
              child: Text("No Data Found.."),
            );


          } else {
              return Center(
                child: Text("No Data Found.."),
              );
          }
        }
      )
    );

  }

}