// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/util/dialog_box.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference hive box
  final _myBox = Hive.box('mybox');
  late ToDoDataBase db;

  @override
  void initState() {
    super.initState();
    db = ToDoDataBase();


    // 1st time open the app
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // have data
      db.loadData();
    }
  }

  // Text Controller
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Checkbox has been checked
  void checkedBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = value ?? false;
    });
    db.updateDataBase();
  }

  // Save new task
  void saveNewTask(String imagePath) {
    setState(() {
      db.toDoList.add([_controller.text, false, imagePath]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // Create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: (imagePath) => saveNewTask(imagePath),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        centerTitle: true,
        elevation: 50,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            imagePath: db.toDoList[index][2], // Inclua o caminho da imagem
            onChanged: (value) => checkedBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}


