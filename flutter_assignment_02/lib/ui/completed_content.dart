import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';
import 'package:flutter_assignment_02/ui/todolist_screen.dart';

class Completed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CompletedState();
  }

}

class CompletedState extends State<Completed> {
  TodoProvider _todoStorage = TodoProvider();

  @override
  Widget build(BuildContext context) {

    
    return Container(
      child: FutureBuilder<List<Todo>>(
        future: _todoStorage.getAllCompleted(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          TodoListState.completedList = [];
          if (snapshot.hasData) {
            for (var i in snapshot.data) {
              TodoListState.completedList.add(i);
            }
            return TodoListState.completedList.length != 0 ?
              ListView.builder(
                itemCount: TodoListState.completedList.length,
                itemBuilder: (BuildContext context, int index) {
                  Todo item = TodoListState.completedList[index];
                  return ListTile(
                    title: Text(item.title),
                    trailing: Checkbox(
                      onChanged: (bool done) async {
                        setState( () {
                          item.done = done;
                        });
                        _todoStorage.update(item);
                        this.loadData();
                      },
                      value: item.done,
                    )
                  );
                }
              ): Center(
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

    void loadData() {
      this._todoStorage.getAllTask().then((data) {
        setState(() {
          TodoListState.todoList= data;
        });
      });

      this._todoStorage.getAllCompleted().then((data) {
        setState(() {
          TodoListState.completedList = data;
        });
      });
    }
}