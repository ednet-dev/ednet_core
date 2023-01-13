import 'package:ednet_core/ednet_core.dart';

import '../serializable.dart';

class EntityCommand with Serializable {
  EntityCommand({
    required this.name,
    required this.parameters,
  });

  final String name;
  final List<EntityAttribute> parameters;

  factory EntityCommand.fromYaml(Map<dynamic, dynamic> yaml) {
    final parameters = yaml['parameters']
        .map((parameterYaml) => EntityAttribute.fromYaml(parameterYaml))
        .toList();
    return EntityCommand(
      name: yaml['name'],
      parameters: parameters,
    );
  }

  fromJsonFactory(Map<String, dynamic> json) {
    return EntityCommand(
      name: json['name'],
      parameters: json['parameters'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'parameters': parameters.map((e) => e.toJson()).toList(),
    };
  }

  static fromJson(Map<String, dynamic> json) {
    return EntityCommand(
      name: json['name'],
      parameters: json['parameters'],
    );
  }

// void validateParameters(Map<String, dynamic> parameters) {
//   if (parameters.isEmpty) {
//     throw Exception("Parameters must be provided");
//   }
//   parameters.forEach((key, value) {
//     final parameter = this.parameters.firstWhere(
//           (parameter) => parameter.name == key,
//           orElse: () => EntityAttribute(
//               name: 'Default',
//               type: EntityAttributeType.label,
//               format: EntityAttributeFormat.short,
//               value: 'N/A'),
//         );
//
//     if (value == null) {
//       throw Exception("Parameter $key must be provided");
//     }
//   });
// }
}
