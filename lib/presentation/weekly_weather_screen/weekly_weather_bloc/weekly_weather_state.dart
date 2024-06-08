part of 'weekly_weather_bloc.dart';

sealed class WeeklyWeatherState {}

final class WeatherLoading extends WeeklyWeatherState {}

//TODO
final class WeatherLoadFail extends WeeklyWeatherState {}

final class WeatherLoadSuccess extends WeeklyWeatherState {
  WeatherLoadSuccess({
    required this.dailyWeather,
  });

  final List<DayWeather> dailyWeather;

  List<DailyWeatherItemData> get dailyWeatherItems {
    final todayWeekday = DateTime.now().weekday - 1;

    final result = <DailyWeatherItemData>[];

    for (var i = 0; i < 7; i++) {
      final dayWeather = dailyWeather[i];
      result.add(DailyWeatherItemData(
        label: Weekday.values[(todayWeekday + i) % 7].translateShort(), 
        iconData: Icons.cloud,//TODO
        condition: dayWeather.weatherCondition.translate(),
        dayTemp: dayWeather.dayTimeTemperature,
        nightTemp: dayWeather.nightTimeTemperature,
      ));
    }

    return result;
  }
}