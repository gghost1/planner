import 'dart:collection';

import 'package:app/repositories/db/dbInit.dart';
import 'package:app/entities/notes/note.dart';

class RpNote {

  HashMap<String, dynamic> boxes;

  RpNote(this.boxes);


  Future<List<Note>> getNotes() async {
    var box = boxes['notes'];
    List<Note> notes = box.get(0)!.values.toList();
    notes.sort((a, b) => b.date.compareTo(a.date));
    return notes;
  }

  Future<Note?> getNoteById(String id) async {
    var box = boxes['notes'];
    return box.get(0)?[id];
  }

  Future<void> saveNote(Note note) async {
    var box = boxes['notes'];
    HashMap<String, Note> notes = box.get(0)!;
    notes.addEntries([MapEntry<String, Note>(note.id.toString(), note)]);
    box.put(0, notes);
  }

  Future<void> deleteNote(Note note) async {
    var box = boxes['notes'];
    HashMap<String, Note> notes = box.get(0)!;
    notes.remove(note.id.toString());
    box.put(0, notes);
  }

}