import 'package:weather_app/domain/models/coordinates.dart';

abstract class Constants {
  static const mockApiKey = 'de7eb7b06a1e4e699b0175926240107';
  
  static const initialCoordinates = Coordinates( // Moscow
    latitude: 55.751244,
    longitude: 37.618423,
  );
}
