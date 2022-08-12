import 'package:flutter/material.dart';
import 'package:notesapp/models/Note.dart';
import 'package:notesapp/providers/notesprovider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNotePage({Key? key, required this.isUpdate, this.note})
      : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FocusNode noteFocus = FocusNode();

  void addNewNote() {
    Note newNote = Note(
      id: const Uuid().v1(),
      userId: "rnirmal@gmail.com",
      title: titleController.text,
      content: contentController.text,
      createdOn: DateTime.now(),
    );

    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  @override
  void initState() {
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (widget.isUpdate) {
                  widget.note!.title = titleController.text;
                  widget.note!.content = contentController.text;
                  Provider.of<NotesProvider>(context).updateNote(widget.note!);
                  Navigator.pop(context);
                } else {
                  addNewNote();
                }
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              autofocus: (widget.isUpdate == true) ? false : true,
              onSubmitted: (val) {
                if (val.isNotEmpty) {
                  noteFocus.requestFocus();
                }
              },
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: "Title", border: InputBorder.none),
            ),
            Expanded(
              child: TextField(
                focusNode: noteFocus,
                style: const TextStyle(fontSize: 30),
                controller: contentController,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: "Content", border: InputBorder.none),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
