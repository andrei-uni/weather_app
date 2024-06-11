import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/domain/models/weather_condition.dart';

extension WeatherConditionToIconX on WeatherCondition {
  IconData toIcon() {
    return switch (this) {
      WeatherCondition.clearDay => Icons.sunny,
      WeatherCondition.clearNight => Icons.nightlight,
      WeatherCondition.clouds => CupertinoIcons.cloud_fill,
      WeatherCondition.drizzle => CupertinoIcons.cloud_drizzle_fill,
      WeatherCondition.rain => CupertinoIcons.cloud_rain_fill,
      WeatherCondition.thunderstorm => CupertinoIcons.cloud_bolt_rain_fill,
      WeatherCondition.snow => CupertinoIcons.cloud_snow_fill,
      WeatherCondition.fog => CupertinoIcons.cloud_fog_fill,
      WeatherCondition.mist => CupertinoIcons.cloud_fog_fill,
      WeatherCondition.unknown => Icons.error,
    };
  }
}
