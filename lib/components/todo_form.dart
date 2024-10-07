import 'package:flutter/material.dart';
import 'package:simple_flutter_todo/components/ui/my_button.dart';

class TodoForm extends StatelessWidget {
  final TextEditingController todoNameController;
  final TextEditingController detailController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const TodoForm(
      {super.key,
      required this.todoNameController,
      required this.detailController,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: todoNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: "Todo name",
                labelText: "Judul",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: detailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: "Detail tugas",
                labelText: "Detail",
              ),
              maxLines: 4,
              minLines: 3,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: Text("Batal",
                      style: TextStyle(color: Colors.blueGrey[700])),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[600],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Simpan"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
