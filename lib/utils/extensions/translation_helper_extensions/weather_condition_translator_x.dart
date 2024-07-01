import 'package:weather_app/domain/models/weather/weather_condition.dart';

extension WeatherConditionTranslatorX on WeatherCondition {
  String translate() {
    return switch (this) {
      WeatherCondition.clearDay => 'Sunny',
      WeatherCondition.clearNight => 'Clear',
      WeatherCondition.clouds => 'Clouds',
      WeatherCondition.drizzle => 'Drizzle',
      WeatherCondition.rain => 'Rain',
      WeatherCondition.thunderstorm => 'Thunderstorm',
      WeatherCondition.snow => 'Snow',
      WeatherCondition.fog => 'Fog',
      WeatherCondition.mist => 'Mist',
      WeatherCondition.unknown => 'Unknown',
    };
  }
}