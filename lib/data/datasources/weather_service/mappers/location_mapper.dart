import 'package:weather_app/data/datasources/weather_service/responses/location_json.dart';
import 'package:weather_app/domain/models/location.dart';

extension LocationMapper on LocationJson {
  Location toModel() {
    return Location(
      city: name,
      localtime: localtime,
    );
  }
}
