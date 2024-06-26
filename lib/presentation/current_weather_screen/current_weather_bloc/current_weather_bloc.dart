import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_type/result_type.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/current_weather_forecast.dart';
import 'package:weather_app/domain/models/weather.dart';
import 'package:weather_app/domain/models/weather_error.dart';
import 'package:weather_app/domain/usecases/local_coordinates/get_coordinates_usecase.dart';
import 'package:weather_app/domain/usecases/weather/get_current_weather_usecase.dart';
import 'package:weather_app/presentation/current_weather_screen/hourly_weather_item_data.dart';
import 'package:weather_app/utils/extensions/weather_condition_to_icon_x.dart';
import 'package:weather_app/utils/locator.dart';
import 'package:weather_app/utils/extensions/translation_helper_extensions/weather_error_translator_x.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  CurrentWeatherBloc({
    this.coordinates,
  }) : super(WeatherLoading()) {
    on<LoadWeather>(_loadWeather);

    add(LoadWeather());
  }

  Coordinates? coordinates;

  final _getCoordinatesUsecase = locator<GetCoordinatesUsecase>();
  final _getCurrentWeatherUsecase = locator<GetCurrentWeatherUsecase>();

  void _loadWeather(LoadWeather event, Emitter<CurrentWeatherState> emit) async {
    emit(WeatherLoading());

    coordinates ??= await _getCoordinatesUsecase();

    final Result<CurrentWeatherForecast, WeatherError> currentWeatherResult =
        await _getCurrentWeatherUsecase(coordinates!);

    if (currentWeatherResult.isFailure) {
      emit(WeatherLoadFail(
        message: currentWeatherResult.failure.translate(),
      ));
      return;
    }

    final CurrentWeatherForecast forecast = currentWeatherResult.success;

    final pageController = PageController(
      initialPage: forecast.location.localtime.hour ~/ 4,
      viewportFraction: 0.9,
    );

    emit(WeatherLoadSuccess(
      forecast: forecast,
      hourlyWeatherPageController: pageController,
      coordinates: coordinates,
    ));
  }
}
