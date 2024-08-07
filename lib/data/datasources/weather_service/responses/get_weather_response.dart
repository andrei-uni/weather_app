import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/datasources/weather_service/responses/current_weather_json.dart';
import 'package:weather_app/data/datasources/weather_service/responses/forecast_json.dart';
import 'package:weather_app/data/datasources/weather_service/responses/location_json.dart';

part 'get_weather_response.g.dart';

@JsonSerializable(
  createToJson: false,
)
class GetWeatherForecastResponse {
  const GetWeatherForecastResponse({
    required this.location,
    required this.current,
    required this.forecast,
  });

  final LocationJson location;

  final CurrentWeatherJson current;

  final ForecastJson forecast;

  factory GetWeatherForecastResponse.fromJson(Map<String, dynamic> json) => _$GetWeatherForecastResponseFromJson(json);
}
