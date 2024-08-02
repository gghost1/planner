
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String password;
  @HiveField(2)
  String phone;

  User(this.name, this.password, this.phone);
}