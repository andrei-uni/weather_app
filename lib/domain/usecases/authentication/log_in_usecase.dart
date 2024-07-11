import 'package:weather_app/domain/models/location.dart';
import 'package:weather_app/domain/repositories/authentication_repository.dart';
import 'package:weather_app/domain/repositories/local_locations_repository.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/locator.dart';

class LogInUsecase {
  final _authenticationRepository = locator<AuthenticationRepository>();
  final _localLocationsRepository = locator<LocalLocationsRepository>();

  Future<void> call({required String apiKey}) async {
    final Location location = await _localLocationsRepository.addLocation(
      Constants.initialLocation.name,
      Constants.initialLocation.coordinates,
    );
    await _localLocationsRepository.changeDefaultLocation(location.id);
    
    await _authenticationRepository.logIn(apiKey: apiKey);
  }
}
