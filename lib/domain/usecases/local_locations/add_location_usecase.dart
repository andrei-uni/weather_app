import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/location.dart';
import 'package:weather_app/domain/repositories/local_locations_repository.dart';
import 'package:weather_app/domain/repositories/remote_weather_repository.dart';
import 'package:weather_app/utils/locator.dart';

class AddLocationUsecase {
  final _localLocationsRepository = locator<LocalLocationsRepository>();
  final _remoteWeatherRepository = locator<RemoteWeatherRepository>();

  Future<Location?> call(Coordinates coordinates) async {
    final String? name = await _remoteWeatherRepository.getLocationNameByCoordinates(coordinates);

    if (name == null) {
      return null;
    }

    final Location location = await _localLocationsRepository.addLocation(name, coordinates);
    
    return location;
  }
}
