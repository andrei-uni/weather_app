import 'package:weather_app/domain/models/weather_condition.dart';

extension WeatherToAssetX on WeatherCondition {
  String toAsset() {
    final name = switch (this) {
      //TODO isDay
      WeatherCondition.clear => 'Sun.png',
      WeatherCondition.clouds => 'Cloud_Basic.png',
      WeatherCondition.drizzle => 'Cloud_Rain.png',
      WeatherCondition.rain => 'Cloud_Rain.png',
      WeatherCondition.thunderstorm => 'Lightning.png',
      WeatherCondition.snow => 'Snow.png',
      WeatherCondition.fog => 'Cloud_Fog.png',
      WeatherCondition.mist => 'Cloud_Fog.png',
      WeatherCondition.unknown => '', //TODO
    };
    return 'assets/weather_images/$name';
  }
}
