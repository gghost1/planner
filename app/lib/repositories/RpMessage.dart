import '../entities/messges/message.dart';
import 'db/dbInit.dart';

class RpMessage {

  static Future<List<Message>?> getMessagesByChat(String chatId) async {
    var box;
    box = await DbInit.chatMessageBox();
    List<String>? messageIds = box.getAt(0)?[chatId];
    List<Message> messages = [];
    box = await DbInit.messageBox();
    messageIds?.forEach((element) {
      messages.add(box.getAt(0)?[element]);
    });
    return messages;
  }

  static Future<void> saveMessage(Message message, String chatId) async {
    var box;
    box = await DbInit.messageBox();
    box.getAt(0)?.addEntries([MapEntry(message.id, message)]);

    box = await DbInit.chatMessageBox();
    box.getAt(0)?[chatId].add(message.id);
  }

}