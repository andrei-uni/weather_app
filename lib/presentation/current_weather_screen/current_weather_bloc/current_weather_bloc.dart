import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_type/result_type.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/location.dart';
import 'package:weather_app/domain/models/weather/current_weather_forecast.dart';
import 'package:weather_app/domain/models/weather/weather.dart';
import 'package:weather_app/domain/models/errors/weather_error.dart';
import 'package:weather_app/domain/models/weather/weather_condition.dart';
import 'package:weather_app/domain/models/weather/weather_metrics.dart';
import 'package:weather_app/domain/usecases/local_locations/get_default_location_usecase.dart';
import 'package:weather_app/domain/usecases/weather/get_current_weather_forecast_usecase.dart';
import 'package:weather_app/presentation/current_weather_screen/hourly_weather_widget/hourly_weather_item_data.dart';
import 'package:weather_app/utils/extensions/weather_condition_to_icon_x.dart';
import 'package:weather_app/utils/locator.dart';
import 'package:weather_app/utils/extensions/translation_helper_extensions/weather_error_translator_x.dart';

part '_fake_current_weather_state_data.dart';
part 'current_weather_event.dart';
part 'current_weather_state.dart';

const int _hourItemsPerPage = 4;

class CurrentWeatherBloc extends Bloc<CurrentWeatherEvent, CurrentWeatherStateBase> {
  CurrentWeatherBloc({
    this.location,
  }) : super(CurrentWeatherState.loading(locationName: location?.name)) {
    on<LoadWeather>(_loadWeather);

    add(LoadWeather());
  }

  Location? location;

  final _getDefaultLocationUsecase = locator<GetDefaultLocationUsecase>();
  final _getCurrentWeatherForecastUsecase = locator<GetCurrentWeatherForecastUsecase>();

  void _loadWeather(LoadWeather event, Emitter<CurrentWeatherStateBase> emit) async {
    location ??= await _getDefaultLocationUsecase();

    emit(CurrentWeatherState.loading(locationName: location!.name));

    final Result<CurrentWeatherForecast, WeatherError> currentWeatherResult =
        await _getCurrentWeatherForecastUsecase(location!.coordinates);

    if (currentWeatherResult.isFailure) {
      final WeatherError error = currentWeatherResult.failure;
      return emit(CurrentWeatherStateLoadFail(
        errorMessage: error.translate(),
      ));
    }

    final CurrentWeatherForecast forecast = currentWeatherResult.success;

    final hourlyWeatherPageController = PageController(
      initialPage: forecast.localtime.hour ~/ _hourItemsPerPage,
      viewportFraction: 0.9,
    );

    emit(CurrentWeatherState(
      forecast: forecast,
      hourlyWeatherPageController: hourlyWeatherPageController,
      location: location!,
      isLoading: false,
    ));
  }
}
