part of ednet_core;

class RemoveAction extends EntitiesAction {
  RemoveAction(DomainSession session, Entities entities, Entity entity)
      : super('remove', session, entities, entity) {
    category = 'entity';
  }
}
