import 'dart:convert';

import 'package:omnesoft_task/omnesoft_app_shared/lib/src/core/converters/custom_json_decoder.dart';

class JsonStringConverter {
  JsonStringConverter({
    required CustomJsonDecoder jsonDecoder,
  }) : _jsonDecoder = jsonDecoder;

  final CustomJsonDecoder _jsonDecoder;

  String toJsonString<T>(T value) => jsonEncode(value);

  T fromJsonString<T>(String value) => _jsonDecoder.decode<T>(jsonDecode(value));
}
