part of ednet_core;

abstract class EntityApi<E extends EntityApi<E>> implements Comparable {
  Concept? get concept;

  ValidationExceptionsApi get exceptions;

  Oid get oid;

  IdApi get id;

  String? get code;

  /// Log
  DateTime? whenAdded;
  DateTime? whenSet;
  DateTime? whenRemoved;

  Object? getAttribute(String attributeCode);

  bool preSetAttribute(String name, Object value);

  bool setAttribute(String name, Object value);

  bool postSetAttribute(String name, Object value);

  String getStringFromAttribute(String name);

  String? getStringOrNullFromAttribute(String name);

  bool setStringToAttribute(String name, String string);

  EntityApi? getParent(String name);

  bool setParent(String name, entity);

  EntitiesApi? getChild(String name);

  bool setChild(String name, EntitiesApi<E> entities);

  E copy();

  String toJson();

  void fromJson(String entityJson);
}
