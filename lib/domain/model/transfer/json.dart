part of ednet_core;

Model? fromJsonToModel(String json, Domain domain, String modelCode) {
  if (json.trim() == '') {
    return null;
  }
  Map<String, Object> boardMap = jsonDecode(json);
  List<Map<String, Object>> boxes =
      boardMap["boxes"] as List<Map<String, Object>>;
  List<Map<String, Object>> lines =
      boardMap["lines"] as List<Map<String, Object>>;

  Model model = Model(domain, modelCode);

  for (Map<String, Object> box in boxes) {
    String conceptCode = box["name"] as String;
    bool conceptEntry = box["entry"] as bool;
    Concept concept = Concept(model, conceptCode);
    concept.entry = conceptEntry;

    List<Map<String, Object>> items = box["items"] as List<Map<String, Object>>;
    for (Map<String, Object> item in items) {
      String attributeCode = item["name"] as String;
      if (attributeCode != 'oid' && attributeCode != 'code') {
        Attribute attribute = Attribute(concept, attributeCode);
        String itemCategory = item["category"] as String;
        if (itemCategory == 'guid') {
          attribute.guid = true;
        } else if (itemCategory == 'identifier') {
          attribute.identifier = true;
        } else if (itemCategory == 'required') {
          attribute.minc = '1';
        }
        int itemSequence = item["sequence"] as int;
        attribute.sequence = itemSequence;
        String itemInit = item["init"] as String;
        if (itemInit.trim() == '') {
          attribute.init = null;
        } else if (itemInit == 'increment') {
          attribute.increment = 1;
          attribute.init = null;
        } else if (itemInit == 'empty') {
          attribute.init = '';
        } else {
          attribute.init = itemInit;
        }
        bool itemEssential = item["essential"] as bool;
        attribute.essential = itemEssential;
        bool itemSensitive = item["sensitive"] as bool;
        attribute.sensitive = itemSensitive;
        String itemType = item["type"] as String;
        AttributeType? type = domain.types.singleWhereCode(itemType);
        if (type != null) {
          attribute.type = type;
        } else {
          attribute.type = domain.getType('String');
        }
      }
    }
  }

  for (Map<String, Object> line in lines) {
    String box1Name = line["box1Name"] as String;
    String box2Name = line["box2Name"] as String;

    Concept? concept1 = model.concepts.singleWhereCode(box1Name);
    Concept? concept2 = model.concepts.singleWhereCode(box2Name);
    if (concept1 == null) {
      throw ConceptException('Line concept is missing for the $box1Name box.');
    }
    if (concept2 == null) {
      throw ConceptException('Line concept is missing for the $box2Name box.');
    }

    String box1box2Name = line["box1box2Name"] as String;
    String box1box2Min = line["box1box2Min"] as String;
    String box1box2Max = line["box1box2Max"] as String;
    bool box1box2Id = line["box1box2Id"] as bool;

    String box2box1Name = line["box2box1Name"] as String;
    String box2box1Min = line["box2box1Min"] as String;
    String box2box1Max = line["box2box1Max"] as String;
    bool box2box1Id = line["box2box1Id"] as bool;

    bool lineInternal = line["internal"] as bool;
    String lineCategory = line["category"] as String;

    bool d12Child;
    bool d21Child;
    bool d12Parent;
    bool d21Parent;

    if (box1box2Max != '1') {
      d12Child = true;
      if (box2box1Max != '1') {
        d21Child = true;
      } else {
        d21Child = false;
      }
    } else if (box2box1Max != '1') {
      d12Child = false;
      d21Child = true;
    } else if (box1box2Min == '0') {
      d12Child = true;
      d21Child = false;
    } else if (box2box1Min == '0') {
      d12Child = false;
      d21Child = true;
    } else {
      d12Child = true;
      d21Child = false;
    }

    d12Parent = !d12Child;
    d21Parent = !d21Child;

    if (d12Child && d21Child) {
      throw Exception('$box1Name -- $box2Name line has two children.');
    }
    if (d12Parent && d21Parent) {
      throw Exception('$box1Name -- $box2Name line has two parents.');
    }

    Neighbor neighbor12;
    Neighbor neighbor21;

    if (d12Child && d21Parent) {
      neighbor12 = Child(concept1, concept2, box1box2Name);
      neighbor21 = Parent(concept2, concept1, box2box1Name);

      neighbor12.opposite = neighbor21;
      neighbor21.opposite = neighbor12;

      neighbor12.minc = box1box2Min;
      neighbor12.maxc = box1box2Max;
      neighbor12.identifier = box1box2Id;

      neighbor21.minc = box2box1Min;
      neighbor21.maxc = box2box1Max;
      neighbor21.identifier = box2box1Id;

      neighbor12.internal = lineInternal;
      if (lineCategory == 'inheritance') {
        neighbor12.inheritance = true;
      } else if (lineCategory == 'reflexive') {
        neighbor12.reflexive = true;
      } else if (lineCategory == 'twin') {
        neighbor12.twin = true;
      }

      neighbor21.internal = lineInternal;
      if (lineCategory == 'inheritance') {
        neighbor21.inheritance = true;
      } else if (lineCategory == 'reflexive') {
        neighbor21.reflexive = true;
      } else if (lineCategory == 'twin') {
        neighbor21.twin = true;
      }
    } else if (d12Parent && d21Child) {
      neighbor12 = Parent(concept1, concept2, box1box2Name);
      neighbor21 = Child(concept2, concept1, box2box1Name);

      neighbor12.opposite = neighbor21;
      neighbor21.opposite = neighbor12;

      neighbor12.minc = box1box2Min;
      neighbor12.maxc = box1box2Max;
      neighbor12.identifier = box1box2Id;

      neighbor21.minc = box2box1Min;
      neighbor21.maxc = box2box1Max;
      neighbor21.identifier = box2box1Id;

      neighbor12.internal = lineInternal;
      if (lineCategory == 'inheritance') {
        neighbor12.inheritance = true;
      } else if (lineCategory == 'reflexive') {
        neighbor12.reflexive = true;
      } else if (lineCategory == 'twin') {
        neighbor12.twin = true;
      }

      neighbor21.internal = lineInternal;
      if (lineCategory == 'inheritance') {
        neighbor21.inheritance = true;
      } else if (lineCategory == 'reflexive') {
        neighbor21.reflexive = true;
      } else if (lineCategory == 'twin') {
        neighbor21.twin = true;
      }
    }
  }

  return model;
}
