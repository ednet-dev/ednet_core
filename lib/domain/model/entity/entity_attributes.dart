part of entities;

class EntityAttributes with Serializable {
  final List<EntityAttribute> attributes;

  EntityAttributes({required this.attributes});

  getAttributesByType(String type) {
    return attributes.where((attribute) => attribute.type == type).toList();
  }

  getAttributeByName(String name) {
    return attributes.firstWhere((attribute) => attribute.name == name);
  }

  getValueByName(String name) {
    return getAttributeByName(name).value;
  }

  getAttributesNames() {
    return attributes.map((attribute) => attribute.name).toList();
  }

  @override
  toJson() {
    return {
      'attributes': attributes.map((attribute) => attribute.toJson()).toList(),
    };
  }
}

/// Attributes have form of name and value pair
/// Example:
/// {
///  "name": "John",
///  "age": 30,
///  "isMarried": true
///  }

class EntityAttribute<T> with Serializable {
  final String name;
  final String type;
  final T value;

  EntityAttribute(
      {required this.name, required this.type, required this.value});

  static fromJSon(attributeJSon) {
    return EntityAttribute(
      name: attributeJSon['name'],
      type: attributeJSon['type'],
      value: attributeJSon['value'],
    );
  }

  get toJsonString => '"$name": "$value"';

  @override
  toJson() {
    return {
      "name": name,
      "type": type,
      "value": value,
    };
  }

  static fromJson(json) {
    return EntityAttribute(
      name: json['name'],
      type: json['type'],
      value: json['value'],
    );
  }

  static fromYaml(Map<dynamic, dynamic> yaml) {
    return EntityAttribute(
      name: yaml['name'],
      type: yaml['type'],
      value: yaml['value'],
    );
  }
}