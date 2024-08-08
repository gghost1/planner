import 'dart:collection';

import 'package:app/entities/activities/activity.dart';
import 'package:app/repositories/db/dbInit.dart';

import '../entities/chats/chat.dart';

class RpActivity {

  HashMap<String, dynamic> boxes;

  RpActivity(this.boxes);

  Future<List<Activity>?> getActivities() async {
    var box = boxes['activities'];
    return box.get(0)?.values.toList();
  }

  Future<Activity?> getActivityById(String id) async {
    var box = boxes['activities'];
    return box.get(0)?[id];
  }

  Future<Activity?> getActivityByChat(String chatId) async {
    var box;
    box = boxes['activitychat'];
    HashMap<String, String>? activityChat = box.get(0);
    String? activityId;
    activityChat?.forEach((key, value) {
      if (value == chatId) {
        activityId = key;
        return;
      }
    });
    box = boxes['activities'];
    return box.get(0)?[activityId];
  }

  Future<void> saveActivity(Activity activity) async {
    var box;
    box = boxes['activities'];
    HashMap<String, Activity>? activities = box.get(0);
    activities?.addEntries([MapEntry(activity.id, activity)]);
    box.put(0, activities!);

    box = boxes['activityelements'];
    HashMap<String, List<String>>? elements = box.get(0);
    elements?.addEntries([MapEntry(activity.id, [])]);
    box.put(0, elements!);
  }

}