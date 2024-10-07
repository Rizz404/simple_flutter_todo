import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_flutter_todo/model/todo_model.dart';

class TodoDatabase {
  List<Todo> todoList = [];

  // * Referensi box tadi
  final _todoBox = Hive.box('todoBox');

  void createInitialData() {
    todoList = [
      Todo(
          todoName: 'Pertama kali buka todo ya!',
          detail:
              'Klik tombol plus di kanan bawah untuk add todo dan slide lalu klik tombol sampah untuk hapus todo'),
      Todo(todoName: 'Ini bisa kamu hapus kok'),
      Todo(todoName: 'Dart kayak kintil'),
    ];
  }

  // * Nama function jangan diganti ganti
  void loadTodos() {
    // * Key value pair jangan sampe salah
    todoList = _todoBox.get('TODO_LIST', defaultValue: []);
    print(todoList);
  }

  void updateTodos() {
    _todoBox.put("TODO_LIST", todoList);
  }
}
