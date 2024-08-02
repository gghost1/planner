
import 'dart:collection';

import 'package:app/entities/chats/chat.dart';
import 'package:app/entities/messges/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:app/entities/activities/activity.dart';
import '../../entities/elements/activityElement.dart';

import 'package:app/entities/notes/note.dart';
import 'package:app/entities/user/user.dart';

class DbInit {

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(NoteAdapter());
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(ActivityElementAdapter());
    Hive.registerAdapter(ChatAdapter());
    Hive.registerAdapter(ActivityAdapter());

    var box;

    box = await Hive.openBox<User>('user');

    box = await Hive.openBox<HashMap<String, Note>>('notes');
    await box.put(0, HashMap<String, Note>());

    box = await Hive.openBox<HashMap<String, Chat>>('chats');
    await box.put(0, HashMap<String, Chat>());

    box = await Hive.openBox<HashMap<String, Message>>('messages');
    await box.put(0, HashMap<String, Message>());

    box = await Hive.openBox<HashMap<String, ActivityElement>>('elements');
    await box.put(0, HashMap<String, ActivityElement>());

    box = await Hive.openBox<HashMap<String, Activity>>('activities');
    await box.put(0, HashMap<String, Activity>());

    box = await Hive.openBox<HashMap<String, List<String>>>('chatMessages');
    await box.put(0, HashMap<String, List<String>>());

    box = await Hive.openBox<HashMap<String, List<String>>>('activityElements');
    await box.put(0, HashMap<String, List<String>>());

    box = await Hive.openBox<HashMap<String, String>>('activityChat');
    await box.put(0, HashMap<String, String>());

  }

  static Future<Box<User>> userBox() async {
    var box = await Hive.openBox<User>('user');
    return box;
  }

  static Future<Box<HashMap<String, Note>>> noteBox() async {
    var box = await Hive.openBox<HashMap<String, Note>>('notes');
    return box;
  }

  static Future<Box<HashMap<String, Chat>>> chatBox() async {
    var box = await Hive.openBox<HashMap<String, Chat>>('chats');
    return box;
  }

  static Future<Box<HashMap<String, Message>>> messageBox() async {
    var box = await Hive.openBox<HashMap<String, Message>>('messages');
    return box;
  }

  static Future<Box<HashMap<String, ActivityElement>>> elementBox() async {
    var box = await Hive.openBox<HashMap<String, ActivityElement>>('elements');
    return box;
  }

  static Future<Box<HashMap<String, Activity>>> activityBox() async {
    var box = await Hive.openBox<HashMap<String, Activity>>('activities');
    return box;
  }

  static Future<Box<HashMap<String, List<String>>>> chatMessageBox() async {
    var box = await Hive.openBox<HashMap<String, List<String>>>('chatMessages');
    return box;
  }

  static Future<Box<HashMap<String, List<String>>>> activityElementBox() async {
    var box = await Hive.openBox<HashMap<String, List<String>>>('activityElements');
    return box;
  }

  static Future<Box<HashMap<String, String>>> activityChatBox() async {
    var box = await Hive.openBox<HashMap<String, String>>('activityChat');
    return box;
  }

}