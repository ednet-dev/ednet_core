part of ednet_core;

abstract class ActionApi {
  bool get done;

  bool get undone;

  bool get redone;

  bool doIt();

  bool undo();

  bool redo();
}

abstract class TransactionApi extends ActionApi {
  void add(ActionApi action);

  PastApi get past;
}

abstract class BasicAction implements ActionApi {
  final String name;
  late String category;
  String state = 'started';
  String? description;
  final DomainSession session;
  bool partOfTransaction = false;

  BasicAction(this.name, this.session);

  @override
  bool doIt();

  @override
  bool undo();

  @override
  bool redo();

  bool get started => state == 'started' ? true : false;

  @override
  bool get done => state == 'done' ? true : false;

  @override
  bool get undone => state == 'undone' ? true : false;

  @override
  bool get redone => state == 'redone' ? true : false;

  @override
  toString() => 'action: $name; state: $state -- description: $description';

  display({String title: 'BasicAction'}) {
    print('');
    print('======================================');
    print('$title                                ');
    print('======================================');
    print('');
    print('$this');
    print('');
  }
}

abstract class EntitiesAction extends BasicAction {
  Entities entities;
  ConceptEntity entity;

  EntitiesAction(String name, DomainSession session, this.entities, this.entity)
      : super(name, session);

  @override
  bool doIt() {
    bool done = false;
    if (state == 'started') {
      if (name == 'add') {
        done = entities.add(entity);
      } else if (name == 'remove') {
        done = entities.remove(entity);
      } else {
        throw ActionException(
            'Allowed actions on entities for doit are add or remove.');
      }
      if (done) {
        state = 'done';
        if (!partOfTransaction) {
          session.past.add(this);
          session.domainModels.notifyActionReactions(this);
        }
      }
    }
    return done;
  }

  @override
  bool undo() {
    bool undone = false;
    if (state == 'done' || state == 'redone') {
      if (name == 'add') {
        undone = entities.remove(entity);
      } else if (name == 'remove') {
        undone = entities.add(entity);
      } else {
        throw ActionException(
            'Allowed actions on entities for undo are add or remove.');
      }
      if (undone) {
        state = 'undone';
        if (!partOfTransaction) {
          session.domainModels.notifyActionReactions(this);
        }
      }
    }
    return undone;
  }

  @override
  bool redo() {
    bool redone = false;
    if (state == 'undone') {
      if (name == 'add') {
        redone = entities.add(entity);
      } else if (name == 'remove') {
        redone = entities.remove(entity);
      } else {
        throw ActionException(
            'Allowed actions on entities for redo are add or remove.');
      }
      if (redone) {
        state = 'redone';
        if (!partOfTransaction) {
          session.domainModels.notifyActionReactions(this);
        }
      }
    }
    return redone;
  }
}

class AddAction extends EntitiesAction {
  AddAction(DomainSession session, Entities entities, ConceptEntity entity)
      : super('add', session, entities, entity) {
    category = 'entity';
  }
}

class RemoveAction extends EntitiesAction {
  RemoveAction(DomainSession session, Entities entities, ConceptEntity entity)
      : super('remove', session, entities, entity) {
    category = 'entity';
  }
}

abstract class EntityAction extends BasicAction {
  ConceptEntity entity;
  String property;
  Object before;
  Object after;

  EntityAction(DomainSession session, this.entity, this.property, this.after)
      : before = entity.getAttribute(property),
        super('set', session);

  @override
  bool doIt() {
    bool done = false;
    if (state == 'started') {
      if (name == 'set' && category == 'attribute') {
        done = entity.setAttribute(property, after);
      } else if (name == 'set' && category == 'parent') {
        done = entity.setParent(property, after);
      } else if (name == 'set' && category == 'child') {
        done = entity.setChild(property, after);
      } else {
        throw ActionException(
            'Allowed actions on entity for doit are set attribute, parent or child.');
      }
      if (done) {
        state = 'done';
        if (!partOfTransaction) {
          session.past.add(this);
          session.domainModels.notifyActionReactions(this);
        }
      }
    }
    return done;
  }

  @override
  bool undo() {
    bool undone = false;
    if (state == 'done' || state == 'redone') {
      if (name == 'set' && category == 'attribute') {
        undone = entity.setAttribute(property, before);
      } else if (name == 'set' && category == 'parent') {
        undone = entity.setParent(property, before as ConceptEntity);
      } else if (name == 'set' && category == 'child') {
        undone = entity.setChild(property, before);
      } else {
        throw ActionException(
            'Allowed actions on entity for undo are set attribute, parent or child.');
      }
      if (undone) {
        state = 'undone';
        if (!partOfTransaction) {
          session.domainModels.notifyActionReactions(this);
        }
      }
    }
    return undone;
  }

  @override
  bool redo() {
    bool redone = false;
    if (state == 'undone') {
      if (name == 'set' && category == 'attribute') {
        redone = entity.setAttribute(property, after);
      } else if (name == 'set' && category == 'parent') {
        redone =
            entity.setParent(property, after as ConceptEntity<ConceptEntity>);
      } else if (name == 'set' && category == 'child') {
        redone = entity.setChild(property, after as Entities<ConceptEntity>);
      } else {
        throw ActionException(
            'Allowed actions on entity for redo are set attribute, parent or child.');
      }
      if (redone) {
        state = 'redone';
        if (!partOfTransaction) {
          session.domainModels.notifyActionReactions(this);
        }
      }
    }
    return redone;
  }

  @override
  toString() => 'action: $name; category: $category; state: $state -- '
      'property: $property; before: $before; after: $after';
}

class SetAttributeAction extends EntityAction {
  SetAttributeAction(DomainSession session, ConceptEntity entity,
      String property, Object after)
      : super(session, entity, property, after) {
    category = 'attribute';
  }
}

class SetParentAction extends EntityAction {
  SetParentAction(DomainSession session, ConceptEntity entity, String property,
      Object after)
      : super(session, entity, property, after) {
    category = 'parent';
  }
}

class SetChildAction extends EntityAction {
  SetChildAction(DomainSession session, ConceptEntity entity, String property,
      Object after)
      : super(session, entity, property, after) {
    category = 'child';
  }
}

class Transaction extends BasicAction implements TransactionApi {
  final Past _actions;

  Transaction(String name, DomainSession session)
      : _actions = Past(),
        super(name, session);

  @override
  Past get past => _actions;

  @override
  void add(BasicAction action) {
    _actions.add(action);
    action.partOfTransaction = true;
  }

  @override
  bool doIt() {
    bool done = false;
    if (state == 'started') {
      done = _actions.doAll();
      if (done) {
        state = 'done';
        session.past.add(this);
        session.domainModels.notifyActionReactions(this);
      } else {
        _actions.undoAll();
      }
    }
    return done;
  }

  @override
  bool undo() {
    bool undone = false;
    if (state == 'done' || state == 'redone') {
      undone = _actions.undoAll();
      if (undone) {
        state = 'undone';
        session.domainModels.notifyActionReactions(this);
      } else {
        _actions.doAll();
      }
    }
    return undone;
  }

  @override
  bool redo() {
    bool redone = false;
    if (state == 'undone') {
      redone = _actions.redoAll();
      if (redone) {
        state = 'redone';
        session.domainModels.notifyActionReactions(this);
      } else {
        _actions.undoAll();
      }
    }
    return redone;
  }
}
