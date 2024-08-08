import 'dart:collection';

import 'package:app/entities/activities/activity.dart';
import 'package:app/entities/chats/chat.dart';
import 'package:app/entities/elements/activityElement.dart';
import 'package:app/entities/messges/message.dart';
import 'package:app/repositories/RpActivity.dart';
import 'package:app/repositories/RpActivityElements.dart';
import 'package:app/repositories/RpChat.dart';
import 'package:app/repositories/RpMessage.dart';
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
    HashMap<String, dynamic> boxes = await DbInit.init();
    RpUser rpUser = RpUser(boxes);
    RpNote rpNote = RpNote(boxes);
    RpChat rpChat = RpChat(boxes);
    RpActivity rpActivity = RpActivity(boxes);
    RpMessage rpMessage = RpMessage(boxes);
    RpActivityElements rpActivityElements = RpActivityElements(boxes);


    await rpUser.saveUser(User("id", "name", "password", "phone"));

    User? user = await rpUser.getUser();
    print("User: " + (user?.id ?? "User not found") + " " +(user?.name ?? ""));

    print("\n");
    /// Test Note

    Note note1 = Note("id1", "information", DateTime.now().millisecondsSinceEpoch-1000);
    await rpNote.saveNote(note1);
    await rpNote.saveNote(Note("id2", "information", DateTime.now().millisecondsSinceEpoch));


    List<Note>? note = await rpNote.getNotes();
    print("Notes size: " + (note?.length).toString());
    print("Note: " + (note?[0].id ?? "Note not found") + " " + (note?[0].information ?? "")); // id 2 стоит первый потому что был создан позже

    Note? noteById1 = await rpNote.getNoteById("id1");
    print("NoteById1: " + (noteById1?.id ?? "Note not found") + " " + (noteById1?.information ?? ""));
    Note? noteById2 = await rpNote.getNoteById("id2");
    print("NoteById2: " + (noteById2?.id ?? "Note not found") + " " + (noteById2?.information ?? ""));

    await rpNote.deleteNote(note1);
    List<Note>? noteAfterDelete = await rpNote.getNotes();
    print("Notes size after delete: " + (noteAfterDelete?.length).toString());
    print("Note after delete: " + (noteAfterDelete?[0].id ?? "Note not found") + " " + (noteAfterDelete?[0].information ?? ""));

    print("\n");

    /// Test Chats, Activities

    Chat chat1 = Chat("id1", DateTime.now().millisecondsSinceEpoch-1000);
    await rpChat.saveChat(chat1);

    List<Activity>? activities = await rpActivity.getActivities();
    print("Activities size: " + (activities?.length).toString());
    print("Activity: " + (activities?[0].id ?? "Activity not found") + " " + (activities?[0].information ?? ""));

    Activity? activityById1 = await rpActivity.getActivityById("id");
    print("ActivityById: " + (activityById1?.id ?? "Activity not found") + " " + (activityById1?.information ?? ""));

    Activity? activityByChat1 = await rpActivity.getActivityByChat("id1");
    print("ActivityByChat1: " + (activityByChat1?.id ?? "Activity not found") + " " + (activityByChat1?.information ?? ""));

    Chat? chat = await rpChat.getChatByActivity("id");
    print("Chat: " + (chat?.id ?? "Chat not found"));

    print("\n");

    /// Test Messages

// correct time sort
    await rpMessage.saveMessage(Message("id1", "text1", DateTime.now().millisecondsSinceEpoch, true), "id1");
    await rpMessage.saveMessage(Message("id2", "text2", DateTime.now().millisecondsSinceEpoch-1000, true), "id1");

    List<Message>? messages = await rpMessage.getMessagesByChat("id1");
    print("Messages size: " + (messages?.length).toString());
    print("Message: " + (messages?[0].id ?? "Message not found") + " " + (messages?[0].text ?? ""));

    print("\n");

    /// Test Activity elements

    await rpActivityElements.saveElement(ActivityElement("id1", "information1"), "id");
    await rpActivityElements.saveElement(ActivityElement("id2", "information2"), "id");

    List<ActivityElement>? elements = await rpActivityElements.getElementsByActivity("id");
    print("Elements size: " + (elements?.length).toString());
    print("Element: " + (elements?[0].id ?? "Element not found") + " " + (elements?[0].information ?? ""));



}
