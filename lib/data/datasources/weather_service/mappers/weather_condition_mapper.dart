import 'package:flutter/foundation.dart';
import 'package:weather_app/data/datasources/weather_service/responses/weather_condition_json.dart';
import 'package:weather_app/domain/models/weather/weather_condition.dart';

extension WeatherConditionMapper on WeatherConditionJson {
  WeatherCondition toModel({required bool isDay}) {
    switch (code) {
      case 1000:
        return isDay ? WeatherCondition.clearDay : WeatherCondition.clearNight;
      case 1003:
      case 1006:
      case 1009:
        return WeatherCondition.clouds;
      case 1030:
        return WeatherCondition.mist;
      case 1063:
        return WeatherCondition.rain;
      case 1066:
      case 1069:
        return WeatherCondition.snow;
      case 1072:
        return WeatherCondition.drizzle;
      case 1087:
      case 1114:
      case 1117:
        return WeatherCondition.thunderstorm;
      case 1135:
      case 1147:
        return WeatherCondition.fog;
      case 1150:
      case 1153:
      case 1168:
      case 1171:
        return WeatherCondition.drizzle;
      case 1180:
      case 1183:
      case 1186:
      case 1189:
      case 1192:
      case 1195:
      case 1198:
      case 1201:
      case 1204:
      case 1207:
        return WeatherCondition.rain;
      case 1210:
      case 1213:
      case 1216:
      case 1219:
      case 1222:
      case 1225:
      case 1237:
        return WeatherCondition.snow;
      case 1240:
      case 1243:
      case 1246:
      case 1252:
        return WeatherCondition.rain;
      case 1255:
      case 1258:
      case 1261:
      case 1264:
        return WeatherCondition.snow;
      case 1273:
      case 1276:
      case 1279:
      case 1282:
        return WeatherCondition.thunderstorm;
      default:
        if (kDebugMode) {
          debugPrint('UNKNOWN WEATHER CODE $code.');
        }
        return WeatherCondition.unknown;
    }
  }
}
