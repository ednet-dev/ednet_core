import '../entities.dart';

abstract class EntityIdentity
    implements
        EntityId,
        EntityName,
        EntityDescription,
        EntityTags,
        EntityAttributes {}
