part of 'current_weather_bloc.dart';

sealed class CurrentWeatherStateBase {}

final class CurrentWeatherStateLoadFail extends CurrentWeatherStateBase {
  CurrentWeatherStateLoadFail({
    required this.errorMessage,
  });

  final String errorMessage;
}

final class CurrentWeatherState extends CurrentWeatherStateBase {
  CurrentWeatherState({
    required this.forecast,
    required this.hourlyWeatherPageController,
    required this.location,
    required this.isLoading,
  });

  CurrentWeatherState.loading({
    required String? locationName,
  }) : this(
          forecast: _fakeForecast,
          hourlyWeatherPageController: _fakeHourlyWeatherPageController,
          location: _getFakeLocation(locationName: locationName),
          isLoading: true,
        );

  final CurrentWeatherForecast forecast;
  final PageController hourlyWeatherPageController;
  final Location location;
  final bool isLoading;

  String get windSpeedString {
    return "${forecast.currentMetrics.windSpeed.round()} km/h";
  }

  String get humidityString {
    return "${forecast.currentMetrics.humidity}%";
  }

  String get cloudinessString {
    return "${forecast.currentMetrics.cloudiness}%";
  }

  List<HourlyWeatherItemData> getHourlyWeatherItems(int pageIndex) {
    final List<HourlyWeatherItemData> result = [];
    final int startHour = _hourItemsPerPage * pageIndex;

    for (var i = startHour; i < startHour + _hourItemsPerPage; i++) {
      final Weather hour = forecast.hourlyWeather[i];
      result.add(HourlyWeatherItemData(
        temperature: hour.temperature,
        icon: hour.weatherCondition.toIcon(),
        time: '$i:00',
        isCurrent: forecast.localtime.hour == i,
      ));
    }

    return result;
  }
}
