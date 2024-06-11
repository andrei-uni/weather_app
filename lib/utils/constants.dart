import 'package:weather_app/domain/models/coordinates.dart';

abstract class Constants {
  static const mockApiKey = '5dc6415fdbb64503b94181151240906';
  
  static const initialCoordinates = Coordinates( // Moscow
    latitude: 55.751244,
    longitude: 37.618423,
  );
}
