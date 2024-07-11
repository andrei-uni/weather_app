import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';

class LocalTimeConverter implements JsonConverter<DateTime, String> {
  const LocalTimeConverter();

  // DateTime.parse does not work in certain cases
  // localtime format 2024-06-10 0:10

  static const _localTimePattern = 'yyyy-MM-dd H:m';

  @override
  DateTime fromJson(String json) {
    return Jiffy.parse(json, pattern: _localTimePattern).dateTime;
  }

  @override
  String toJson(DateTime object) {
    throw UnsupportedError('Unused method');
  }
}
