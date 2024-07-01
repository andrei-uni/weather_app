import 'package:weather_app/domain/models/errors/weather_error.dart';

extension WeatherErrorTranslatorX on WeatherError {
  String translate() {
    return switch (this) {
      NoConnection() => 'No Internet Connection',
      InvalidLocation() => 'No location found matching your coordinates',
      KeyDisabled() => 'Your api key is disabled',
      KeyInvalid() => 'Your api key is invalid',
      KeyQuotaExceeded() => 'Your api quota has been exceeded',
      InternalServerError() => 'Internal server error',
      UnknownError(:final message) => 'Unknown error: $message',
    };
  }
}
