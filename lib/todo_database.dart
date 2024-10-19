import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Database {
  List toDoList = [];

  final _myBox = Hive.box('mybox');
  void createInitialData() {
    toDoList = [['Learn',false]];
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void saveData() {
    _myBox.put("TODOLIST", toDoList);
  }


}