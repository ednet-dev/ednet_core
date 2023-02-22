part of ednet_core;

class Attributes extends Entities<Property> {
  @override
  List<Attribute> toList({bool growable = true}) {
    var attributeList = <Attribute>[];
    for (var attribute in this) {
      attributeList.add(attribute as Attribute);
    }
    return attributeList;
  }
}

