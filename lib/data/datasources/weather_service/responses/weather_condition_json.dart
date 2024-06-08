import 'package:json_annotation/json_annotation.dart';

part 'weather_condition_json.g.dart';

@JsonSerializable(
  createToJson: false,
)
class WeatherConditionJson {
  const WeatherConditionJson({
    required this.code,
  });
  
  final int code;

  factory WeatherConditionJson.fromJson(Map<String, dynamic> json) => _$WeatherConditionJsonFromJson(json);
}
