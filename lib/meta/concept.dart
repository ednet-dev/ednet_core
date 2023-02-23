part of ednet_core;

class Concept extends Entity<Concept> {
  bool entry = true;
  bool abstract = false;

  String min = '0';
  String max = 'N';

  bool updateOid = false;
  bool updateCode = false;
  bool updateWhen = false;
  bool add = true;
  bool remove = true;
  late String description;

  // to allow for a specific plural name, different from
  // the plural name derivation in ConceptEntity
  String? _codes; // code (in) plural
  String? _codesFirstLetterLower;
  String? _codesLowerUnderscore; // lower letters and underscore separator
  String? label;
  String? labels;

  Model model;

  late Attributes attributes;
  late Parents parents; // destination parent neighbors
  late Children children; // destination child neighbors

  late Parents sourceParents;
  late Children sourceChildren;

  Concept(this.model, String conceptCode) {
    code = conceptCode;
    model.concepts.add(this);

    attributes = Attributes();

    parents = Parents();
    children = Children();

    sourceParents = Parents();
    sourceChildren = Children();
  }

  @override
  set code(String? code) {
    super.code = code;
    label ??= camelCaseSeparator(code!, ' ');
    labels ??= camelCaseSeparator(codes, ' ');
  }

  @override
  int get hashCode => _oid.hashCode;

  /// Two concepts are equal if their oids are equal.
  @override
  bool equals(Concept concept) {
    if (_oid.equals(concept.oid)) {
      return true;
    }
    return false;
  }

  /// == see:
  /// https://www.dartlang.org/docs/dart-up-and-running/contents/ch02.html#op-equality
  ///
  /// Evolution:
  ///
  /// If x===y, return true.
  /// Otherwise, if either x or y is null, return false.
  /// Otherwise, return the result of x.equals(y).
  ///
  /// The newest spec is:
  /// a) if either x or y is null, do identical(x, y)
  /// b) otherwise call operator ==
  @override
  bool operator ==(Object other) {
    if (other is Concept) {
      Concept concept = other;
      if (identical(this, concept)) {
        return true;
      } else {
        return equals(concept);
      }
    } else {
      return false;
    }
  }

  String get codes {
    _codes ??= plural(_code!);
    return _codes!;
  }

  set codes(String codes) {
    _codes = codes;
  }

  String get codesFirstLetterLower {
    _codesFirstLetterLower ??= firstLetterLower(codes);
    return _codesFirstLetterLower!;
  }

  set codesFirstLetterLower(String codesFirstLetterLower) {
    _codesFirstLetterLower = codesFirstLetterLower;
  }

  String get codesLowerUnderscore {
    _codesLowerUnderscore ??= camelCaseLowerSeparator(codes, '_');
    return _codesLowerUnderscore!;
  }

  set codesLowerUnderscore(String codesLowerUnderscore) {
    _codesLowerUnderscore = codesLowerUnderscore;
  }

  @override
  Attribute? getAttribute<Attribute>(String attributeCode) =>
      attributes.singleWhereCode(attributeCode) as Attribute?;

  Parent? getDestinationParent(String parentCode) =>
      parents.singleWhereCode(parentCode) as Parent?;

  Child? getDestinationChild(String childCode) =>
      children.singleWhereCode(childCode) as Child?;

  Parent? getSourceParent(String parentCode) =>
      sourceParents.singleWhereCode(parentCode) as Parent?;

  Child? getSourceChild(String childCode) =>
      sourceChildren.singleWhereCode(childCode) as Child?;

  List<Attribute> get requiredAttributes {
    var requiredList = <Attribute>[];
    for (Attribute attribute in attributes as Iterable) {
      if (attribute.required) {
        requiredList.add(attribute);
      }
    }
    return requiredList;
  }

  List<Attribute> get identifierAttributes {
    var identifierList = <Attribute>[];
    for (Attribute attribute in attributes as Iterable) {
      if (attribute.identifier) {
        identifierList.add(attribute);
      }
    }
    return identifierList;
  }

  List<Attribute> get nonIdentifierAttributes {
    var nonIdentifierList = <Attribute>[];
    for (Attribute attribute in attributes as Iterable) {
      if (!attribute.identifier) {
        nonIdentifierList.add(attribute);
      }
    }
    return nonIdentifierList;
  }

  List<Attribute> get incrementAttributes {
    var incrementList = <Attribute>[];
    for (Attribute attribute in attributes as Iterable) {
      if (attribute.increment != null) {
        incrementList.add(attribute);
      }
    }
    return incrementList;
  }

