part of 'daily_weather_bloc.dart';

final DailyForecast _fakeDailyForecast = DailyForecast(
  dailyWeather: List.filled(
    _days,
    const DailyWeather(
      dayTimeTemperature: 10,
      nightTimeTemperature: 10,
      weatherCondition: WeatherCondition.clouds,
    ),
  ),
);
