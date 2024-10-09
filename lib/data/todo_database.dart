import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_flutter_todo/model/todo_model.dart';

class TodoDatabase {
  // * Referensi box tadi
  final Box<Todo> _todoBox = Hive.box('todoBox');

  void addTodo(Todo newTodo) {
    _todoBox.add(newTodo);
  }

  List<Todo> getTodos() {
    return _todoBox.values.map((dynamic item) => item as Todo).toList();
  }

  // ! KAN INDEX MULAI DARI 0 TAPI LENGTH ITU UKURANNYA JADI JANGAN SAMA LEBIH DARI SAMA DENGAN
  Todo? getTodoAt(int index) {
    if (index < _todoBox.length) {
      return _todoBox.getAt(index);
    }

    return null;
  }

  void updateTodo(int index, Todo todo) {
    _todoBox.putAt(index, todo);
  }

  void deleteTodo(int index) {
    if (index < _todoBox.length) {
      _todoBox.deleteAt(index);
    }
  }

  void createInitialData() {
    if (_todoBox.isEmpty) {
      List<Todo> todoList = [
        Todo(
            taskName: 'Pertama kali buka todo ya!',
            detail: 'Klik tombol plus di kanan bawah'),
        Todo(
            taskName: 'Tahan dan select untuk hapus',
            detail: "Belum ditambahin vibration dll jadi masih plain"),
        Todo(
            taskName: 'Belum ada validation',
            detail: "Bisa upload string kosong bang"),
      ];

      for (var todo in todoList) {
        _todoBox.add(todo);
      }
    }
  }
}
