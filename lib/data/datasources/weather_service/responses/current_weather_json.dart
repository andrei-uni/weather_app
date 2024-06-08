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
    required this.cloud,
  });

  @JsonKey(name: 'temp_c')
  final double tempCels;

  final WeatherConditionJson condition;
  
  @JsonKey(name: 'wind_kph')
  final double windKph;

  final int humidity;
  
  final int cloud;

  factory CurrentWeatherJson.fromJson(Map<String, dynamic> json) => _$CurrentWeatherJsonFromJson(json);
}
