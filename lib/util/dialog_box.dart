// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:todoapp/util/my_button.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),

            //Buttons add photo/gallery
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () => _pickImage(ImageSource.gallery), 
                ),
              ],
            ),

          //Show selected photos
          _image != null
            ? Image.file(
              _image!,
              height: 50,
              width: 50,
            )
          : Container(),
          
        
            //buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                MyButton(text: "Save", onPressed: widget.onSave),
                const SizedBox(width: 8),
                //cancel button
                MyButton(text: "Cancel", onPressed: widget.onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 