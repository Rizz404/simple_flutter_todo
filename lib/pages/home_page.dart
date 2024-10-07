import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:simple_flutter_todo/components/todo_form.dart';
import 'package:simple_flutter_todo/components/todo_tile.dart';
import 'package:simple_flutter_todo/data/todo_database.dart';
import 'package:simple_flutter_todo/model/todo_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Center(child: Text("Todo with flutter")),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: IconButton(
            onPressed: () => handleOpenDialog(),
            icon: const Icon(Icons.add),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(24),
            child: ListView.builder(
              itemBuilder: (context, index) {
                final todo = todoDatabase.todoList[index];

                return TodoTile(
                  todoName: todo.todoName,
                  detail: todo.detail ?? '',
                  isTaskCompleted: todo.isTaskCompleted ?? false,
                  onChanged: (value) => handleCheckboxChanged(value, index),
                  handleDelete: (context) => handleDelete(index),
                );
              },
              itemCount: todoDatabase.todoList.length,
            )));
  }
}
