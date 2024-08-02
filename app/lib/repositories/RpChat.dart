import 'dart:collection';

import 'package:app/entities/activities/activity.dart';
import 'package:app/repositories/RpActivity.dart';
import 'package:app/repositories/db/dbInit.dart';

import '../entities/chats/chat.dart';

class RpChat {

  static Future<Chat> getChatByActivity(String activityId) async {
    var box;
    box = await DbInit.activityChatBox();
    String chatId = box.get(0)?[activityId];
    box = await DbInit.chatBox();
    return box.get(0)?[chatId];
  }


  static Future<void> saveChat(Chat chat,  [String? activityInformation]) async {
    var box;
    box = await DbInit.chatBox();
    HashMap<String, Chat>? chats = box.get(0);
    chats?.addEntries([MapEntry<String, Chat>(chat.id, chat)]);
    box.put(0, chats!);

    Activity activity = Activity("id", (activityInformation ?? ""), false, DateTime.now().millisecondsSinceEpoch);
    RpActivity.saveActivity(activity);

    box = await DbInit.activityChatBox();
    HashMap<String, String>? activityChat = box.get(0);
    activityChat?.addEntries([MapEntry(activity.id, chat.id)]);
    box.put(0, activityChat!);

    //
    // box = await DbInit.chatMessageBox();
    // box.get(0)?.addEntries([MapEntry(chat.id, [])]);
  }
}