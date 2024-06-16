import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/datasources/weather_service/weather_service.dart';
import 'package:weather_app/data/datasources/weather_service/weather_service_interceptor.dart';
import 'package:weather_app/data/repositories/authentication_repository_impl.dart';
import 'package:weather_app/data/repositories/local_coordinates_repository_impl.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/domain/repositories/authentication_repository.dart';
import 'package:weather_app/domain/repositories/local_coordinates_repository.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/domain/usecases/authentication/auth_status_stream_usecase.dart';
import 'package:weather_app/domain/usecases/authentication/log_in_usecase.dart';
import 'package:weather_app/domain/usecases/authentication/log_out_usecase.dart';
import 'package:weather_app/domain/usecases/local_coordinates/add_coordinates_usecase.dart';
import 'package:weather_app/domain/usecases/local_coordinates/get_coordinates_usecase.dart';
import 'package:weather_app/domain/usecases/weather/get_current_weather_usecase.dart';
import 'package:weather_app/domain/usecases/weather/get_weekly_weather_usecase.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  locator.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());

  locator.registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImpl());

  locator.registerSingleton<LocalCoordinatesRepository>(LocalCoordinatesRepositoryImpl());

  locator.registerSingleton<Dio>(Dio()..interceptors.add(WeatherServiceInterceptor())
      // ..interceptors.add(PrettyDioLogger(
      //   responseBody: true,
      //   requestHeader: true,
      // )),
      );

  locator.registerSingleton<WeatherService>(WeatherService(locator<Dio>()));

  locator.registerSingleton<WeatherRepository>(WeatherRepositoryImpl());

  locator.registerSingleton<AuthStatusStreamUsecase>(AuthStatusStreamUsecase());
  locator.registerLazySingleton<LogInUsecase>(() => LogInUsecase());
  locator.registerLazySingleton<LogOutUsecase>(() => LogOutUsecase());

  locator.registerSingleton<GetCurrentWeatherUsecase>(GetCurrentWeatherUsecase());
  locator.registerLazySingleton<GetWeeklyWeatherUsecase>(() => GetWeeklyWeatherUsecase());

  locator.registerSingleton<GetCoordinatesUsecase>(GetCoordinatesUsecase());
  locator.registerLazySingleton<AddCoordinatesUsecase>(() => AddCoordinatesUsecase());
}
