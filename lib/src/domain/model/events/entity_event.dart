abstract class EntityEvent {
  String get topic;

  set topic(String value);

  String get id;

  set id(String value);

  String get name;

  set name(String value);

  String get description;

  set description(String value);

  String get type;

  set type(String value);

  String get version;

  set version(String value);

  String get source;

  set source(String value);

  DateTime get time;

  set time(DateTime value);

  Map<String, Object> get data;

  set data(Map<String, Object> value);
}
