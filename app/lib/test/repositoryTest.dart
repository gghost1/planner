import 'package:app/entities/activities/activity.dart';
import 'package:app/entities/chats/chat.dart';
import 'package:app/repositories/RpActivity.dart';
import 'package:app/repositories/RpChat.dart';
import 'package:app/repositories/RpNote.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:app/entities/user/user.dart';
import 'package:app/entities/notes/note.dart';
import '../repositories/RpUser.dart';
import '../repositories/db/dbInit.dart';
import 'path_provider_test.dart';

void main() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();

    await Hive.initFlutter();
    await DbInit.init();

    RpUser.saveUser(User("id", "name", "password", "phone"));

    User? user = await RpUser.getUser();
    print("User: " + (user?.id ?? "User not found") + " " +(user?.name ?? ""));

    print("\n");
    /// Test Note

    Note note1 = Note("id1", "information", DateTime.now().millisecondsSinceEpoch-1000);
    await RpNote.saveNote(note1);
    await RpNote.saveNote(Note("id2", "information", DateTime.now().millisecondsSinceEpoch));


    List<Note>? note = await RpNote.getNotes();
    print("Notes size: " + (note?.length).toString());
    print("Note: " + (note?[0].id ?? "Note not found") + " " + (note?[0].information ?? "")); // id 2 стоит первый потому что был создан позже

    Note? noteById1 = await RpNote.getNoteById("id1");
    print("NoteById1: " + (noteById1?.id ?? "Note not found") + " " + (noteById1?.information ?? ""));
    Note? noteById2 = await RpNote.getNoteById("id2");
    print("NoteById2: " + (noteById2?.id ?? "Note not found") + " " + (noteById2?.information ?? ""));

    await RpNote.deleteNote(note1);
    List<Note>? noteAfterDelete = await RpNote.getNotes();
    print("Notes size after delete: " + (noteAfterDelete?.length).toString());
    print("Note after delete: " + (noteAfterDelete?[0].id ?? "Note not found") + " " + (noteAfterDelete?[0].information ?? ""));

    print("\n");

    /// Test Chats, Activities

    Chat chat1 = Chat("id1", DateTime.now().millisecondsSinceEpoch-1000);
    await RpChat.saveChat(chat1);

    List<Activity>? activities = await RpActivity.getActivities();
    print("Activities size: " + (activities?.length).toString());
    print("Activity: " + (activities?[0].id ?? "Activity not found") + " " + (activities?[0].information ?? ""));

    Chat chat2 = Chat("id2", DateTime.now().millisecondsSinceEpoch);

}
