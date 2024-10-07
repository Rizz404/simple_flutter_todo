import 'package:flutter/material.dart';

class TodoTile extends StatefulWidget {
  final String todoName;
  final String detail;
  final bool isTaskCompleted;
  final Function(bool?) onChanged;
  final VoidCallback onDelete;
  final Function(bool) onSelectionChange;
  final bool isSelected;
  final bool isInSelectionMode;

  const TodoTile({
    super.key,
    required this.todoName,
    required this.detail,
    required this.isTaskCompleted,
    required this.onChanged,
    required this.onDelete,
    required this.onSelectionChange,
    required this.isInSelectionMode,
    required this.isSelected,
  });

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool isExpanded = false;
  int charLimit = 50;

  @override
  Widget build(BuildContext context) {
    // * Periksa detail panjang apa kaga
    bool isDetailLong = widget.detail.length > charLimit;

    return GestureDetector(
      onLongPress: () {
        // * Kalo tahan akan terbuka mode seleksi
        widget.onSelectionChange(true);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: !widget.isTaskCompleted
                ? Colors.white
                : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2))
            ]),
        child: isDetailLong
            ? ExpansionTile(
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                onExpansionChanged: (expanded) {
                  setState(() {
                    isExpanded = expanded;
                  });
                },
                leading: !widget.isInSelectionMode
                    ? Checkbox(
                        value: widget.isTaskCompleted,
                        onChanged: widget.onChanged,
                        activeColor: Colors.blueGrey[600],
                      )
                    : const Icon(Icons.more),
                title: Text(
                  widget.todoName,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: widget.isTaskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.black54,
                    decorationThickness: 2.0,
                  ),
                ),
                subtitle: widget.detail.isNotEmpty
                    ? Text(
                        // Potong detail jika lebih panjang dari characterLimit
                        widget.detail.length > charLimit
                            ? '${widget.detail.substring(0, charLimit)}...'
                            : widget.detail,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      )
                    : null,
                trailing: widget.isInSelectionMode
                    ? Checkbox(
                        value: widget
                            .isSelected, // Gunakan nilai `isSelected` dari `HomePage`
                        onChanged: (value) {
                          widget.onSelectionChange(value ?? false);
                        },

                        activeColor: Colors.blueGrey[600],
                        shape: const CircleBorder(),
                      )
                    : Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Colors.grey[600],
                      ),
                children: isDetailLong
                    ? [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.detail,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ]
                    : [])
            : ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: !widget.isInSelectionMode
                    ? Checkbox(
                        value: widget.isTaskCompleted,
                        onChanged: widget.onChanged,
                        activeColor: Colors.blueGrey[600],
                      )
                    : const Icon(Icons.more),
                title: Text(
                  widget.todoName,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: widget.isTaskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.black54,
                    decorationThickness: 2.0,
                  ),
                ),
                trailing: widget.isInSelectionMode
                    ? Checkbox(
                        value: widget
                            .isSelected, // Gunakan nilai `isSelected` dari `HomePage`
                        onChanged: (value) {
                          widget.onSelectionChange(value ?? false);
                        },

                        activeColor: Colors.blueGrey[600],
                        shape: const CircleBorder(),
                      )
                    : null,
              ),
      ),
    );
  }
}
