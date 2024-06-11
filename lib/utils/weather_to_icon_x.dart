import 'package:flutter/material.dart';
import 'package:weather_app/domain/models/weather_condition.dart';

extension WeatherToIconX on WeatherCondition {
  IconData toIcon() { //TODO
    return switch (this) {
      WeatherCondition.clear => Icons.sunny,
      WeatherCondition.clouds => Icons.cloud,
      WeatherCondition.drizzle => throw UnimplementedError(),
      WeatherCondition.rain => throw UnimplementedError(),
      WeatherCondition.thunderstorm => throw UnimplementedError(),
      WeatherCondition.snow => throw UnimplementedError(),
      WeatherCondition.fog => throw UnimplementedError(),
      WeatherCondition.mist => throw UnimplementedError(),
      WeatherCondition.unknown => Icons.error,
    };
  }
}
