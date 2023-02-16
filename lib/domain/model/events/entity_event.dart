part of ednet_core;

class EntityEvent {
  String topic;
  String id;
  String name;
  String? description;
  String type;
  String version;
  String source;
  DateTime time = DateTime.now();
  Map<String, Object> data;

  EntityEvent({
    required this.topic,
    required this.id,
    required this.name,
    this.description,
    required this.type,
    required this.version,
    required this.source,
    required this.time,
    required this.data,
  });

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

  static fromJson(Map<String, dynamic> json) {
    return EntityEvent(
      topic: json['topic'],
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      version: json['version'],
      source: json['source'],
      time: json['time'],
      data: json['data'],
    );
  }
}
