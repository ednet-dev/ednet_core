part of ednet_core;

class RemoveAction extends EntitiesAction {
  RemoveAction(DomainSession session, Entities entities, ConceptEntity entity)
      : super('remove', session, entities, entity) {
    category = 'entity';
  }
}
