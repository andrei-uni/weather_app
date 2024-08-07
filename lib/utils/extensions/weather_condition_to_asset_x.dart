import 'package:weather_app/domain/models/weather/weather_condition.dart';

extension WeatherConditionToAssetX on WeatherCondition {
  String toAsset() {
    final imageName = switch (this) {
      WeatherCondition.clearDay => 'Sun.png',
      WeatherCondition.clearNight => 'Moon_Stars.png',
      WeatherCondition.clouds => 'Cloud_Basic.png',
      WeatherCondition.drizzle => 'Cloud_Rain.png',
      WeatherCondition.rain => 'Cloud_Rain.png',
      WeatherCondition.thunderstorm => 'Lightning.png',
      WeatherCondition.snow => 'Snow.png',
      WeatherCondition.fog => 'Cloud_Fog.png',
      WeatherCondition.mist => 'Cloud_Fog.png',
      WeatherCondition.unknown => 'Error.png',
    };
    return 'assets/weather_images/$imageName';
  }
}
