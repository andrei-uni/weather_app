import 'package:weather_app/domain/models/day_weather.dart';

class WeeklyWeatherForecast {
  WeeklyWeatherForecast({
    required this.dailyWeather,
  }) : assert(dailyWeather.length == 7);

  final List<DayWeather> dailyWeather;
}
