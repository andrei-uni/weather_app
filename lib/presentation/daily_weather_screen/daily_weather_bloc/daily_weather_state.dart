part of 'daily_weather_bloc.dart';

sealed class DailyWeatherState {}

final class WeatherLoading extends DailyWeatherState {}

final class WeatherLoadFail extends DailyWeatherState {
  WeatherLoadFail({
    required this.message,
  });

  final String message;
}

final class WeatherLoadSuccess extends DailyWeatherState {
  WeatherLoadSuccess({
    required this.dailyWeather,
  });

  final List<DailyWeather> dailyWeather;

  List<DailyWeatherItemData> get dailyWeatherItems {
    final int todayWeekday = DateTime.now().weekday - 1;

    final List<DailyWeatherItemData> result = [];

    for (var i = 0; i < dailyWeather.length; i++) {
      final DailyWeather dayWeather = dailyWeather[i];
      result.add(DailyWeatherItemData(
        label: Weekday.values[(todayWeekday + i) % 7].translateShort(),
        iconData: dayWeather.weatherCondition.toIcon(),
        condition: dayWeather.weatherCondition.translate(),
        dayTemp: dayWeather.dayTimeTemperature,
        nightTemp: dayWeather.nightTimeTemperature,
      ));
    }

    return result;
  }
}
