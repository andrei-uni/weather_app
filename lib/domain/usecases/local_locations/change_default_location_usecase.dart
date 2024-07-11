import 'package:weather_app/domain/models/location.dart';
import 'package:weather_app/domain/repositories/local_locations_repository.dart';
import 'package:weather_app/utils/locator.dart';

class ChangeDefaultLocationUsecase {
  final _localLocationsRepository = locator<LocalLocationsRepository>();

  Future<void> call(Location location) async {
    await _localLocationsRepository.changeDefaultLocation(location.id);
  }
}
