import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_type/result_type.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/weather/daily_weather.dart';
import 'package:weather_app/domain/models/errors/weather_error.dart';
import 'package:weather_app/domain/models/weather/weather_condition.dart';
import 'package:weather_app/domain/models/weekday.dart';
import 'package:weather_app/domain/models/weather/daily_forecast.dart';
import 'package:weather_app/domain/usecases/weather/get_daily_weather_forecast_usecase.dart';
import 'package:weather_app/presentation/daily_weather_screen/daily_weather_item_data.dart';
import 'package:weather_app/utils/extensions/enumerate_iterable_x.dart';
import 'package:weather_app/utils/extensions/weather_condition_to_icon_x.dart';
import 'package:weather_app/utils/locator.dart';
import 'package:weather_app/utils/extensions/translation_helper_extensions/weather_condition_translator_x.dart';
import 'package:weather_app/utils/extensions/translation_helper_extensions/weather_error_translator_x.dart';
import 'package:weather_app/utils/extensions/translation_helper_extensions/weekday_translator_x.dart';

part '_fake_daily_weather_state_data.dart';
part 'daily_weather_event.dart';
part 'daily_weather_state.dart';

const int _days = 3; // api limitation

class DailyWeatherBloc extends Bloc<DailyWeatherEvent, DailyWeatherStateBase> {
  DailyWeatherBloc({
    required this.coordinates,
  }) : super(DailyWeatherState.loading()) {
    on<LoadWeather>(_loadWeather);

    add(LoadWeather());
  }

  final Coordinates coordinates;

  final _getDailyWeatherForecastUsecase = locator<GetDailyWeatherForecastUsecase>();

  void _loadWeather(LoadWeather event, Emitter<DailyWeatherStateBase> emit) async {
    emit(DailyWeatherState.loading());

    final Result<DailyForecast, WeatherError> dailyForecastResult =
        await _getDailyWeatherForecastUsecase(coordinates, days: _days);

    if (dailyForecastResult.isFailure) {
      final WeatherError error = dailyForecastResult.failure;
      return emit(DailyWeatherStateLoadFail(
        errorMessage: error.translate(),
      ));
    }

    emit(DailyWeatherState(
      dailyForecast: dailyForecastResult.success,
      isLoading: false,
    ));
  }
}
