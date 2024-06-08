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
  });

  @JsonKey(name: 'temp_c')
  final double tempCels;

  final WeatherConditionJson condition;

  factory HourJson.fromJson(Map<String, dynamic> json) => _$HourJsonFromJson(json);
}
