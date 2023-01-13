import '../policies.dart';

abstract class EntityPolicies {
  List<EntityPolicy> get policies;

  set policies(List<EntityPolicy> value);
}
