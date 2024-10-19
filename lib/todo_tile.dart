import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget  {

  final String taskname;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;


  ToDoTile({
    super.key,
    required this.taskname,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.only(left: 20 , right: 20 , top: 20),
          child: Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
             children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(12),
                onPressed: deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red.shade300,
                )
             ]
             ),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(10),
              ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Checkbox(value: taskCompleted, onChanged: onChanged,
                    activeColor: Colors.black,
                  ),
            
                  Text(
                    taskname,
                    style: TextStyle(decoration: taskCompleted? TextDecoration.lineThrough : TextDecoration.none),
                    ),
                ],
              ),
            ),
            ),
          ),
        );
  }
}