import 'package:hive/hive.dart';

import '../entities/user/user.dart';

class RpUser {

  Future<User?> getUser() async {
    var box = await Hive.openBox<User>('user');
    return box.get(0);
  }

  Future<void> saveUser(User user) async {
    var box = await Hive.openBox<User>('user');
    await box.put(0, user);
  }
}