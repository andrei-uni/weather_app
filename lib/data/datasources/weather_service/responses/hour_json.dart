import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/datasources/weather_service/responses/weather_condition_json.dart';

part 'hour_json.g.dart';

@JsonSerializable(
  createToJson: false,
)
class HourJson {
  const HourJson({
    required this.tempCels,
    required this.condition,
    required this.isDay,
  });

  @JsonKey(name: 'temp_c')
  final double tempCels;

  final WeatherConditionJson condition;

  @JsonKey(name: 'is_day', fromJson: _boolFromInt)
  final bool isDay;
  
  static bool _boolFromInt(int isDay) => isDay == 1;

  factory HourJson.fromJson(Map<String, dynamic> json) => _$HourJsonFromJson(json);
}
