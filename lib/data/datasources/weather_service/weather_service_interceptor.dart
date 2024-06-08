import 'package:dio/dio.dart';

class WeatherServiceInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    //TODO
    options.queryParameters['key'] = '0f7cc8bd8fc745e9962160235240706';

    options.queryParameters['alerts'] = 'no';
    options.queryParameters['aqi'] = 'no';

    super.onRequest(options, handler);
  }
}
