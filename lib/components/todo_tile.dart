import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String todoName;
  final String detail;
  final bool isTaskCompleted;
  Function(bool?) onChanged;
  Function(BuildContext?) handleDelete;

  TodoTile({
    super.key,
    required this.todoName,
    required this.detail,
    required this.isTaskCompleted,
    required this.onChanged,
    required this.handleDelete,
  });

  @override
  Widget build(BuildContext context) {
    // * Biar bisa slide
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // * Nambahin button yang muncul saat slide
          SlidableAction(
            onPressed: handleDelete,
            icon: Icons.delete,
            backgroundColor: Colors.black,
            borderRadius: BorderRadius.circular(4),
          )
        ],
      ),
      child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(4)),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Row(
            children: [
              Checkbox(
                value: isTaskCompleted,
                onChanged: onChanged,
                activeColor: Colors.grey.shade600,
              ),
              Text(
                todoName,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  decoration: isTaskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor:
                      Colors.black, // Warna dari garis strikethrough
                  decorationThickness:
                      3.0, // Ketebalan dari garis strikethrough
                  decorationStyle: TextDecorationStyle
                      .solid, // Tipe garis (solid, double, wavy, dll)
                ),
              ),
              Text(detail)
            ],
          )),
    );
  }
}
