import '../events.dart';

abstract class EntityEvents {
  List<EntityEvent> get topics;

  set topics(List<EntityEvent> value);

  List<EntityEvent> get interests;

  set interests(List<EntityEvent> value);
}
