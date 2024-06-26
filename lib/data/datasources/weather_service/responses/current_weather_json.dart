import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/datasources/weather_service/responses/weather_condition_json.dart';

part 'current_weather_json.g.dart';

@JsonSerializable(
  createToJson: false,
)
class CurrentWeatherJson {
  const CurrentWeatherJson({
    required this.tempCels,
    required this.condition,
    required this.windKph,
    required this.humidity,
    required this.cloudiness,
    required this.isDay,
  });

  @JsonKey(name: 'temp_c')
  final double tempCels;

  final WeatherConditionJson condition;

  @JsonKey(name: 'wind_kph')
  final double windKph;

  final int humidity;

  @JsonKey(name: 'cloud')
  final int cloudiness;

  @JsonKey(name: 'is_day', fromJson: _boolFromInt)
  final bool isDay;

  static bool _boolFromInt(int isDay) => isDay == 1;

  factory CurrentWeatherJson.fromJson(Map<String, dynamic> json) => _$CurrentWeatherJsonFromJson(json);
}
