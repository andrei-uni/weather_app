import 'package:weather_app/data/datasources/local_locations_database/app_database.dart';
import 'package:weather_app/data/datasources/local_locations_database/mappers/location_mapper.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/location.dart';
import 'package:weather_app/domain/repositories/local_locations_repository.dart';

class LocalLocationsRepositoryImpl implements LocalLocationsRepository {
  final _appDatabase = AppDatabase();

  @override
  Future<Location> addLocation(
    String name,
    Coordinates coordinates,
  ) async {
    final LocationTableData newLocation = await _appDatabase.addLocationReturning(
      LocationTableCompanion.insert(
        name: name,
        latitude: coordinates.latitude,
        longitude: coordinates.longitude,
        isDefault: false,
      ),
    );
    return newLocation.toModel();
  }

  @override
  Future<void> changeDefaultLocation(int id) async {
    await _appDatabase.changeDefaultLocation(id);
  }

  @override
  Future<List<Location>> getAllLocations() async {
    final List<LocationTableData> locations = await _appDatabase.getAllLocations();
    return locations.map((e) => e.toModel()).toList();
  }

  @override
  Future<Location> getDefaultLocation() async {
    final LocationTableData? location = await _appDatabase.getDefaultLocation();
    return location!.toModel();
  }

  @override
  Future<void> deleteLocation(int id) async {
    await _appDatabase.deleteLocation(id);
  }

  @override
  Future<void> deleteAllData() async {
    await _appDatabase.deleteAllData();
  }
}