  List<Attribute> get nonIncrementAttributes {
    var nonIncrementList = <Attribute>[];
    for (Attribute attribute in attributes as Iterable) {
      if (attribute.increment == null) {
        nonIncrementList.add(attribute);
      }
    }
    return nonIncrementList;
  }

  List<Attribute> get essentialAttributes {
    var essentialList = <Attribute>[];
    for (Attribute attribute in attributes as Iterable) {
      if (attribute.essential) {
        essentialList.add(attribute);
      }
    }
    return essentialList;
  }

  List<Parent> get externalParents {
    var externalList = <Parent>[];
    for (Parent parent in parents as Iterable) {
      if (parent.external) {
        externalList.add(parent);
      }
    }
    return externalList;
  }

  List<Parent> get externalRequiredParents {
    var externalRequiredList = <Parent>[];
    for (Parent parent in parents as Iterable) {
      if (parent.external && parent.required) {
        externalRequiredList.add(parent);
      }
    }
    return externalRequiredList;
  }

  List<Child> get internalChildren {
    var internalList = <Child>[];
    for (Child child in children as Iterable) {
      if (child.internal) {
        internalList.add(child);
      }
    }
    return internalList;
  }

  List<Property> get singleValueProperties {
    var propertyList = <Property>[];
    propertyList.addAll(attributes.toList());
    propertyList.addAll(parents.toList());
    return propertyList;
  }

  bool get hasTwinParent {
    for (Parent parent in parents as Iterable) {
      if (parent.twin) {
        return true;
      }
    }
    return false;
  }

  bool get hasReflexiveParent {
    for (Parent parent in parents as Iterable) {
      if (parent.reflexive) {
        return true;
      }
    }
    return false;
  }

  bool get hasTwinChild {
    for (Child child in children as Iterable) {
      if (child.twin) {
        return true;
      }
    }
    return false;
  }

  bool get hasReflexiveChild {
    for (Child child in children as Iterable) {
      if (child.reflexive) {
        return true;
      }
    }
    return false;
  }

  bool get hasId {
    for (Property property in singleValueProperties) {
      if (property.identifier) {
        return true;
      }
    }
    return false;
  }

  bool get hasAttributeId {
    for (Attribute attribute in attributes as Iterable) {
      if (attribute.identifier) {
        return true;
      }
    }
    return false;
  }

  bool get hasParentId {
    for (Parent parent in parents as Iterable) {
      if (parent.identifier) {
        return true;
      }
    }
    return false;
  }

  @override
  Id get id {
    return Id(this);
  }

  bool isAttributeSensitive(String attributeCode) {
    Attribute? a = attributes.singleWhereCode(attributeCode) as Attribute?;
    return a != null && a.sensitive ? true : false;
  }

  bool isParentSensitive(String parentCode) {
    Parent? p = parents.singleWhereCode(parentCode) as Parent?;
    return p != null && p.sensitive ? true : false;
  }

  bool isChildSensitive(String childCode) {
    Child? c = children.singleWhereCode(childCode) as Child?;
    return c != null && c.sensitive ? true : false;
  }

  bool isPropertySensitive(String propertyCode) {
    return isAttributeSensitive(propertyCode) ||
        isParentSensitive(propertyCode) ||
        isChildSensitive(propertyCode);
  }

  Concept get entryConcept {
    if (entry) {
      return this;
    } else {
      for (Parent parent in parents as Iterable) {
        if (parent.internal) {
          return parent.destinationConcept.entryConcept;
        }
      }
      throw ParentException('No internal parent for the $code concept');
    }
  }

  String get entryConceptThisConceptInternalPath {
    if (entry) {
      return code;
    } else {
      for (Parent parent in parents as Iterable) {
        if (parent.internal) {
          return '${parent.destinationConcept.entryConceptThisConceptInternalPath}'
              '$code';
        }
      }
      throw ParentException('No internal parent for the $code concept');
    }
  }

  List<String> get childCodeInternalPaths {
    var childList = <String>[];
    for (Child child in children as Iterable) {
      Concept sourceConcept = child.sourceConcept;
      String entryConceptSourceConceptInternalPath =
          sourceConcept.entryConceptThisConceptInternalPath;
      Concept destinationConcept = child.destinationConcept;
      String childCodeInternalPath = '$entryConceptSourceConceptInternalPath'
          '_${child.code}_${destinationConcept.code}';
      childList.add(childCodeInternalPath);
      if (!child.reflexive) {
        childList.addAll(child.destinationConcept.childCodeInternalPaths);
      }
    }
    return childList;
  }
}
