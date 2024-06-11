import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/datasources/weather_service/responses/forecast_day_json.dart';

part 'forecast_json.g.dart';

@JsonSerializable(
  createToJson: false,
)
class ForecastJson {
  const ForecastJson({
    required this.forecastDays,
  });

  @JsonKey(name: 'forecastday')
  final List<ForecastDayJson> forecastDays;

  factory ForecastJson.fromJson(Map<String, dynamic> json) => _$ForecastJsonFromJson(json);
}
