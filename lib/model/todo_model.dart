import 'package:hive/hive.dart';

// * Ini adalah bagian yang digunakan untuk generate file
part 'todo_model.g.dart';

// * Ternyata hive gak bisa plain class harus adapter dari sononya, jadi harus extend
@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String taskName;

  @HiveField(1)
  bool isTaskCompleted;

  @HiveField(2)
  String? detail;

  @HiveField(3)
  DateTime? createdAt;

  @HiveField(4)
  DateTime? updatedAt;

  // * Ini namanya constructor ya
  // * Bisa buat ternary di constructor
  Todo({
    required this.taskName,
    this.isTaskCompleted = false,
    this.detail,
    DateTime? createdAt, // * Bisa diset saat pembuatan object
    DateTime? updatedAt, // * Bisa diset saat pembuatan object
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
