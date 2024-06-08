import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/datasources/weather_service/responses/weather_condition_json.dart';

part 'day_json.g.dart';

@JsonSerializable(
  createToJson: false,
)
class DayJson {
  const DayJson({
    required this.avgTempCels,
    required this.condition,
  });

  @JsonKey(name: 'avgtemp_c')
  final double avgTempCels;

  final WeatherConditionJson condition;

  factory DayJson.fromJson(Map<String, dynamic> json) => _$DayJsonFromJson(json);
}
