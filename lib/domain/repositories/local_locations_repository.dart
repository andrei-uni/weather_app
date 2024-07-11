import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/location.dart';

abstract class LocalLocationsRepository {
  Future<Location> getDefaultLocation();

  Future<List<Location>> getAllLocations();

  Future<Location> addLocation(
    String name,
    Coordinates coordinates,
  );

  Future<void> changeDefaultLocation(int id);

  Future<void> deleteLocation(int id);

  Future<void> deleteAllData();
}
