import 'package:hive/hive.dart';

// * Ini adalah bagian yang digunakan untuk generate file
part 'todo_model.g.dart';

// * Ternyata hive gak bisa plain class harus adapter dari sononya, jadi harus extend
@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String todoName;

  @HiveField(1)
  bool? isTaskCompleted;

  @HiveField(2)
  String? detail;

  // * Ini namanya constructor ya
  Todo({required this.todoName, this.isTaskCompleted = false, this.detail});
}
