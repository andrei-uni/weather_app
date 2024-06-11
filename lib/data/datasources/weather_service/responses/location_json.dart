import 'package:json_annotation/json_annotation.dart';

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

  final String localtime;

  factory LocationJson.fromJson(Map<String, dynamic> json) => _$LocationJsonFromJson(json);
}
