import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/day_weather.dart';
import 'package:weather_app/domain/models/weekday.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/presentation/weekly_weather_screen/daily_weather_item_data.dart';
import 'package:weather_app/utils/translation_helper_extensions/weather_condition_translator_x.dart';
import 'package:weather_app/utils/translation_helper_extensions/weekday_translator_x.dart';

part 'weekly_weather_event.dart';
part 'weekly_weather_state.dart';

class WeeklyWeatherBloc extends Bloc<WeeklyWeatherEvent, WeeklyWeatherState> {
  WeeklyWeatherBloc({
    required this.coordinates,
  }) : super(WeatherLoading()) {
    on<LoadWeather>(_loadWeather);

    add(LoadWeather());
  }

  final Coordinates coordinates;

  final WeatherRepository weatherRepository = WeatherRepositoryImpl();

  void _loadWeather(LoadWeather event, Emitter<WeeklyWeatherState> emit) async {
    final weeklyWeather = await weatherRepository.getWeeklyWeather(
      coordinates,
    );

    if (weeklyWeather == null) {
      emit(WeatherLoadFail());
      return;
    }

    emit(WeatherLoadSuccess(
      dailyWeather: weeklyWeather.dailyWeather,
    ));
  }
}
