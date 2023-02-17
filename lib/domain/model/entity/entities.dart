part of ednet_core;

class Entities<E extends ConceptEntity<E>> implements EntitiesApi<E> {
  Concept? _concept;
  var _entityList = <E>[];
  final _oidEntityMap = <int, E>{};
  final _codeEntityMap = <String, E>{};
  final _idEntityMap = <String, E>{};

  Entities();

  @override
  ValidationExceptions exceptions = const ValidationExceptions();
  @override
  Entities<E>? source;

  String minc = '0';
  String maxc = 'N';
  bool pre = false;
  bool post = false;
  bool propagateToSource = false;
  var randomGen = Random();

  Entities<E> newEntities() {
    var entities = Entities<E>();
    entities.concept = _concept;
    return entities;
  }

  set concept(Concept? concept) {
    _concept = concept;
    pre = true;
    post = true;
    propagateToSource = true;
  }

  ConceptEntity<E> newEntity() {
    var conceptEntity = ConceptEntity<E>();
    conceptEntity.concept = _concept;
    return conceptEntity;
  }

  @override
  Concept? get concept => _concept;

  @override
  E get first => _entityList.first;

  @override
  bool get isEmpty => _entityList.isEmpty;

  @override
  bool get isNotEmpty => _entityList.isNotEmpty;

  @override
  Iterator<E> get iterator => _entityList.iterator;

  @override
  E get last => _entityList.last;

  @override
  int get length => _entityList.length;

  int get count => length; // for my soul
  @override
  E get single => _entityList.single;

  @override
  bool any(bool Function(E entity) f) => _entityList.any(f);

  @override
  bool contains(Object? entity) {
    E element = _oidEntityMap[(entity as E).oid.timeStamp]!;
    if (entity == element) {
      return true;
    }
    return false;
  }

