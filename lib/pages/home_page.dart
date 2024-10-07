import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:simple_flutter_todo/components/todo_form.dart';
import 'package:simple_flutter_todo/components/todo_tile.dart';
import 'package:simple_flutter_todo/data/todo_database.dart';
import 'package:simple_flutter_todo/model/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // * Referensi databasenya
  // ! namanya harus sama kaya di main file
  final _todoBox = Hive.box("todoBox");
  TodoDatabase todoDatabase = TodoDatabase();

  // * Ini ada snippetnya ya, jangan manual
  @override
  void initState() {
    if (_todoBox.get('TODO_LIST') == null) {
      todoDatabase.createInitialData();
    } else {
      todoDatabase.loadTodos();
    }
    super.initState();
  }

  // * Kayak akses value di input html
  final _controllerTodoName = TextEditingController();
  final _controllerDetail = TextEditingController();

  // * State untuk seleksi
  bool isInSelectionMode = false;
  List<int> selectedTodos = [];

  void handleCheckboxChanged(bool? value, int index) {
    setState(() {
      todoDatabase.todoList[index].isTaskCompleted = value ?? false;
    });
    todoDatabase.updateTodos();
  }

  void handleSave() {
    setState(() {
      // * Belum tambahin input buat detail
      todoDatabase.todoList.add(Todo(
          todoName: _controllerTodoName.text,
          detail: _controllerDetail.text,
          isTaskCompleted: false));
      _controllerTodoName.clear();
      _controllerDetail.clear();
    });
    Navigator.of(context).pop();
    todoDatabase.updateTodos();
  }

  void handleDelete(int index) {
    setState(() {
      todoDatabase.todoList.removeAt(index);
    });
    todoDatabase.updateTodos();
  }

  void handleOpenDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return TodoForm(
            todoNameController: _controllerTodoName,
            detailController: _controllerDetail,
            onSave: () => handleSave(),
            onCancel: () {
              _controllerTodoName.clear();
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

  void handleDeleteSelectedTodos() {
    setState(() {
      selectedTodos
          .sort((a, b) => b.compareTo(a)); // * Urutkan dari index terbesar
      for (var index in selectedTodos) {
        todoDatabase.todoList.removeAt(index);
      }
      selectedTodos.clear();
      isInSelectionMode = false;
    });
    todoDatabase.updateTodos();
  }

  void handleSelectAll() {
    setState(() {
      selectedTodos =
          List.generate(todoDatabase.todoList.length, (index) => index);
      isInSelectionMode = true;
    });
  }

  void handleCancelSelection() {
    setState(() {
      selectedTodos.clear();
      isInSelectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                final todo = todoDatabase.todoList[index];

                return TodoTile(
                  todoName: todo.todoName,
                  detail: todo.detail ?? '',
                  isTaskCompleted: todo.isTaskCompleted ?? false,
                  onChanged: (value) => handleCheckboxChanged(value, index),
                  onDelete: () => handleDelete(index),
                  onSelectionChange: (isSelected) =>
                      handleSelectionChange(isSelected, index),
                  isInSelectionMode: isInSelectionMode,
                  isSelected: selectedTodos.contains(index),
                );
              },
              itemCount: todoDatabase.todoList.length,
            )));
  }
}
