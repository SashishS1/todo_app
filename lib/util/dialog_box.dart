// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:todoapp/util/my_button.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSave;  
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveTask() {
    final imagePath = _image?.path ?? ''; 
    widget.onSave(imagePath);  
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(maxHeight: 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Get user input
              TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add a new task',
                ),
              ),

              // Buttons to add photo/gallery
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),

              // Show selected photo
              if (_image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.file(
                    _image!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),

              // Buttons -> save + cancel
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Save button
                  MyButton(text: 'Save', onPressed: _saveTask),
                  const SizedBox(width: 8),
                  // Cancel button
                  MyButton(text: 'Cancel', onPressed: widget.onCancel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


