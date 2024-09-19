// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:io'; 

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final String imagePath; 
  final Function(bool?) onChanged;
  final Function(BuildContext) deleteFunction;

  const ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.imagePath, 
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Show image if have
              if (imagePath.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.file(
                    File(imagePath),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              
              // Checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),

              // Task name
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


