import 'dart:collection';

import 'package:app/entities/activities/activity.dart';
import 'package:app/repositories/RpActivity.dart';
import 'package:app/repositories/db/dbInit.dart';

import '../entities/chats/chat.dart';

class RpChat {

  HashMap<String, dynamic> boxes;

  RpChat(this.boxes);

  Future<Chat> getChatByActivity(String activityId) async {
    var box;
    box = boxes['activitychat'];
    String chatId = box.get(0)![activityId]!;
    box = boxes['chats'];
    return box.get(0)![chatId]!;
  }


  Future<void> saveChat(Chat chat,  [String? activityInformation]) async {
    var box;
    box = boxes['chats'];
    HashMap<String, Chat> chats = box.get(0)!;
    chats.addEntries([MapEntry<String, Chat>(chat.id, chat)]);
    box.put(0, chats);
// id will returned from server
    Activity activity = Activity("id", (activityInformation ?? ""), false, DateTime.now().millisecondsSinceEpoch);
    await RpActivity(boxes).saveActivity(activity);

    box = boxes['activitychat'];
    HashMap<String, String> activityChat = box.get(0)!;
    activityChat.addEntries([MapEntry(activity.id, chat.id)]);
    box.put(0, activityChat);


    box = boxes['chatmessages'];
    HashMap<String, List<String>> messageBox = box.get(0)!;
    messageBox.addEntries([MapEntry(chat.id, [])]);
    box.put(0, messageBox);
  }
}