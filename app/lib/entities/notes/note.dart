import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  String information;

  @HiveField(1)
  int date;  // Store DateTime as timestamp

  Note(this.information, this.date);

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(date);
}
