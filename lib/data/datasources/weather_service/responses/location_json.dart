import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/datasources/weather_service/converters/local_time_converter.dart';

part 'location_json.g.dart';

@JsonSerializable(
  createToJson: false,
)
class LocationJson {
  const LocationJson({
    required this.name,
    required this.localtime,
  });
  
  final String name;

  @LocalTimeConverter()
  final DateTime localtime;

  factory LocationJson.fromJson(Map<String, dynamic> json) => _$LocationJsonFromJson(json);
}
