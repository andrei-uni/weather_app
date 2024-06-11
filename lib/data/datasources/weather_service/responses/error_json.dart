import 'package:json_annotation/json_annotation.dart';

part 'error_json.g.dart';

@JsonSerializable(
  createToJson: false,
)
class ErrorJson {
  const ErrorJson({
    required this.code,
    required this.message,
  });
  
  final int code;

  final String message;

  factory ErrorJson.fromJson(Map<String, dynamic> json) => _$ErrorJsonFromJson(json);
}
