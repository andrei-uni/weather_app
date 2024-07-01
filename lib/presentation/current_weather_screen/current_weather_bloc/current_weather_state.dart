part of 'current_weather_bloc.dart';

sealed class CurrentWeatherState {}

final class WeatherLoading extends CurrentWeatherState {}

final class WeatherLoadFail extends CurrentWeatherState {
  WeatherLoadFail({
    required this.message,
  });

  String message;
}

final class WeatherLoadSuccess extends CurrentWeatherState {
  WeatherLoadSuccess({
    required this.forecast,
    required this.hourlyWeatherPageController,
    required this.coordinates,
  });

  final CurrentWeatherForecast forecast;
  final PageController hourlyWeatherPageController;
  final Coordinates? coordinates;

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
    final List<HourlyWeatherItemData> result = [];
    final int startHour = _hourItemsPerPage * pageIndex;

    for (var i = startHour; i < startHour + _hourItemsPerPage; i++) {
      final Weather hour = forecast.hourlyWeather[i];
      result.add(HourlyWeatherItemData(
        temperature: hour.temperature,
        iconData: hour.weatherCondition.toIcon(),
        time: '$i:00',
        isCurrent: forecast.location.localtime.hour == i,
      ));
    }

    return result;
  }
}
