import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/repositories/local_coordinates_repository.dart';
import 'package:weather_app/utils/locator.dart';

class LocalCoordinatesRepositoryImpl implements LocalCoordinatesRepository {
  static const _latitudeKey = 'latitude';
  static const _longitudeKey = 'longitude';

  final _preferences = locator<SharedPreferences>();

  @override
  Future<void> addCoordinates(Coordinates coordinates) async {
    await Future.wait([
      _preferences.setDouble(_latitudeKey, coordinates.latitude),
      _preferences.setDouble(_longitudeKey, coordinates.longitude),
    ]);
  }

  @override
  Future<Coordinates?> getCoordinates() async {
    final latitude = _preferences.getDouble(_latitudeKey);
    final longitude = _preferences.getDouble(_longitudeKey);

    if (latitude == null || longitude == null) {
      return null;
    }

    return Coordinates(latitude: latitude, longitude: longitude);
  }

  @override
  Future<void> deleteAllData() async {
    await Future.wait([
      _preferences.remove(_latitudeKey),
      _preferences.remove(_longitudeKey),
    ]);
  }
}
