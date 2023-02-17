part of ednet_core;

abstract class TransactionApi extends ActionApi {
  void add(ActionApi action);

  PastApi get past;
}
