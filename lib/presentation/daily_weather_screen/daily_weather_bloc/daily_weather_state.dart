part of 'daily_weather_bloc.dart';

sealed class DailyWeatherStateBase {}

final class DailyWeatherStateLoadFail extends DailyWeatherStateBase {
  DailyWeatherStateLoadFail({
    required this.errorMessage,
  });

  final String errorMessage;
}

final class DailyWeatherState extends DailyWeatherStateBase {
  DailyWeatherState({
    required this.dailyForecast,
    required this.isLoading,
  });

  DailyWeatherState.loading()
      : this(
          dailyForecast: _fakeDailyForecast,
          isLoading: true,
        );

  final DailyForecast dailyForecast;
  final bool isLoading;

  int get days => dailyForecast.dailyWeather.length;

  List<DailyWeatherItemData> get dailyWeatherItems {
    final int todayWeekday = DateTime.now().weekday - 1;

    final List<DailyWeatherItemData> result = [
      for (final (DailyWeather dailyWeather, int index) in dailyForecast.dailyWeather.enumerate())
        DailyWeatherItemData(
          label: Weekday.values[(todayWeekday + index) % 7].translateShort(),
          icon: dailyWeather.weatherCondition.toIcon(),
          condition: dailyWeather.weatherCondition.translate(),
          dayTemp: dailyWeather.dayTimeTemperature,
          nightTemp: dailyWeather.nightTimeTemperature,
        ),
    ];

    return result;
  }
}
