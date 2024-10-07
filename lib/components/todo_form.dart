import 'package:flutter/material.dart';
import 'package:simple_flutter_todo/components/ui/my_button.dart';

class TodoForm extends StatelessWidget {
  final TextEditingController todoNameController;
  final TextEditingController detailController;
  VoidCallback onSave;
  VoidCallback onCancel;

  TodoForm(
      {super.key,
      required this.todoNameController,
      required this.detailController,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade300,
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            TextField(
                controller: todoNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Add todo title")),
            TextField(
              controller: detailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add todo details",
              ),
              maxLines: 4, // Dapat diatur sesuai kebutuhan
              minLines: 3, // Minimum baris yang ditampilkan
            ),
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
