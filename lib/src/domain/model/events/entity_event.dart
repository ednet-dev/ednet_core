import '../serializable.dart';

abstract class EntityEvent with Serializable {
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'version': version,
      'source': source,
      'time': time,
      'data': data,
    };
  }
}
