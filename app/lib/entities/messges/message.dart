import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 5)
class Message extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String text;

  @HiveField(2)
  int date;


  Message(this.id, this.text, this.date);
}