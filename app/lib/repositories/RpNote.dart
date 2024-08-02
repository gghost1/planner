import 'package:hive/hive.dart';

import '../entities/notes/note.dart';

class RpNote {

  Future<List<Note>> getNotes() async {
    var box = await Hive.openBox<Note>('notes');
    List<Note> notes = box.values.toList().reversed.toList();
    notes.sort((a, b) => b.date.compareTo(a.date));
    return notes;
  }

  Future<void> saveNote(Note note) async {
    var box = await Hive.openBox<Note>('notes');
    await box.add(note);
  }
}