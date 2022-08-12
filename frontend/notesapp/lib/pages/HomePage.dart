import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/models/Note.dart';
import 'package:notesapp/providers/notesprovider.dart';
import 'package:provider/provider.dart';

import 'add_note_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: (notesProvider.notes.isNotEmpty)
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: notesProvider.notes.length,
                  itemBuilder: ((context, index) {
                    Note currentNote = notesProvider.notes[index];
                    return GestureDetector(
                      onTap: () {
                        //update
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => AddNotePage(
                                      isUpdate: true,
                                      note: currentNote,
                                    )));
                      },
                      onLongPress: () {
                        //delete
                        notesProvider.deleteNote(currentNote);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Text(
                              currentNote.title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              currentNote.content!,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.grey),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                )
              : const Center(
                  child: Text("No Notes Yet"),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: ((context) => const AddNotePage(
                        isUpdate: false,
                      ))));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
