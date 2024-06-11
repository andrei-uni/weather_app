import 'package:weather_app/domain/models/coordinates.dart';

abstract class LocalCoordinatesRepository {
  Future<Coordinates?> getCoordinates();

  Future<void> addCoordinates(Coordinates coordinates);

  Future<void> deleteAllData();
}
