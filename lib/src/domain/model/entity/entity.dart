import '../commands.dart';
import '../entities.dart';
import '../events.dart';
import '../policies.dart';

abstract class Entity
    implements
        EntityIdentity,
        EntityEvents,
        EntityCommands,
        EntityPolicies,
        EntityAttributes {
  final List<Entity> children = <Entity>[];

  // add remove and access children
  void addChild(Entity child) {
    children.add(child);
  }

  void removeChild(Entity child) {
    children.remove(child);
  }

  Entity getChild(String id) {
    return children.firstWhere((element) => element.id == id);
  }

  List<Entity> getChildren() {
    return children;
  }

  List<Entity> getChildrenByTypeName(String type) {
    return children.where((element) => element.name == type).toList();
  }

  // get attributes
  EntityAttribute getAttribute(String name) {
    return attributes.firstWhere((element) => element.name == name);
  }

  // get all attributes
  getAttributes() {
    return attributes;
  }

  void _validateCommands() {
    if (commands.isEmpty) {
      throw Exception("Aggregate root must have at least one command");
    }
    for (EntityCommand command in commands) {
      if (command.name.isEmpty) {
        throw Exception("Command name must be provided");
      }
    }
  }

  void _validatePolicies() {
    for (EntityPolicy policy in policies) {
      if (policy.name.isEmpty) {
        throw Exception("Policy name must be provided");
      }
    }
  }

  void _validateTopics() {
    for (EntityEvent event in topics) {
      if (event.name.isEmpty) {
        throw Exception("Event name must be provided");
      }
    }
  }

  void _validateInterests() {
    for (EntityEvent event in interests) {
      if (event.name.isEmpty) {
        throw Exception("Event name must be provided");
      }
    }
  }

  void _validateAttributes() {
    for (EntityAttribute attribute in attributes) {
      if (attribute.name.isEmpty) {
        throw Exception("Attribute name must be provided");
      }
    }
  }
}
