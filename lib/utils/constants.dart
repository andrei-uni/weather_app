import 'package:weather_app/domain/models/coordinates.dart';

abstract class Constants {
  static const mockApiKey = 'e22bc766a30c43fb9a7140818241106';
  
  static const initialCoordinates = Coordinates( // Moscow
    latitude: 55.751244,
    longitude: 37.618423,
  );
}
