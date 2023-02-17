part of ednet_core;

// http://dartlangfr.net/dart-cheat-sheet/
abstract class EntitiesApi<E extends EntityApi<E>> implements Iterable<E> {
  Concept? get concept;

  ValidationExceptionsApi get exceptions;

  EntitiesApi<E>? get source;

  E firstWhereAttribute(String code, Object attribute);

  E random();

  E? singleWhereOid(Oid oid);

  EntityApi? internalSingle(Oid oid);

  E singleWhereCode(String code);

  E? singleWhereId(IdApi<E> id);

  E? singleWhereAttributeId(String code, Object attribute);

  EntitiesApi<E> copy();

  EntitiesApi<E> order(
      [int Function(E a, E b) compare]); // sort, but not in place
  EntitiesApi<E> selectWhere(bool Function(E entity) f);

  EntitiesApi<E> selectWhereAttribute(String code, Object attribute);

  EntitiesApi<E> selectWhereParent(String code, EntityApi parent);

  EntitiesApi<E> skipFirst(int n);

  EntitiesApi<E> skipFirstWhile(bool Function(E entity) f);

  EntitiesApi<E> takeFirst(int n);

  EntitiesApi<E> takeFirstWhile(bool Function(E entity) f);

  EntitiesApi? internalChild(Oid oid);

  void clear();

  void sort([int Function(E a, E b) compare]); // in place sort
  bool preAdd(E entity);

  bool add(E entity);

  bool postAdd(E entity);

  bool preRemove(E entity);

  bool remove(E entity);

  bool postRemove(E entity);

  String toJson();

  void fromJson(String entitiesJson);

  void integrate(EntitiesApi<E> fromEntities);

  void integrateAdd(EntitiesApi<E> addEntities);

  void integrateSet(EntitiesApi<E> setEntities);

  void integrateRemove(EntitiesApi<E> removeEntities);
}
