import 'package:weather_app/domain/models/location.dart';
import 'package:weather_app/domain/repositories/local_locations_repository.dart';
import 'package:weather_app/utils/locator.dart';

class GetDefaultLocationUsecase {
  final _localLocationsRepository = locator<LocalLocationsRepository>();

  Future<Location> call() async {
    return await _localLocationsRepository.getDefaultLocation();
  }
}
