import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_flutter_todo/model/todo_model.dart';

class TodoService {
  static const String _boxName = 'todoBox';

  Future<Box<Todo>> get _box async => await Hive.openBox<Todo>(_boxName);

  Future<List<Todo>> getTodos() async {
    final box = await _box;
    return box.values.toList();
  }

  Future<Todo?>? getTodoAt(int index) async {
    final box = await _box;

    if (index < box.length) {
      return box.getAt(index);
    } else {
      return null;
    }
  }

  Future<void> addTodo(Todo newTodo) async {
    final box = await _box;
    await box.add(newTodo);
  }

  Future<void> updateTodoAt(int index, Todo todo) async {
    final box = await _box;

    if (index < box.length) {
      await box.putAt(index, todo);
    }
  }

  Future<void> deleteTodoAt(int index) async {
    final box = await _box;
    await box.deleteAt(index);
  }
}
