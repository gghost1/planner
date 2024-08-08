import 'dart:collection';

import 'package:app/repositories/db/dbInit.dart';

import 'package:app/entities/user/user.dart';
class RpUser {

  HashMap<String, dynamic> boxes;

  RpUser(this.boxes);

  Future<void> saveUser(User user) async {
    var box = boxes['user'];
    await box.put(0, user);
  }

  Future<User?> getUser() async {
    var box = boxes['user'];
    return box.get(0);
  }

}