  @override
  E elementAt(int index) => _entityList.elementAt(index); // should we keep it?
  E at(int index) => elementAt(index); // should we keep it?
  @override
  bool every(bool Function(E entity) f) => _entityList.every(f);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E element) toElements) =>
      _entityList.expand(toElements); // should we keep it?

  @override
  E firstWhere(bool Function(E entity) f, {E Function()? orElse}) =>
      _entityList.firstWhere(f);

  ///
  /// 'Entities.fold' ('dynamic Function(dynamic, dynamic Function(dynamic, E))')
  /// 'Iterable.fold' ('T Function<T>(T, T Function(T, E))'). (Documentation)

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) =>
      _entityList.fold(initialValue, combine);

  @override
  void forEach(void Function(E element) action) => _entityList.forEach(action);

  @override
  String join([String separator = '']) => _entityList.join(separator);

  @override
  E lastWhere(bool Function(E entity) f, {E Function()? orElse}) =>
      _entityList.lastWhere(f);

  @override
  Iterable<T> map<T>(T Function(E) f) => _entityList.map(f);

  @override
  E reduce(E Function(E value, E entity) combine) =>
      _entityList.reduce(combine); // E? value
  @override
  E singleWhere(bool Function(E entity) f, {E Function()? orElse}) =>
      _entityList.singleWhere(f);

  ///
  /// 'Entities.firstWhere' ('E Function(bool Function(E), {E Function() orElse})')
  ///
  /// 'Iterable.firstWhere' ('E Function(bool Function(E), {E Function()? orElse})').
  ///
  ///
  @override
  Iterable<E> skip(int n) => _entityList.skip(n);

  @override
  Iterable<E> skipWhile(bool Function(E entity) f) => _entityList.skipWhile(f);

  @override
  Iterable<E> take(int n) => _entityList.take(n);

  @override
  Iterable<E> takeWhile(bool Function(E entity) f) => _entityList.takeWhile(f);

  @override
  List<E> toList({bool growable = true}) => _entityList.toList(growable: true);

  @override
  Set<E> toSet() => _entityList.toSet();

  @override
  Iterable<E> where(bool Function(E entity) f) => _entityList.where(f);

  List<E> get internalList => _entityList;

  // set for Polymer only:
  // entities.internalList = toObservable(entities.internalList);
  set internalList(List<E> observableList) {
    _entityList = observableList;
  }

  @override
  E firstWhereAttribute(String code, Object attribute) {
    var selectionEntities = selectWhereAttribute(code, attribute);
    if (selectionEntities.isNotEmpty) {
      return selectionEntities.first;
    }
    throw EDNetException(
        'E firstWhereAttribute(String code, Object attribute): code = $code, attribute = $attribute');
  }

  @override
  E random() {
    if (!isEmpty) {
      return _entityList[randomGen.nextInt(length)];
    }
    throw EDNetException('E random(): length = $length');
  }

  @override
  E? singleWhereOid(Oid oid) {
    if (_oidEntityMap[oid.timeStamp] != null) {
      return _oidEntityMap[oid.timeStamp]!;
    }

    return null;
  }

  @override
  ConceptEntity? internalSingle(Oid oid) {
    if (isEmpty) {
      return null;
    }
    ConceptEntity? foundEntity = singleWhereOid(oid);
    if (foundEntity != null) {
      return foundEntity;
    }
    if (_concept != null && _concept!.children.isNotEmpty) {
      for (ConceptEntity entity in _entityList) {
        for (Child child in _concept!.children as Iterable) {
          if (child.internal) {
            Entities? childEntities = entity.getChild(child.code);
            ConceptEntity? childEntity = childEntities?.internalSingle(oid);
            if (childEntity != null) {
              return childEntity;
            }
          }
        }
      }
    }
    return null;
  }

  @override
  Entities? internalChild(Oid oid) {
    if (isEmpty) {
      return null;
    }
    ConceptEntity? foundEntity = singleWhereOid(oid);
    if (foundEntity != null) {
      return this;
    }
    if (_concept != null && _concept!.children.isNotEmpty) {
      for (ConceptEntity entity in _entityList) {
        for (Child child in _concept!.children as Iterable) {
          if (child.internal) {
            Entities? childEntities = entity.getChild(child.code);
            ConceptEntity? childEntity = childEntities?.internalSingle(oid);
            if (childEntity != null) {
              return childEntities;
            }
          }
        }
      }
    }
    return null;
  }

  @override
  E singleWhereCode(String? code) {
    return _codeEntityMap[code]!;
  }

  @override
  E? singleWhereId(IdApi<E> id) {
    return _idEntityMap[id.toString()];
  }

  @override
  E? singleWhereAttributeId(String code, Object attribute) {
    return singleWhereId(
        (Id(_concept!) as IdApi<E>)..setAttribute(code, attribute));
  }

  /// Copies the entities.
  /// It is not a deep copy.
  @override
  Entities<E> copy() {
    if (_concept == null) {
      throw ConceptException('Entities.copy: concept is not defined.');
    }
    Entities<E> copiedEntities = newEntities();
    copiedEntities.pre = false;
    copiedEntities.post = false;
    copiedEntities.propagateToSource = false;
    for (ConceptEntity entity in this) {
      copiedEntities.add(entity.copy() as E);
    }
    copiedEntities.pre = true;
    copiedEntities.post = true;
    copiedEntities.propagateToSource = true;
    return copiedEntities;
  }

  /// If compare function is not passed, compareTo method will be used.
  /// If there is no compareTo method on specific entity,
  /// the Entity.compareTo method will be used (code if not null, otherwise id).
  @override
  Entities<E> order([int Function(E a, E b)? compare]) {
    if (_concept == null) {
      throw ConceptException('Entities.order: concept is not defined.');
    }
    Entities<E> orderedEntities = newEntities();
    orderedEntities.pre = false;
    orderedEntities.post = false;
    orderedEntities.propagateToSource = false;
    List<E> sortedList = toList();
    // in place sort
    sortedList.sort(compare);
    sortedList.forEach((entity) => orderedEntities.add(entity));
    orderedEntities.pre = true;
    orderedEntities.post = true;
    orderedEntities.propagateToSource = false;
    orderedEntities.source = this;
    return orderedEntities;
  }

  @override
  Entities<E> selectWhere(bool Function(E) f) {
    if (_concept == null) {
      throw ConceptException('Entities.selectWhere: concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.where(f);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  @override
  Entities<E> selectWhereAttribute(String code, Object attribute) {
    if (_concept == null) {
      throw ConceptException(
          'Entities.selectWhereAttribute($code, $attribute): concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    for (E entity in _entityList) {
      for (Attribute a in _concept!.attributes as Iterable) {
        if (a.code == code) {
          if (entity.getAttribute(a.code) == attribute) {
            selectedEntities.add(entity);
          }
        }
      }
    }
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  @override
  Entities<E> selectWhereParent(String code, EntityApi parent) {
    if (_concept == null) {
      throw ConceptException(
          'Entities.selectWhereParent($code, $parent): concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    for (E entity in _entityList) {
      for (Parent p in _concept!.parents as Iterable) {
        if (p.code == code) {
          if (entity.getParent(p.code) == parent) {
            selectedEntities.add(entity);
          }
        }
      }
    }
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  @override
  Entities<E> skipFirst(int n) {
    if (_concept == null) {
      throw ConceptException('Entities.skipFirst: concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.skip(n);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  @override
  Entities<E> skipFirstWhile(bool Function(E entity) f) {
    if (_concept == null) {
      throw ConceptException(
          'Entities.skipFirstWhile: concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.skipWhile(f);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  @override
  Entities<E> takeFirst(int n) {
    if (_concept == null) {
      throw ConceptException('Entities.takeFirst: concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.take(n);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  @override
  Entities<E> takeFirstWhile(bool Function(E entity) f) {
    if (_concept == null) {
      throw ConceptException(
          'Entities.takeFirstWhile: concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.takeWhile(f);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  @override
  String toJson() => jsonEncode(toJsonList());

  List<Map<String, Object>> toJsonList() {
    List<Map<String, Object>> entityList = <Map<String, Object>>[];
    for (E entity in _entityList) {
      entityList.add(entity.toJsonMap());
    }
    return entityList;
  }

  @override
  void fromJson(String entitiesJson) {
    List<Map<String, Object>> entitiesList = jsonDecode(entitiesJson);
    fromJsonList(entitiesList);
  }

  /// Loads entities without validations to this, which must be empty.
  void fromJsonList(List<Map<String, Object>> entitiesList,
      [ConceptEntity? internalParent]) {
    if (concept == null) {
      throw ConceptException('entities concept does not exist.');
    }
    if (length > 0) {
      throw JsonException('entities are not empty');
    }
    var beforePre = pre;
    var beforePost = post;
    pre = false;
    post = false;
    for (Map<String, Object> entityMap in entitiesList) {
      var entity = newEntity();
      entity.fromJsonMap(entityMap, internalParent!);
      add(entity as E);
    }
    pre = beforePre;
    post = beforePost;
  }

  /// entity
  /// Returns a string that represents this entity by using oid and code.
  @override
  String toString() {
    if (_concept != null) {
      return '${_concept!.code}: entities:$length';
    }
    return 'Concept is null';
  }

  @override
  void clear() {
    _entityList.clear();
    _oidEntityMap.clear();
    _codeEntityMap.clear();
    _idEntityMap.clear();
    exceptions.clear();
  }

  /// If compare function is not passed, compareTo method will be used.
  /// If there is no compareTo method on specific entity,
  /// the Entity.compareTo method will be used (code if not null, otherwise id).
  @override
  void sort([int Function(E a, E b)? compare]) {
    // in place sort
    _entityList.sort(compare);
  }

  @override
  bool preAdd(E entity) {
    if (!pre) {
      return true;
    }

    if (entity.concept == null) {
      throw ConceptException(
          'Entity(oid: ${entity.oid}) concept is not defined.');
    }
    if (_concept == null) {
      throw ConceptException('Entities.add: concept is not defined.');
    }
    if (!(_concept!.add)) {
      throw AddException('An entity cannot be added to ${_concept?.codes}.');
    }

    bool result = true;

    // max validation
    if (maxc != 'N') {
      int maxInt;
      try {
        maxInt = int.parse(maxc);
        if (length == maxInt) {
          const category = 'max cardinality';
          final message = '${_concept?.codes}.max is $maxc.';
          var exception = ValidationException(category, message);

          exceptions.add(exception);
          result = false;
        }
      } on FormatException catch (e) {
        throw AddException(
            'Entities max is neither N nor a positive integer string: $e');
      }
    }

    // increment and required validation
    for (Attribute a in _concept!.attributes as Iterable) {
      if (a.increment != null) {
        if (length == 0) {
          entity.setAttribute(a.code, a.increment!);
        } else if (a.type?.code == 'int') {
          var lastEntity = last;
          int incrementAttribute = lastEntity.getAttribute(a.code) as int;
          var attributeUpdate = a.update;
          a.update = true;
          entity.setAttribute(a.code, incrementAttribute + a.increment!);
          a.update = attributeUpdate;
        } else {
          throw TypeException(
              '${a.code} attribute value cannot be incremented.');
        }
      } else if (a.required && entity.getAttribute(a.code) == null) {
        const category = 'required';
        final message = '${entity.concept?.code}.${a.code} attribute is null.';
        final exception = ValidationException(category, message);

        exceptions.add(exception);
        result = false;
      }
    }
    for (Parent p in _concept?.parents as Iterable) {
      if (p.required && p.code != null && entity.getParent(p.code) == null) {
        const category = 'required';
        final message = '${entity.concept?.code}.${p.code} parent is null.';
        final exception = ValidationException(category, message);

        exceptions.add(exception);
        result = false;
      }
    }

    // uniqueness validation
    if (entity.code != null && singleWhereCode(entity.code) != null) {
      const category = 'unique';
      final message = '${entity.concept?.code}.code is not unique.';
      final exception = ValidationException(category, message);

      exceptions.add(exception);
      result = false;
    }
    if (entity.id != null && singleWhereId(entity.id as IdApi<E>) != null) {
      const category = 'unique';
      final message =
          '${entity.concept?.code}.id ${entity.id.toString()} is not unique.';
      ValidationException exception = ValidationException(category, message);

      exceptions.add(exception);
      result = false;
    }

    return result;
  }

  @override
  bool add(E entity) {
    bool added = false;
    if (preAdd(entity)) {
      var propagated = true;
      if (source != null && propagateToSource) {
        propagated = source!.add(entity);
      }
      if (propagated) {
        _entityList.add(entity);
        _oidEntityMap[entity.oid.timeStamp] = entity;
        if (entity.code != null) {
          _codeEntityMap[entity.code] = entity;
        }
        if (entity.concept != null && entity.id != null) {
          _idEntityMap[entity.id.toString()] = entity;
        }
        if (postAdd(entity)) {
          added = true;
          entity._whenAdded = DateTime.now();
        } else {
          var beforePre = pre;
          var beforePost = post;
          pre = false;
          post = false;
          if (!remove(entity)) {
            var msg = '${entity.concept?.code} entity (${entity.oid}) '
                'was added, post was not successful, remove was not successful';
            throw RemoveException(msg);
          } else {
            entity._whenAdded = null;
          }
          pre = beforePre;
          post = beforePost;
        }
      } else {
        // not propagated
        var msg = '${entity.concept?.code} entity (${entity.oid}) '
            'was not added - propagation to the source ${source?.concept?.code} '
            'entities was not successful';
        throw AddException(msg);
      }
    }
    return added;
  }

  @override
  bool postAdd(E entity) {
    if (!post) {
      return true;
    }

    if (entity.concept == null) {
      throw ConceptException(
          'Entity(oid: ${entity.oid}) concept is not defined.');
    }
    if (_concept == null) {
      throw ConceptException('Entities.add: concept is not defined.');
    }

    bool result = true;

    //...

    return result;
  }

  @override
  bool preRemove(E entity) {
    if (!pre) {
      return true;
    }

    if (entity.concept == null) {
      throw ConceptException(
          'Entity(oid: ${entity.oid}) concept is not defined.');
    }
    if (_concept == null) {
      throw ConceptException('Entities.remove: concept is not defined.');
    }
    if (!(_concept?.remove ?? false)) {
      throw RemoveException(
          'An entity cannot be removed from ${_concept?.codes}.');
    }

    bool result = true;

    // min validation
    if (minc != '0') {
      int minInt;
      try {
        minInt = int.parse(minc);
        if (length == minInt) {
          const category = 'min';
          final message = '${_concept?.codes}.min is $minc.';
          ValidationException exception =
              ValidationException(category, message);

          exceptions.add(exception);
          result = false;
        }
      } on FormatException catch (e) {
        throw RemoveException(
            'Entities min is not a positive integer string: $e');
      }
    }

    return result;
  }

  @override
  bool remove(E entity) {
    bool removed = false;
    if (preRemove(entity)) {
      var propagated = true;
      if (source != null && propagateToSource) {
        propagated = source!.remove(entity);
      }
      if (propagated) {
        if (_entityList.remove(entity)) {
          _oidEntityMap.remove(entity.oid.timeStamp);
          if (entity.code != null) {
            _codeEntityMap.remove(entity.code);
          }
          if (entity.concept != null && entity.id != null) {
            _idEntityMap.remove(entity.id.toString());
          }
          if (postRemove(entity)) {
            removed = true;
            entity._whenRemoved = DateTime.now();
          } else {
            var beforePre = pre;
            var beforePost = post;
            pre = false;
            post = false;
            if (!add(entity)) {
              var msg = '${entity.concept?.code} entity (${entity.oid}) '
                  'was removed, post was not successful, add was not successful';
              throw AddException(msg);
            } else {
              entity._whenRemoved = null;
            }
            pre = beforePre;
            post = beforePost;
          }
        }
      } else {
        // not propagated
        var msg = '${entity.concept?.code} entity (${entity.oid}) '
            'was not removed - propagation to the source ${source!.concept?.code} '
            'entities was not successful';
        throw RemoveException(msg);
      }
    }
    return removed;
  }

  @override
  bool postRemove(E entity) {
    if (!post) {
      return true;
    }

    if (entity.concept == null) {
      throw ConceptException(
          'Entity(oid: ${entity.oid}) concept is not defined.');
    }
    if (_concept == null) {
      throw ConceptException('Entities.add: concept is not defined.');
    }

    bool result = true;

    //...

    return result;
  }

  /// Updates removes the before entity and adds the after entity, in order to
  /// update oid, code and id entity maps.
  ///
  /// Used only if oid, code or id are set to a new value in the after entity.
  /// They can be set only with the help of meta:
  /// concept.updateOid, concept.updateCode or property.update.
  bool update(E beforeEntity, E afterEntity) {
    if (beforeEntity.oid == afterEntity.oid &&
        beforeEntity.code == afterEntity.code &&
        beforeEntity.id == afterEntity.id) {
      throw UpdateException(
          '${_concept?.codes}.update can only be used if oid, code or id set.');
    }
    if (remove(beforeEntity)) {
      if (add(afterEntity)) {
        return true;
      } else {
        print('entities.update: ${exceptions.toList()}');
        if (add(beforeEntity)) {
          const category = 'update';
          final message =
              '${_concept?.codes}.update fails to add after update entity.';
          var exception = ValidationException(category, message);
          exceptions.add(exception);
        } else {
          throw UpdateException(
              '${_concept?.codes}.update fails to add back before update entity.');
        }
      }
    } else {
      const category = 'update';
      final message =
          '${_concept?.codes}.update fails to remove before update entity.';
      var exception = ValidationException(category, message);

      exceptions.add(exception);
    }
    return false;
  }

  bool addFrom(Entities<E> entities) {
    bool allAdded = true;
    if (_concept == entities.concept) {
      entities.forEach((entity) => add(entity) ? true : allAdded = false);
    } else {
      throw ConceptException('The concept of the argument is different.');
    }
    return allAdded;
  }

  bool removeFrom(Entities<E> entities) {
    bool allRemoved = true;
    if (_concept == entities.concept) {
      entities.forEach((entity) => remove(entity) ? true : allRemoved = false);
    } else {
      throw ConceptException('The concept of the argument is different.');
    }
    return allRemoved;
  }

  bool setAttributesFrom(Entities<E> entities) {
    bool allSet = true;
    if (_concept == entities.concept) {
      for (var entity in entities) {
        var baseEntity = singleWhereOid(entity.oid);
        if (baseEntity != null) {
          var baseEntitySet = baseEntity.setAttributesFrom(entity);
          if (!baseEntitySet) {
            allSet = false;
          }
        } else {
          allSet = false;
        }
      }
    } else {
      throw ConceptException('The concept of the argument is different.');
    }
    return allSet;
  }

  /// Displays (prints) a title, then entities.
  void display(
      {String title = 'Entities',
      String prefix = '',
      bool withOid = true,
      bool withChildren = true,
      bool withInternalChildren = true}) {
    var s = prefix;

    bool thereIsNoEntry = !(_concept?.entry ?? false);
    bool thereIsEntry = _concept?.entry ?? false;
    bool thereIsParent = _concept?.parents.isNotEmpty ?? false;

    if (thereIsNoEntry || (thereIsEntry && thereIsParent)) {
      s = '$prefix  ';
    }
    if (title != '') {
      //print('');
      print('$s======================================');
      print('$s$title                                ');
      print('$s======================================');
      //print('');
    }
    for (E e in _entityList) {
      e.display(
          prefix: s,
          withOid: withOid,
          withChildren: withChildren,
          withInternalChildren: withInternalChildren);
    }
  }

  void displayOidMap() {
    _oidEntityMap.forEach((k, v) {
      print('oid $k: $v');
    });
  }

  void displayCodeMap() {
    _codeEntityMap.forEach((k, v) {
      print('code $k: $v');
    });
  }

  void displayIdMap() {
    _idEntityMap.forEach((k, v) {
      print('id $k: $v');
    });
  }

  @override
  Iterable<E> followedBy(Iterable<E> other) {
    return _entityList.followedBy(other);
  }

  @override
  Iterable<T> whereType<T>() {
    return _entityList.whereType<T>();
  }

  @override
  void integrate(EntitiesApi<E> fromEntities) {
    for (var entity in toList()) {
      var fromEntity = fromEntities.singleWhereOid(entity.oid);
      if (fromEntity == null) {
        remove(entity);
      }
    }
    for (var fromEntity in fromEntities) {
      var entity = singleWhereOid(fromEntity.oid);
      if (entity != null && entity.whenSet != null) {
        if (entity.whenSet!.millisecondsSinceEpoch <
            fromEntity.whenSet!.millisecondsSinceEpoch) {
          entity.setAttributesFrom(fromEntity);
        }
      } else {
        add(fromEntity);
      }
    }
  }

  @override
  void integrateAdd(EntitiesApi<E> addEntities) {
    for (var addEntity in addEntities) {
      var entity = singleWhereOid(addEntity.oid);
      if (entity == null) {
        add(addEntity);
      }
    }
  }

  @override
  void integrateRemove(EntitiesApi<E> removeEntities) {
    for (var removeEntity in removeEntities) {
      var entity = singleWhereOid(removeEntity.oid);
      if (entity != null) {
        remove(entity);
      }
    }
  }

  @override
  void integrateSet(EntitiesApi<E> setEntities) {
    for (var setEntity in setEntities) {
      var entity = singleWhereOid(setEntity.oid);
      if (entity != null && entity.whenSet != null) {
        if (entity.whenSet!.millisecondsSinceEpoch <
            setEntity.whenSet!.millisecondsSinceEpoch) {
          entity.setAttributesFrom(setEntity);
        }
      }
    }
  }

  @override
  Iterable<E> cast<E>() {
    final it = () sync* {
      for (var e in this) {
        yield e;
      }
    }();
    // If this iterable only contains instances of R, all operations will work correctly. If any operation tries to access an element that is not an instance of R, the access will throw instead.
    try {
      it.elementAt(0);
    } on TypeError catch (_) {
      throw TypeError();
    }
    // When the returned iterable creates a new object that depends on the type R, e.g., from toList, it will have exactly the type R.
    return it as Iterable<E>;
  }
}
