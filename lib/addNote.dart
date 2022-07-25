import 'package:flutter/material.dart';
import 'main.dart';
import 'databaseHelper.dart';

class AddNote extends StatefulWidget {
  AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final textController = TextEditingController();
  final anotherController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              cursorColor: Colors.red,
              style: TextStyle(fontSize: 24),
              focusNode: FocusNode(),
              controller: textController,
            ),
            TextField(
              cursorColor: Colors.red,
              style: TextStyle(fontSize: 24),
              focusNode: FocusNode(),
              controller: anotherController,
            ),
            FloatingActionButton(
              child: const Icon(Icons.save),
              onPressed: () async {
                await DatabaseHelper.instance.add(
                  Grocery(
                    name: textController.text,
                    // another: anotherController.text,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
