
import 'dart:collection';

import 'package:app/entities/chats/chat.dart';
import 'package:app/entities/messges/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:app/entities/activities/activity.dart';
import 'package:app/entities/elements/activityElement.dart';

import 'package:app/entities/notes/note.dart';
import 'package:app/entities/user/user.dart';

class DbInit {
  static Box<User>? _userBox;
  static Box<HashMap<String, Note>>? _noteBox;
  static Box<HashMap<String, Chat>>? _chatBox;
  static Box<HashMap<String, Message>>? _messageBox;
  static Box<HashMap<String, ActivityElement>>? _elementBox;
  static Box<HashMap<String, Activity>>? _activityBox;
  static Box<HashMap<String, List<String>>>? _chatMessageBox;
  static Box<HashMap<String, List<String>>>? _activityElementBox;
  static Box<HashMap<String, String>>? _activityChatBox;

  static Future<HashMap<String, dynamic>> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(NoteAdapter());
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(ActivityElementAdapter());
    Hive.registerAdapter(ChatAdapter());
    Hive.registerAdapter(ActivityAdapter());

    HashMap<String, dynamic> boxes = HashMap();


    boxes['user'] = await Hive.openBox<User>('user');

    _noteBox = await Hive.openBox<HashMap<String, Note>>('notes');
    await _noteBox?.put(0, HashMap<String, Note>());
    boxes['notes'] = _noteBox;

    _chatBox = await Hive.openBox<HashMap<String, Chat>>('chats');
    await _chatBox?.put(0, HashMap<String, Chat>());
    boxes['chats'] = _chatBox;

    _messageBox = await Hive.openBox<HashMap<String, Message>>('messages');
    await _messageBox?.put(0, HashMap<String, Message>());
    boxes['messages'] = _messageBox;

    _elementBox = await Hive.openBox<HashMap<String, ActivityElement>>('elements');
    await _elementBox?.put(0, HashMap<String, ActivityElement>());
    boxes['elements'] = _elementBox;

    _activityBox = await Hive.openBox<HashMap<String, Activity>>('activities');
    await _activityBox?.put(0, HashMap<String, Activity>());
    boxes['activities'] = _activityBox;

    _chatMessageBox = await Hive.openBox<HashMap<String, List<String>>>('chatmessages');
    await _chatMessageBox?.put(0, HashMap<String, List<String>>());
    boxes['chatmessages'] = _chatMessageBox;

    _activityElementBox = await Hive.openBox<HashMap<String, List<String>>>('activityelements');
    await _activityElementBox?.put(0, HashMap<String, List<String>>());
    boxes['activityelements'] = _activityElementBox;

    _activityChatBox = await Hive.openBox<HashMap<String, String>>('activitychat');
    await _activityChatBox?.put(0, HashMap<String, String>());
    boxes['activitychat'] = _activityChatBox;

    return boxes;
  }

}
