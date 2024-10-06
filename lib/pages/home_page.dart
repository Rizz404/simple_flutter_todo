import 'package:flutter/material.dart';
import 'package:simple_flutter_todo/components/todo_form.dart';
import 'package:simple_flutter_todo/components/todo_tile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _controller = TextEditingController();

  // * Default data
  // todo: buat classsnya dulu biar ada auto complete
  List<Map<String, dynamic>> todoList = [
    {'todoName': "Sholat dulu", 'isTaskCompleted': false},
    {'todoName': "Tidur tepat waktu", 'isTaskCompleted': false},
    {'todoName': "Jangan mainin titit", 'isTaskCompleted': false},
  ];

  void handleCheckboxChanged(bool? value, int index) {
    setState(() {
      todoList[index]['isTaskCompleted'] = !todoList[index]['isTaskCompleted'];
    });
  }

  void handleAddTodo() {
    showDialog(
        context: context,
        builder: (context) {
          return TodoForm(
            controller: _controller,
            onSave: () {
              setState(() {
                todoList.add(
                    {'todoName': _controller.text, 'isTaskCompleted': false});
                _controller.clear();
              });
              Navigator.of(context).pop();
            },
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
            onPressed: () {
              handleAddTodo();
            },
            icon: const Icon(Icons.add),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(24),
            child: ListView.builder(
              itemBuilder: (context, index) {
                final todo = todoList[index];

                return TodoTile(
                  todoName: todo['todoName'],
                  isTaskCompleted: todo['isTaskCompleted'],
                  onChanged: (value) => handleCheckboxChanged(value, index),
                );
              },
              itemCount: todoList.length,
            )));
  }
}
