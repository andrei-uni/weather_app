import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/datasources/weather_service/responses/error_json.dart';

part 'error_response.g.dart';

@JsonSerializable(
  createToJson: false,
)
class ErrorResponse {
  const ErrorResponse({
    required this.error,
  });

  final ErrorJson error;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
}
