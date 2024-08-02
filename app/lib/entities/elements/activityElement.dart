import 'package:hive/hive.dart';

part 'activityElement.g.dart';

@HiveType(typeId: 3)
class ActivityElement extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String information;

  ActivityElement(this.id, this.information);
}