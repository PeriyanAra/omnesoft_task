typedef FromJsonFactory<T> = T Function(Map<String, dynamic> json);

class CustomJsonDecoder {
  CustomJsonDecoder(this._factories);

  final List<Map<Type, FromJsonFactory<dynamic>>> _factories;

  void addFactory(Map<Type, FromJsonFactory<dynamic>> typeFactory) => _factories.add(typeFactory);

  T decode<T>(dynamic entity) {
    if (entity is T) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    throw UnimplementedError('Decoding for ${entity.runtimeType} is not supported yet.');
  }

  T _decodeMap<T>(Map<String, dynamic> values) => _getFromJsonFactory<T>()(values);

  FromJsonFactory<T> _getFromJsonFactory<T>() {
    for (final list in _factories) {
      if (list[T] != null) {
        return list[T]! as FromJsonFactory<T>;
      }
    }

    throw ArgumentError(
      "Could not find factory for type $T. Ensure 'it is registered and passed into CustomJsonDecoder.",
    );
  }
}
