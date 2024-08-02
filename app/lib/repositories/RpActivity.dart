import 'dart:collection';

import 'package:app/entities/activities/activity.dart';
import 'package:app/repositories/db/dbInit.dart';

import '../entities/chats/chat.dart';

class RpActivity {

  static Future<List<Activity>?> getActivities() async {
    var box = await DbInit.activityBox();
    return box.get(0)?.values.toList();
  }

  static Future<Activity?> getActivityById(String id) async {
    var box = await DbInit.activityBox();
    return box.get(0)?[id];
  }

  static Future<Activity> getActivityByChat(String chatId) async {
    var box;
    box = await DbInit.activityChatBox();
    String activityId = box.get(0)?.forEach((key, value) {
      if (value == chatId) {
        return key;
      }
    });
    box = await DbInit.activityBox();
    return box.get(0)?[activityId];
  }

  static Future<void> saveActivity(Activity activity) async {
    var box;
    box = await DbInit.activityBox();
    HashMap<String, Activity>? activities = box.get(0);
    activities?.addEntries([MapEntry(activity.id, activity)]);
    box.put(0, activities!);

    box = await DbInit.activityElementBox();
    HashMap<String, List<String>>? elements = box.get(0);
    elements?.addEntries([MapEntry(activity.id, [])]);
    box.put(0, elements!);
  }

}