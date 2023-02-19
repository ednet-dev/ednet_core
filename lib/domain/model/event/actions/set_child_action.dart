part of ednet_core;

class SetChildAction extends EntityAction {
  SetChildAction(DomainSession session, Entity entity, String property,
      Object after)
      : super(session, entity, property, after) {
    category = 'child';
  }
}
