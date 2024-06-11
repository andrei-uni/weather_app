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

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  //TODO
  locator.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());

  locator.registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImpl());

  locator.registerSingleton<LocalCoordinatesRepository>(LocalCoordinatesRepositoryImpl());

  locator.registerSingleton<Dio>(
    Dio()
      ..interceptors.add(WeatherServiceInterceptor())
      // ..interceptors.add(PrettyDioLogger(
      //   responseBody: true,
      //   requestHeader: true,
      // )),
  );

  locator.registerSingleton<WeatherService>(WeatherService(locator<Dio>()));

  locator.registerSingleton<WeatherRepository>(WeatherRepositoryImpl());
}
