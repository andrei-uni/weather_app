import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/datasources/weather_service/responses/location_json.dart';

part 'get_location_response.g.dart';

@JsonSerializable(
  createToJson: false,
)
class GetLocationResponse {
  const GetLocationResponse({
    required this.location,
  });

  final LocationJson location;

  factory GetLocationResponse.fromJson(Map<String, dynamic> json) => _$GetLocationResponseFromJson(json);
}
