part of ednet_core;

class SetAttributeAction extends EntityAction {
  SetAttributeAction(DomainSession session, ConceptEntity entity,
      String property, Object after)
      : super(session, entity, property, after) {
    category = 'attribute';
  }
}
