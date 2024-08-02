import 'package:app/repositories/db/dbInit.dart';

import 'package:app/entities/user/user.dart';
class RpUser {

  static Future<void> saveUser(User user) async {
    var box = await DbInit.userBox();
    box.add(user);
  }

  static Future<User?> getUser() async {
    var box = await DbInit.userBox();
    return box.get(0);
  }

}