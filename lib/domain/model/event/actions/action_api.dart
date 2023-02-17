part of ednet_core;

abstract class ActionApi {
  bool get done;

  bool get undone;

  bool get redone;

  bool doIt();

  bool undo();

  bool redo();
}

