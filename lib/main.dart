import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_flutter_todo/model/todo_model.dart';
import 'package:simple_flutter_todo/pages/home_page.dart';

void main() async {
  // * Assign librarynya ke main file (sama kaya react)
  await Hive.initFlutter();

  // ! harus ada sebelum open box
  // * Register model-modelnya disini
  Hive.registerAdapter(TodoAdapter());

  // * Config hive nya
  var box = await Hive.openBox('todoBox'); // * Nama databasenya (prefixnya box)

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }
}
