import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String todoName;
  final bool isTaskCompleted;
  Function(bool?)? onChanged;

  TodoTile(
      {super.key,
      required this.todoName,
      required this.isTaskCompleted,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                decorationColor: Colors.black, // Warna dari garis strikethrough
                decorationThickness: 3.0, // Ketebalan dari garis strikethrough
                decorationStyle: TextDecorationStyle
                    .solid, // Tipe garis (solid, double, wavy, dll)
              ),
            )
          ],
        ));
  }
}
