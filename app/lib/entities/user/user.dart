
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String password;
  @HiveField(3)
  String phone;

  User(this.id,this.name, this.password, this.phone);
}