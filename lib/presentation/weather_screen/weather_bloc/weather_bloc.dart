import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/domain/models/current_weather_forecast.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/presentation/weather_screen/hourly_weather_item_data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required this.latitude,
    required this.longitude,
  }) : super(WeatherLoading()) {
    on<LoadWeather>(_loadWeather);

    add(LoadWeather());
  }

  final double latitude;
  final double longitude;

  final WeatherRepository weatherRepository = WeatherRepositoryImpl();

  void _loadWeather(LoadWeather event, Emitter<WeatherState> emit) async {
    final weatherForecast = await weatherRepository.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
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
