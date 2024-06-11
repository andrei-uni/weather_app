import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/current_weather_forecast.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/presentation/current_weather_screen/hourly_weather_item_data.dart';
import 'package:weather_app/utils/locator.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  CurrentWeatherBloc({
    required this.coordinates,
  }) : super(WeatherLoading()) {
    on<LoadWeather>(_loadWeather);

    add(LoadWeather());
  }

  final Coordinates coordinates;

  final _weatherRepository = locator<WeatherRepository>();

  void _loadWeather(LoadWeather event, Emitter<CurrentWeatherState> emit) async {
    final weatherForecast = await _weatherRepository.getCurrentWeather(
      coordinates,
    );

    if (weatherForecast == null) {
      emit(WeatherLoadFail());
      return;
    }

    final pageController = PageController(
      initialPage: weatherForecast.location.localtime.hour ~/ 4,
      viewportFraction: 0.9,
    );

    emit(WeatherLoadSuccess(
      forecast: weatherForecast,
      hourlyWeatherPageController: pageController,
    ));
  }
}
