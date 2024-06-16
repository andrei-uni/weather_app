import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_type/result_type.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/day_weather.dart';
import 'package:weather_app/domain/models/weather_error.dart';
import 'package:weather_app/domain/models/weekday.dart';
import 'package:weather_app/domain/models/weekly_weather_forecast.dart';
import 'package:weather_app/domain/usecases/weather/get_weekly_weather_usecase.dart';
import 'package:weather_app/presentation/weekly_weather_screen/daily_weather_item_data.dart';
import 'package:weather_app/utils/extensions/weather_condition_to_icon_x.dart';
import 'package:weather_app/utils/locator.dart';
import 'package:weather_app/utils/extensions/translation_helper_extensions/weather_condition_translator_x.dart';
import 'package:weather_app/utils/extensions/translation_helper_extensions/weather_error_translator_x.dart';
import 'package:weather_app/utils/extensions/translation_helper_extensions/weekday_translator_x.dart';

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

  final _getWeeklyWeatherUsecase = locator<GetWeeklyWeatherUsecase>();

  void _loadWeather(LoadWeather event, Emitter<WeeklyWeatherState> emit) async {
    emit(WeatherLoading());

    final Result<WeeklyWeatherForecast, WeatherError> weeklyWeatherResult =
        await _getWeeklyWeatherUsecase(coordinates);

    if (weeklyWeatherResult.isFailure) {
      emit(WeatherLoadFail(
        message: weeklyWeatherResult.failure.translate(),
      ));
      return;
    }

    emit(WeatherLoadSuccess(
      dailyWeather: weeklyWeatherResult.success.dailyWeather,
    ));
  }
}
