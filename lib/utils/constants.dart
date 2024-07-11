import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/location.dart';

abstract class Constants {
  static const mockApiKey = '5d1cc376113f4d8eaef100928241107';

  static const initialLocation = Location(
    id: 0,
    name: 'London',
    coordinates: Coordinates(
      latitude: 51.5,
      longitude: -0.12,
    ),
  );
}
