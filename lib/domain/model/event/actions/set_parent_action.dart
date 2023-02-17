part of ednet_core;

class SetParentAction extends EntityAction {
  SetParentAction(DomainSession session, ConceptEntity entity, String property,
      Object after)
      : super(session, entity, property, after) {
    category = 'parent';
  }
}
