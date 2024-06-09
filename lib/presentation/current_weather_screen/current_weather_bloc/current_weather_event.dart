part of 'current_weather_bloc.dart';

sealed class CurrentWeatherEvent {}

final class LoadWeather extends CurrentWeatherEvent {}
