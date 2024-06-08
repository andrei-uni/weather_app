import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/datasources/weather_service/responses/day_json.dart';
import 'package:weather_app/data/datasources/weather_service/responses/hour_json.dart';

part 'forecast_day_json.g.dart';

@JsonSerializable(
  createToJson: false,
)
class ForecastDayJson {
  const ForecastDayJson({
    required this.day,
    required this.hours,
  });
  
  final DayJson day;

  @JsonKey(name: 'hour')
  final List<HourJson> hours;

  factory ForecastDayJson.fromJson(Map<String, dynamic> json) => _$ForecastDayJsonFromJson(json);
}
