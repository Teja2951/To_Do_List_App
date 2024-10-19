import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_1/dialog_box.dart';
import 'package:to_do_1/todo_database.dart';
import 'package:to_do_1/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Database db = Database();

  final _myBox = Hive.box('mybox'); 

  void initState() {
    super.initState();
    if(_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    }
    else{
      db.loadData();
    }
  }

  void change(int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.saveData();
  }

  void savenewtask() {
  if(_controller.text != ""){
  setState(() {
    db.toDoList.add(
      [_controller.text,false],
    );
  });
  _controller.clear();
  }
  Navigator.of(context).pop();
  db.saveData();
  }

  final _controller = TextEditingController();

  void createnewtask() {
    print('Hello');
    showDialog(
      context: context,
       builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: savenewtask,
          onCancel: () => Navigator.of(context).pop(),
        );
       }
       );
  }

  void deletetask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.saveData();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('To - Do')),
          backgroundColor: Colors.yellow,
          elevation: 10,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createnewtask,
          child: Icon(Icons.add),
          backgroundColor: Colors.yellow,
          ),
        backgroundColor: Colors.yellow[200],
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskname: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => change(index),
              deleteFunction: (context) => deletetask(index),
            );
          },
        ),
      ),
    );
  }
}