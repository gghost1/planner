import 'package:hive/hive.dart';

part 'chat.g.dart';

@HiveType(typeId: 4)
class Chat extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  int date;


  Chat(this.id, this.date);
}