import 'package:weather_app/data/datasources/weather_service/responses/error_json.dart';
import 'package:weather_app/domain/models/errors/weather_error.dart';

extension ErrorMapper on ErrorJson {
  WeatherError toModel() {
    return switch (code) {
      1006 => InvalidLocation(),
      2006 => KeyInvalid(),
      2007 => KeyQuotaExceeded(),
      2008 => KeyDisabled(),
      9999 => InternalServerError(),
      _ => UnknownError(message: message),
    };
  }
}
