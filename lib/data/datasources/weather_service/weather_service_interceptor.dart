import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_app/utils/locator.dart';
import 'package:weather_app/utils/secure_storage_keys.dart';

class WeatherServiceInterceptor extends Interceptor {
  final _secureStorage = locator<FlutterSecureStorage>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final apiKey = await _secureStorage.read(key: SecureStorageKeys.weatherApiKey);

    options.queryParameters['key'] = apiKey;

    options.queryParameters['alerts'] = 'no';
    options.queryParameters['aqi'] = 'no';

    options.queryParameters['current_fields'] = [
      'temp_c',
      'code',
      'wind_kph',
      'humidity',
      'cloud',
    ].join(',');

    options.queryParameters['day_fields'] = [
      'avgtemp_c',
      'code',
    ].join(',');

    options.queryParameters['hour_fields'] = [
      'temp_c',
      'code',
    ].join(',');

    super.onRequest(options, handler);
  }
}
