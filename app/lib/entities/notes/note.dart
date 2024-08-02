import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String information;

  @HiveField(2)
  int date;

  Note(this.id,this.information, this.date);

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(date);
}
