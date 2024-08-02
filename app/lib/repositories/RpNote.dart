import 'dart:collection';

import 'package:app/repositories/db/dbInit.dart';
import 'package:app/entities/notes/note.dart';

class RpNote {

  static Future<List<Note>?> getNotes() async {
    var box = await DbInit.noteBox();
    List<Note>? notes = box.get(0)?.values.toList();
    notes?.sort((a, b) => b.date.compareTo(a.date));
    return notes;
  }

  static Future<Note?> getNoteById(String id) async {
    var box = await DbInit.noteBox();
    return box.get(0)?[id];
  }

  static Future<void> saveNote(Note note) async {
    var box = await DbInit.noteBox();
    HashMap<String, Note>? notes = box.get(0);
    notes?.addEntries([MapEntry<String, Note>(note.id.toString(), note)]);
    box.put(0, notes!);
  }

  static Future<void> deleteNote(Note note) async {
    var box = await DbInit.noteBox();
    HashMap<String, Note>? notes = box.get(0);
    notes?.remove(note.id.toString());
    box.put(0, notes!);
  }

}