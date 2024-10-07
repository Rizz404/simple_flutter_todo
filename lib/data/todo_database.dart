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
    // * Ambil data dari Hive dan cast ke List<Todo>
    final rawList = _todoBox.get('TODO_LIST', defaultValue: []);

    todoList = rawList.cast<Todo>();
    print(todoList);
  }

  void updateTodos() {
    _todoBox.put("TODO_LIST", todoList);
  }
}
