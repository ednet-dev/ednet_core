part of ednet_core;

abstract class ValidationExceptionsApi {
  int get length;

  void add(ValidationException exception);

  void clear();

  List<ValidationException> toList();
}

class ValidationException implements Exception {
  final String category;
  final String message;

  const ValidationException(this.category, this.message);

  /// Returns a string that represents the error.
  @override
  String toString() {
    return '$category: $message';
  }

  /// Displays (prints) an exception.
  display({String prefix = ''}) {
    print('$prefix******************************************');
    print('$prefix$category                               ');
    print('$prefix******************************************');
    print('${prefix}message: $message');
    print('$prefix******************************************');
    print('');
  }
}

class ValidationExceptions implements ValidationExceptionsApi {
  final List<ValidationException> _exceptionList;

  const ValidationExceptions() : _exceptionList = const <ValidationException>[];

  @override
  int get length => _exceptionList.length;

  bool get isEmpty => length == 0;

  Iterator<ValidationException> get iterator => _exceptionList.iterator;

  @override
  void add(ValidationException exception) {
    _exceptionList.add(exception);
  }

  @override
  void clear() {
    _exceptionList.clear();
  }

  @override
  List<ValidationException> toList() => _exceptionList.toList();

  /// Returns a string that represents the exceptions.
  @override
  String toString() {
    var messages = '';
    for (var exception in _exceptionList) {
      messages = '${exception.toString()} \n$messages';
    }
    return messages;
  }

  /// Displays (prints) a title, then exceptions.
  void display({String title: 'Entities', bool withOid: true}) {
    if (title == 'Entities') {
      title = 'Errors';
    }
    print('');
    print('************************************************');
    print('$title                                          ');
    print('************************************************');
    print('');
    for (ValidationException exception in _exceptionList) {
      exception.display(prefix: '*** ');
    }
  }
}
