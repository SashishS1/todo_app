// ignore_for_file: prefer_const_constructors, unnecessary_import, avoid_print

import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List<List<dynamic>> toDoList = [];

  // reference database
  final _myBox = Hive.box('mybox');

  // first time open the app
  void createInitialData() {
    toDoList = [
      ['Make a tutorial', false, ''],
      ['Do Exercise', true, ''],
    ];
    updateDataBase();
  }

  // load database
  void loadData() {
    final data = _myBox.get('TODOLIST', defaultValue: []);
    toDoList = List<List<dynamic>>.from(data);
  }

  // update database
  void updateDataBase() {
    _myBox.put('TODOLIST', toDoList);
  }

  // add new task
  void addTask(String taskText, bool isCompleted, String imagePath) {
    toDoList.add([taskText, isCompleted, imagePath]);
    updateDataBase();
  }

  // update task
  void updateTask(int index, String taskText, bool isCompleted, String imagePath) {
    toDoList[index] = [taskText, isCompleted, imagePath];
    updateDataBase();
  }

  // Remove task
  void deleteTask(int index) {
    toDoList.removeAt(index);
    updateDataBase();
  }
}
