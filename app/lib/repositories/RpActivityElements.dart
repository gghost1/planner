import 'dart:collection';

import 'package:app/entities/elements/activityElement.dart';

import 'db/dbInit.dart';

class RpActivityElements {

  HashMap<String, dynamic> boxes;

  RpActivityElements(this.boxes);

  Future<List<ActivityElement>> getElementsByActivity(String activityId) async {
    var box;
    box = boxes['activityelements'];
    List<String> elementsId = box.get(0)![activityId]!;

    box = boxes['elements'];
    List<ActivityElement> activityElements = [];
    for (var elementId in elementsId) {
      activityElements.add(box.get(0)![elementId]!);
    }
    return activityElements;
  }

  Future<void> saveElement(ActivityElement element, String activityId) async {
    var box;
    box = boxes['elements'];
    HashMap<String, ActivityElement> elements = box.get(0)!;
    elements.addEntries([MapEntry(element.id, element)]);
    await box.put(0, elements);

    box = boxes['activityelements'];
    HashMap<String, List<String>> activityElements = box.get(0)!;
    activityElements.addEntries([MapEntry(activityId, [element.id])]);
    box.put(0, activityElements);
  }

}