part of 'weather_bloc.dart';

sealed class WeatherState {}

final class WeatherLoading extends WeatherState {}

//TODO
final class WeatherLoadFail extends WeatherState {}

final class WeatherLoadSuccess extends WeatherState {
  WeatherLoadSuccess({
    required this.forecast,
    required this.hourlyWeatherPageController,
  });

  final CurrentWeatherForecast forecast;
  final PageController hourlyWeatherPageController;

  String get windSpeedString {
    return "${forecast.currentMetrics.windSpeed.toInt()} km/h";
  }

  String get humidityString {
    return "${forecast.currentMetrics.humidity}%";
  }

  String get cloudinessString {
    return "${forecast.currentMetrics.cloudiness}%";
  }

  List<HourlyWeatherItemData> getHourlyWeather(int pageIndex) {
    final result = <HourlyWeatherItemData>[];

    for (var i = 4 * pageIndex; i < 4 * (pageIndex + 1); i++) {
      final hour = forecast.hourlyWeather[i];
      result.add(HourlyWeatherItemData(
        temperature: hour.temperature,
        iconData: Icons.cloud,
        time: '$i:00',
        isCurrent: forecast.location.localtime.hour == i,
      ));
    }

    return result;
  }
}
