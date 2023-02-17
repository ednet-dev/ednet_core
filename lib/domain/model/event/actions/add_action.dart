part of ednet_core;

class AddAction extends EntitiesAction {
  AddAction(DomainSession session, Entities entities, ConceptEntity entity)
      : super('add', session, entities, entity) {
    category = 'entity';
  }
}

