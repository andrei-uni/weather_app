import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/data/datasources/weather_service/weather_service.dart';
import 'package:weather_app/data/datasources/weather_service/weather_service_interceptor.dart';
import 'package:weather_app/data/repositories/authentication_repository_impl.dart';
import 'package:weather_app/data/repositories/local_locations_repository_impl.dart';
import 'package:weather_app/data/repositories/remote_weather_repository_impl.dart';
import 'package:weather_app/domain/repositories/authentication_repository.dart';
import 'package:weather_app/domain/repositories/local_locations_repository.dart';
import 'package:weather_app/domain/repositories/remote_weather_repository.dart';
import 'package:weather_app/domain/usecases/authentication/auth_status_stream_usecase.dart';
import 'package:weather_app/domain/usecases/authentication/log_in_usecase.dart';
import 'package:weather_app/domain/usecases/authentication/log_out_usecase.dart';
import 'package:weather_app/domain/usecases/local_locations/add_location_usecase.dart';
import 'package:weather_app/domain/usecases/local_locations/change_default_location_usecase.dart';
import 'package:weather_app/domain/usecases/local_locations/delete_location_usecase.dart';
import 'package:weather_app/domain/usecases/local_locations/get_all_locations_usecase.dart';
import 'package:weather_app/domain/usecases/local_locations/get_default_location_usecase.dart';
import 'package:weather_app/domain/usecases/weather/get_current_weather_forecast_usecase.dart';
import 'package:weather_app/domain/usecases/weather/get_daily_weather_forecast_usecase.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  locator.registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImpl());

  locator.registerSingleton<LocalLocationsRepository>(LocalLocationsRepositoryImpl());

  locator.registerSingleton<Dio>(Dio()..interceptors.add(WeatherServiceInterceptor())
      // ..interceptors.add(PrettyDioLogger(
      //   responseBody: true,
      //   requestHeader: true,
      // )),
      );

  locator.registerSingleton<WeatherService>(WeatherService(locator<Dio>()));

  locator.registerSingleton<RemoteWeatherRepository>(RemoteWeatherRepositoryImpl());

  locator.registerSingleton<AuthStatusStreamUsecase>(AuthStatusStreamUsecase());
  locator.registerLazySingleton<LogInUsecase>(() => LogInUsecase());
  locator.registerLazySingleton<LogOutUsecase>(() => LogOutUsecase());

  locator.registerSingleton<GetCurrentWeatherForecastUsecase>(GetCurrentWeatherForecastUsecase());
  locator.registerLazySingleton<GetDailyWeatherForecastUsecase>(
      () => GetDailyWeatherForecastUsecase());

  locator.registerSingleton<GetDefaultLocationUsecase>(GetDefaultLocationUsecase());
  locator.registerLazySingleton<AddLocationUsecase>(() => AddLocationUsecase());
  locator.registerLazySingleton<GetAllLocationsUsecase>(() => GetAllLocationsUsecase());
  locator.registerLazySingleton<DeleteLocationUsecase>(() => DeleteLocationUsecase());
  locator.registerLazySingleton<ChangeDefaultLocationUsecase>(() => ChangeDefaultLocationUsecase());
}
