import 'package:flutter/material.dart';
import 'package:simple_flutter_todo/components/todo_form.dart';
import 'package:simple_flutter_todo/components/todo_tile.dart';
import 'package:simple_flutter_todo/model/todo_model.dart';
import 'package:simple_flutter_todo/services/todo_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // * Referensi databasenya
  final TodoService _todoService = TodoService();
  List<Todo> _todos = [];

  // * Controller untuk form
  // * Kayak akses value di input html
  final _controllerTaskName = TextEditingController();
  final _controllerDetail = TextEditingController();

  // * State untuk seleksi
  bool isInSelectionMode = false;
  List<int> selectedTodos = [];

  // * Ini ada snippetnya ya, jangan manual
  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  void dispose() {
    // * Hapus controller dari memori
    _controllerTaskName.dispose();
    _controllerDetail.dispose();
    super.dispose();
  }

  Future<void> _loadTodos() async {
    final todos = await _todoService.getTodos();

    if (todos.isEmpty) {
      await _todoService.createInitialData();
    }

    setState(() {
      _todos = todos;
    });
  }

  Future<void> handleCheckboxChanged(bool? value, int index) async {
    final todo = await _todoService.getTodoAt(index);

    if (todo != null) {
      todo.isTaskCompleted == value;
      await _todoService.updateTodoAt(index, todo);
      _loadTodos();
    }
  }

  Future<void> handleSave() async {
    final newTodo = Todo(
        taskName: _controllerTaskName.text, detail: _controllerDetail.text);
    await _todoService.addTodo(newTodo);
    _controllerTaskName.clear();
    _controllerDetail.clear();
    Navigator.of(context).pop();
    _loadTodos();
  }

  Future<void> handleDelete(int index) async {
    await _todoService.deleteTodoAt(index);
    _loadTodos();
  }

  void handleOpenDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return TodoForm(
            taskNameController: _controllerTaskName,
            detailController: _controllerDetail,
            onSave: () => handleSave(),
            onCancel: () {
              _controllerTaskName.clear();
              _controllerDetail.clear();
              Navigator.of(context).pop();
            },
          );
        });
  }

  void handleSelectionChange(bool isSelected, int index) {
    setState(() {
      if (isSelected) {
        if (!selectedTodos.contains(index)) {
          selectedTodos.add(index);
        }
      } else {
        selectedTodos.remove(index);
      }
      // * Aktifkan mode seleksi jika ada item terpilih
      isInSelectionMode = true;
    });
  }

  Future<void> handleSelectAll() async {
    final todo = await _todoService.getTodos();

    setState(() {
      selectedTodos = List.generate(todo.length, (index) => index);
    });
  }

  Future<void> handleDeleteSelectedTodos() async {
    await _todoService.deleteSelectedTodosAtIndices(selectedTodos);
    setState(() {
      selectedTodos.clear();
      isInSelectionMode = false;
    });
    _loadTodos();
  }

  void handleCancelSelection() {
    setState(() {
      selectedTodos.clear();
      isInSelectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data dari database dan simpan ke dalam list untuk ListView

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: isInSelectionMode
              ? Row(
                  children: [
                    if (isInSelectionMode)
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.white),
                        onPressed: handleCancelSelection,
                      ),
                    // Judul akan ditampilkan di samping IconButton "Cancel Selection"
                    Expanded(
                      child: Text(
                        !isInSelectionMode
                            ? "Todo with Flutter"
                            : "Item terpilih: ${selectedTodos.length}",
                        textAlign: TextAlign.center, // Posisikan teks di tengah
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              : const Text(
                  'Todo with flutter',
                  style: TextStyle(color: Colors.white),
                ),
          elevation: 0,
          centerTitle: true,
          actions: isInSelectionMode
              ? [
                  IconButton(
                      onPressed: () => handleSelectAll(),
                      icon: const Icon(
                        Icons.select_all,
                        color: Colors.white,
                      )),
                ]
              : null,
        ),
        bottomNavigationBar: isInSelectionMode
            ? BottomAppBar(
                child: IconButton(
                    onPressed: () => handleDeleteSelectedTodos(),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
              )
            : null,
        floatingActionButton: FloatingActionButton(
          onPressed: () => handleOpenDialog(),
          // * Atau begini sama aja, kalo gak mau ada function langsung init tanpa function
          // onPressed: handleOpenDialog,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemBuilder: (context, index) {
                final todo = _todos[index];

                return TodoTile(
                  todo: todo,
                  onChanged: (value) => handleCheckboxChanged(value, index),
                  onDelete: () => handleDelete(index),
                  onSelectionChange: (isSelected) =>
                      handleSelectionChange(isSelected, index),
                  isInSelectionMode: isInSelectionMode,
                  isSelected: selectedTodos.contains(index),
                );
              },
              itemCount: _todos.length,
            )));
  }
}
