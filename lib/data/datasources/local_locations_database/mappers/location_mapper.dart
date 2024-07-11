import 'package:weather_app/data/datasources/local_locations_database/app_database.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/location.dart';

extension LocationModelMapper on LocationTableData {
  Location toModel() {
    return Location(
      id: id,
      name: name,
      coordinates: Coordinates(
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }
}
