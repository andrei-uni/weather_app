part of 'current_weather_bloc.dart';

final CurrentWeatherForecast _fakeForecast = CurrentWeatherForecast(
  localtime: DateTime(2000, 1, 1, 10),
  weather: const Weather(temperature: 10, weatherCondition: WeatherCondition.clearDay),
  currentMetrics: const WeatherMetrics(windSpeed: 10, humidity: 10, cloudiness: 10),
  hourlyWeather: List.filled(
    24,
    const Weather(temperature: 10, weatherCondition: WeatherCondition.clearDay),
  ),
);

final PageController _fakeHourlyWeatherPageController = PageController(
  initialPage: 0,
  viewportFraction: 0.9,
);

Location _getFakeLocation({
  required String? locationName,
}) {
  return Location(
    id: 0,
    name: locationName ?? '',
    coordinates: const Coordinates(latitude: 0, longitude: 0),
  );
}
