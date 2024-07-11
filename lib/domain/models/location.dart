import 'package:weather_app/domain/models/coordinates.dart';

class Location {
  const Location({
    required this.id,
    required this.name,
    required this.coordinates,
  });

  final int id;
  final String name;
  final Coordinates coordinates;
}
