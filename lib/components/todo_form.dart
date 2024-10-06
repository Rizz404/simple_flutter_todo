import 'package:flutter/material.dart';
import 'package:simple_flutter_todo/components/ui/my_button.dart';

class TodoForm extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  TodoForm(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade300,
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
        height: 120,
        child: Column(
          children: [
            TextField(
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Add todo title")),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  text: "Cancel",
                  onPressed: onCancel,
                ),
                const SizedBox(
                  width: 8,
                ),
                MyButton(
                  text: "Save",
                  onPressed: onSave,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
