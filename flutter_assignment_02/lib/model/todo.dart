import 'package:sqflite/sqflite.dart';

final String tableToDo = 'todo';
final String columnID = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

class Todo {
  int _id;
  String _title;
  bool _done;

  Todo({String title}) {
    this._title = title;
    this._done = false;
  }

  Todo.formMap(Map<String, dynamic> map) {
    _id = map[columnID];
    _title = map[columnTitle];
    _done = map[columnDone] == 1;
  }

  int get id {
    return this._id;
  }

  set id(int id) {
    this._id = id;
  }
  
  String get title => this._title;
  set title(String title) => this._title = title;

  bool get done => this._done;
  set done(bool done) => this._done = done;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnTitle: _title,
      columnDone: _done? 1 : 0,
    };

    if (_id != null) {
      map[columnID] = _id;
    }

    return map;
  }
}

// new Todo ProviderClass
class TodoProvider {
  Database _db;

  Future open(String path) async {
    print("on open function");
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
        await db.execute('''
          create table $tableToDo (
            $columnID integer primary key autoincrement,
            $columnTitle text not null,
            $columnDone integer not null
          )
        ''');
    });
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await _db.insert(
      tableToDo, 
      todo.toMap());
    return todo;
  }

  Future<Todo> getTodo(int id) async {
    List<Map> maps = await _db.query(
      tableToDo,
      columns: [columnID, columnDone, columnTitle],
      where: '$columnID = ?',
      whereArgs: [id]
    );
    if (maps.length > 0){
      return new Todo.formMap(maps.first);
    }
    return null;
  }
  
  Future<int> delete(int id) async{
    return await _db.delete(
      tableToDo, where: '$columnID = ?', 
      whereArgs: [id]);
  }

  Future<int> update(Todo todo) async{
    return await _db.update(
      tableToDo, todo.toMap(),
      where: '$columnID = ?',
      whereArgs: [todo.id],
    );
  }

  Future<List<Todo>> getAllTask() async {
    await this.open("todo.db");
    List<Map<String, dynamic>> data = await _db.query(
      tableToDo,
      where: '$columnDone = 0'
    );

    return data.map((d) => Todo.formMap(d)).toList();
  }

  Future<List<Todo>> getAllCompleted() async {
    await this.open("todo.db");
    List<Map<String, dynamic>> data = await _db.query(
      tableToDo,
      where: '$columnDone = 1'
    );

    return data.map((d) => Todo.formMap(d)).toList();
  }

  Future close() async => _db.close();
}
