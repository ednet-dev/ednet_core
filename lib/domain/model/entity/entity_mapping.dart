part of ednet_core;

// abstract class EntityMapping extends Entity {
// //   factory EntityMapping.fromYaml(Map<dynamic, dynamic> yaml) {
// //     final attributes = yaml['attributes']
// //         .map((attributeYaml) => EntityAttribute.fromYaml(attributeYaml))
// //         .toList();
// //     final commands = yaml['commands']
// //         .map((commandYaml) => EntityCommand.fromYaml(commandYaml, attributes))
// //         .toList();
// //     final policies = yaml['policies']
// //         .map((policyYaml) => Policy.fromYaml(policyYaml))
// //         .toList();
// //     final events =
// //         yaml['events'].map((eventYaml) => Event.fromYaml(eventYaml)).toList();
// //     return Entities(
// //         name: yaml['name'],
// //         attributes: attributes,
// //         commands: commands,
// //         policies: policies,
// //         events: events);
// //   }
// //
// //   Entities({required this.name, required this.attributes}) {
// //     _validateName();
// //     _validateAttributes();
// //   }
// //
// //   void _validateName() {
// //     if (name == null || name.isEmpty) {
// //       throw Exception("Entity name must be provided");
// //     }
// //   }
// //
// //   void _validateAttributes() {
// //     if (attributes == null || attributes.isEmpty) {
// //       throw Exception("Entity must have at least one attribute");
// //     }
// //     attributes.forEach((attribute) {
// //       if (attribute.name == null || attribute.name.isEmpty) {
// //         throw Exception("Attribute name must be provided");
// //       }
// //       if (attribute.type == null) {
// //         throw Exception("attribute type must be provided");
// //       }
// //     });
// //   }
// //
// //   @override
// //   String description;
// //
// //   @override
// //   String id;
// //
// //   @override
// //   List<EntityEvent> interests;
// //
// //   @override
// //   List<String> tags;
// //
// //   @override
// //   List<EntityEvent> topics;
// //
// //   @override
// //   set attributes(Map<String, Object> value) {
// //     // TODO: implement attributes
// //   }
// //
// //   @override
// //   set commands(List<EntityCommand> value) {
// //     // TODO: implement commands
// //   }
// //
// //   @override
// //   set name(String value) {
// //     // TODO: implement name
// //   }
// //
// //   @override
// //   set policies(List<EntityPolicy> value) {
// //     // TODO: implement policies
// //   }
// //
// // // other methods and properties
// }
