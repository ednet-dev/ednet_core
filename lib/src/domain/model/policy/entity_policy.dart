import '../serializable.dart';

class EntityPolicy with Serializable {
  String id;
  String name;
  String? description;
  String type;
  String version;

  EntityPolicy({
    required this.id,
    required this.name,
    required this.type,
    required this.version,
  });

  static fromJson(Map<String, dynamic> json) {
    return EntityPolicy(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      version: json['version'],
    );
  }

  @override
  toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'version': version,
    };
  }
}
