import 'package:jiffy/jiffy.dart';
import 'package:weather_app/data/datasources/weather_service/responses/location_json.dart';
import 'package:weather_app/domain/models/location.dart';

extension LocationMapper on LocationJson {
  Location toModel() {
    return Location(
      city: name,
      // format 2024-06-10 0:10
      // DateTime.parse does not work in certain cases
      localtime: Jiffy.parse(localtime, pattern: _localtimePattern).dateTime,
    );
  }

  static const _localtimePattern = 'yyyy-MM-dd H:m';
}
