import 'dart:collection';

import '../entities/messges/message.dart';
import 'db/dbInit.dart';

class RpMessage {

  HashMap<String, dynamic> boxes;

  RpMessage(this.boxes);

  Future<List<Message>> getMessagesByChat(String chatId) async {
    var box;
    box = boxes['chatmessages'];
    List<String> messageIds = box.getAt(0)![chatId]!;
    List<Message> messages = [];
    box = boxes['messages'];
    for (var element in messageIds) {
      messages.add(box.getAt(0)![element]!);
    }
    return messages;
  }

  Future<void> saveMessage(Message message, String chatId) async {
    var box;
    box = boxes['messages'];
    HashMap<String, Message> messages = box.getAt(0)!;
    messages.addEntries([MapEntry(message.id, message)]);
    box.put(0, messages);

    box = boxes['chatmessages'];
    HashMap<String, List<String>> chatMessages = box.getAt(0)!;
    chatMessages[chatId]!.add(message.id);
    box.put(0, chatMessages);
  }

}