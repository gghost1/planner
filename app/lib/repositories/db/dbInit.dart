
import 'dart:collection';

import 'package:app/entities/chats/chat.dart';
import 'package:app/entities/messges/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../entities/activities/activity.dart';
import '../../entities/elements/activityElement.dart';
import '../../entities/notes/note.dart';
import '../../entities/user/user.dart';

class DbInit {

  static void init() async {
    await Hive.initFlutter();
    WidgetsFlutterBinding.ensureInitialized();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(NoteAdapter());
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(ActivityElementAdapter());
    Hive.registerAdapter(ChatAdapter());
    Hive.registerAdapter(ActivityAdapter());

    var box;

    box = await Hive.openBox<HashMap<String, User>>('user');
    await box.add(HashMap<String, User>());

    box = await Hive.openBox<HashMap<String, Note>>('notes');
    await box.add(HashMap<String, Note>());

    box = await Hive.openBox<HashMap<String, Chat>>('chats');
    await box.add(HashMap<String, Chat>());

    box = await Hive.openBox<HashMap<String, Message>>('messages');
    await box.add(HashMap<String, Message>());

    box = await Hive.openBox<HashMap<String, ActivityElement>>('elements');
    await box.add(HashMap<String, ActivityElement>());

    box = await Hive.openBox<HashMap<String, Activity>>('activities');
    await box.add(HashMap<String, Activity>());

    box = await Hive.openBox<HashMap<String, String>>('chatMessages');
    await box.add(HashMap<String, List<String>>());

    box = await Hive.openBox<HashMap<String, String>>('activityElements');
    await box.add(HashMap<String, List<String>>());

    box = await Hive.openBox<HashMap<String, String>>('activityChat');
    await box.add(HashMap<String, String>());

  }
}