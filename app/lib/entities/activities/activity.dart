import 'package:hive/hive.dart';

part 'activity.g.dart';

@HiveType(typeId: 2)
class Activity extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String information;
  @HiveField(2)
  bool passed;
  @HiveField(3)
  int date;


  Activity(this.id, this.information, this.passed, this.date);
}