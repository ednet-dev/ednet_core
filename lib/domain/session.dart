part of ednet_core;

abstract class DomainSessionApi {
  DomainModelsApi get domainModels;

  PastApi get past;
}

class DomainSession implements DomainSessionApi {
  final DomainModels _domainModels;
  final Past _past;

  DomainSession(this._domainModels) : _past = Past();

  @override
  DomainModels get domainModels => _domainModels;

  @override
  Past get past => _past;
}
