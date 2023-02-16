part of ednet_core;

abstract class PastApi implements SourceOfPastReactionApi {
  void add(ActionApi action);

  List<ActionApi> get actions;

  void clear();

  bool get empty;

  bool get undoLimit;

  bool get redoLimit;

  bool doIt();

  bool undo();

  bool redo();
}

class Past implements PastApi {
  int cursor = 0;
  @override
  final List<BasicAction> actions;

  final List<PastReactionApi> pastReactions;

  Past({
    this.actions = const <BasicAction>[],
    this.pastReactions = const <PastReactionApi>[],
  });

  @override
  bool get empty => actions.isEmpty;

  @override
  bool get undoLimit => empty || cursor == 0;

  @override
  bool get redoLimit => empty || cursor == actions.length;

  @override
  void add(ActionApi action) {
    _removeRightOfCursor();
    actions.add(action as BasicAction);
    _moveCursorForward();
  }

  void _removeRightOfCursor() {
    for (int i = actions.length - 1; i >= cursor; i--) {
      actions.removeRange(i, i + 1);
    }
  }

  void _notifyUndoRedo() {
    if (undoLimit) {
      notifyCannotUndo();
    } else {
      notifyCanUndo();
    }
    if (redoLimit) {
      notifyCannotRedo();
    } else {
      notifyCanRedo();
    }
  }

  void _moveCursorForward() {
    cursor++;
    _notifyUndoRedo();
  }

  void _moveCursorBackward() {
    if (cursor > 0) {
      cursor--;
    }
    _notifyUndoRedo();
  }

  @override
  void clear() {
    cursor = 0;
    actions.clear();
    _notifyUndoRedo();
  }

  @override
  bool doIt() {
    bool done = false;
    if (!empty) {
      BasicAction action = actions[cursor];
      done = action.doIt();
      _moveCursorForward();
    }
    return done;
  }

  @override
  bool undo() {
    bool undone = false;
    if (!empty) {
      _moveCursorBackward();
      BasicAction action = actions[cursor];
      undone = action.undo();
    }
    return undone;
  }

  @override
  bool redo() {
    bool redone = false;
    if (!empty && !redoLimit) {
      BasicAction action = actions[cursor];
      redone = action.redo();
      _moveCursorForward();
    }
    return redone;
  }

  bool doAll() {
    bool allDone = true;
    cursor = 0;
    while (cursor < actions.length) {
      if (!doIt()) {
        allDone = false;
      }
    }
    return allDone;
  }

  bool undoAll() {
    bool allUndone = true;
    while (cursor > 0) {
      if (!undo()) {
        allUndone = false;
      }
    }
    return allUndone;
  }

  bool redoAll() {
    bool allRedone = true;
    cursor = 0;
    while (cursor < actions.length) {
      if (!redo()) {
        allRedone = false;
      }
    }
    return allRedone;
  }

  @override
  void startPastReaction(PastReactionApi reaction) {
    pastReactions.add(reaction);
  }

  @override
  void cancelPastReaction(PastReactionApi reaction) {
    pastReactions.remove(reaction);
  }

  @override
  void notifyCannotUndo() {
    for (PastReactionApi reaction in pastReactions) {
      reaction.reactCannotUndo();
    }
  }

  @override
  void notifyCanUndo() {
    for (PastReactionApi reaction in pastReactions) {
      reaction.reactCanUndo();
    }
  }

  @override
  void notifyCanRedo() {
    for (PastReactionApi reaction in pastReactions) {
      reaction.reactCanRedo();
    }
  }

  @override
  void notifyCannotRedo() {
    for (PastReactionApi reaction in pastReactions) {
      reaction.reactCannotRedo();
    }
  }

  void display([String title = 'Past Actions']) {
    print('');
    print('======================================');
    print('$title                                ');
    print('======================================');
    print('');
    print('cursor: $cursor');
    for (BasicAction action in actions) {
      action.display();
    }
    print('');
  }
}
