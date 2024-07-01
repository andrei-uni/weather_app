import 'package:weather_app/domain/models/weather/daily_weather.dart';

class DailyForecast {
  DailyForecast({
    required this.dailyWeather,
  });

  final List<DailyWeather> dailyWeather;
}
