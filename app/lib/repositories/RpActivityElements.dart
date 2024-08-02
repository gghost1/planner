import 'package:app/entities/elements/activityElement.dart';

import 'db/dbInit.dart';

class RpActivityElements {

  static Future<List<ActivityElement>?> getElementsByActivity(String activityId) async {
    var box;
    box = await DbInit.activityElementBox();
    List<String>? elementsId = box.get(0)?[activityId];

    box = await DbInit.elementBox();
    List<ActivityElement> activityElements = [];
    elementsId?.forEach((elementId) {
      activityElements.add(box.get(0)?[elementId]);
    });
    return activityElements;
  }

  static Future<void> saveElement(ActivityElement element, String activityId) async {
    var box;
    box = await DbInit.activityElementBox();
    box.getAt(0)?.addEntries([MapEntry(element.id, element)]);

    box = await DbInit.activityElementBox();
    box.get(0)?[activityId].add(element);
  }

}