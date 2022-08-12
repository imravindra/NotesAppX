import 'package:flutter/cupertino.dart';
import 'package:notesapp/services/api_service.dart';

import '../models/Note.dart';

class NotesProvider extends ChangeNotifier {
  List<Note> notes = [];

  NotesProvider() {
    fetchNotes();
  }

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await ApiService.fetchNotes("rnirmal@gmail.com");
    notifyListeners();
  }
}
