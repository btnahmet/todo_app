import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.task});
  final Task task;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.notes_outlined,
              size: 50,
            ),
            Expanded(
              child: Column(
                children: [ 
                  Text(
                    widget.task.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  Text(widget.task.description),
                ],
              ),
            ),
            Checkbox(
                value: isChecked,
                onChanged: (val) {
                  setState(() {
                    widget.task.isCompleted = !widget.task.isCompleted;
                    isChecked = val!;
                  });
                }),
                //Checkbox(value: value, onChanged: onChanged)
                ],
        ),
      ),
    );
  }
}
