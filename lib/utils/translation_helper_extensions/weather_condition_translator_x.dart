import 'package:weather_app/domain/models/weather_condition.dart';

extension WeatherConditionTranslatorX on WeatherCondition {
  String translate() {
    return switch (this) {
      WeatherCondition.clear => 'Clear',
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