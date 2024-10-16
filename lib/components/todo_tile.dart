import 'package:flutter/material.dart';
import 'package:simple_flutter_todo/model/todo_model.dart';
import 'package:vibration/vibration.dart';

class TodoTile extends StatefulWidget {
  final Todo todo;
  final bool isSelected;
  final bool isInSelectionMode;
  final Function(bool?) onChanged;
  final VoidCallback onDelete;
  final Function(bool) onSelectionChange;

  const TodoTile({
    super.key,
    required this.todo,
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
    bool isDetailLong =
        widget.todo.detail != null && widget.todo.detail!.length > charLimit;

    return GestureDetector(
      onLongPress: () => widget.onSelectionChange(true),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: widget.todo.isTaskCompleted
              ? Colors.white.withOpacity(0.2)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isDetailLong ? _buildExpansionTile() : _buildListTile(),
      ),
    );
  }

  Widget _buildExpansionTile() {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onExpansionChanged: (expanded) {
        setState(() {
          isExpanded = expanded;
        });
      },
      leading: _buildLeading(),
      title: _buildTitle(),
      subtitle: Text(
        '${widget.todo.detail!.substring(0, charLimit)}...',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      trailing: widget.isInSelectionMode
          ? Checkbox(
              value: widget.isSelected,
              onChanged: (value) => widget.onSelectionChange(value ?? false),
              activeColor: Colors.blueGrey[600],
              shape: const CircleBorder(),
            )
          : Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.grey[600],
            ),
      children: [
        if (widget.todo.detail != null && widget.todo.detail!.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.todo.detail!,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildListTile() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: _buildLeading(),
      title: _buildTitle(),
      subtitle: widget.todo.detail != null && widget.todo.detail!.isNotEmpty
          ? Text(
              widget.todo.detail!,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: _buildTrailing(),
    );
  }

  Widget _buildLeading() {
    return !widget.isInSelectionMode
        ? Checkbox(
            value: widget.todo.isTaskCompleted,
            onChanged: widget.onChanged,
            activeColor: Colors.blueGrey[600],
          )
        : const Icon(Icons.more);
  }

  Widget _buildTitle() {
    return Text(
      widget.todo.taskName,
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        decoration: widget.todo.isTaskCompleted
            ? TextDecoration.lineThrough
            : TextDecoration.none,
        decorationColor: Colors.black54,
        decorationThickness: 2.0,
      ),
    );
  }

  Widget _buildTrailing() {
    if (widget.isInSelectionMode) {
      return Checkbox(
        value: widget.isSelected,
        onChanged: (value) => widget.onSelectionChange(value ?? false),
        activeColor: Colors.blueGrey[600],
        shape: const CircleBorder(),
      );
    } else if (widget.todo.detail != null &&
        widget.todo.detail!.length > charLimit) {
      return Icon(
        isExpanded ? Icons.expand_less : Icons.expand_more,
        color: Colors.grey[600],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
