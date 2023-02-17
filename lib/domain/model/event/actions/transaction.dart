part of ednet_core;

class Transaction extends BasicAction implements TransactionApi {
  final Past _actions;

  Transaction(String name, DomainSession session)
      : _actions = Past(),
        super(name, session);

  @override
  Past get past => _actions;

  @override
  void add(action) {
    _actions.add(action);
    (action as BasicAction).partOfTransaction = true;
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
