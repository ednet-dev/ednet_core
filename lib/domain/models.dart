part of ednet_core;

abstract class DomainModelsApi implements SourceOfActionReactionApi {
  void add(ModelEntriesApi modelEntries);

  Domain get domain;

  Model? getModel(String modelCode);

  ModelEntriesApi? getModelEntries(String modelCode);

  DomainSessionApi newSession();
}

class DomainModels implements DomainModelsApi {
  final Domain _domain;

  final Map<String, ModelEntries> _modelEntriesMap;

  // for transactions to be able to use multiple models
  final List<ActionReactionApi> _actionReactions;

  DomainModels(this._domain)
      : _modelEntriesMap = <String, ModelEntries>{},
        _actionReactions = <ActionReactionApi>[];

  void addModelEntries(ModelEntries modelEntries) {
    var domainCode = modelEntries.model.domain.code;
    if (_domain.code != domainCode) {
      var msg = 'The $domainCode domain of the model is different from '
          'the ${_domain.code} domain.';
      throw CodeException(msg);
    }
    var modelCode = modelEntries.model.code;
    var entries = _modelEntriesMap[modelCode];
    if (entries == null) {
      _modelEntriesMap[modelCode] = modelEntries;
    } else {
      throw CodeException(
          'The $modelCode model exists already in the ${_domain.code} domain.');
    }
  }

  @override
  Domain get domain => _domain;

  @override
  Model? getModel(String modelCode) {
    return _domain.getModel(modelCode);
  }

  @override
  ModelEntries? getModelEntries(String modelCode) =>
      _modelEntriesMap[modelCode];

  @override
  DomainSession newSession() {
    return DomainSession(this);
  }

  @override
  void startActionReaction(ActionReactionApi reaction) {
    _actionReactions.add(reaction);
  }

  @override
  void cancelActionReaction(ActionReactionApi reaction) {
    int index = _actionReactions.indexOf(reaction, 0);
    _actionReactions.removeRange(index, 1);
  }

  @override
  void add(ModelEntriesApi modelEntries) {
    addModelEntries(modelEntries as ModelEntries);
  }

  @override
  void notifyActionReactions(ActionApi action) {
    for (ActionReactionApi reaction in _actionReactions) {
      reaction.react(action);
    }
  }
}
